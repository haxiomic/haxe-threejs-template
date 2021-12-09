package shaders;

import js.html.webgl.RenderingContext;
import three.Texture;
import three.Uniform;
import three.Vector2;
import three.RawShaderMaterial;

/**
	Author: haxiomic
	This class was first written in TypeScript during my time at Microsoft, it was later merged into Babylon.js
**/
class Blur1D extends RawShaderMaterial {

	static public inline function get(ctx: RenderingContext, kernel: Float, truncationSigma: Float, directionX: Float, directionY: Float, texture: Texture, width: Float, height: Float) {
		kernel = nearestBestKernel(kernel);
		var key = '$kernel@$directionX@$directionY@$truncationSigma';
		var instance = instances.get(key);
		if (instance == null) {
			instance = new Blur1D(ctx, kernel, truncationSigma, directionX, directionY, true);
			instances.set(key, instance);
		}
		instance.uTexture.value = texture;
		instance.uTexelSize.value.set(1/width, 1/height);
		return instance;
	}

	static final instances = new Map<String, Blur1D>();

	public final uTexture: Uniform<Texture>;
	public final uTexelSize: Uniform<Vector2>;
	public final kernel: Float;
	public final directionX: Float;
	public final directionY: Float;

	public function new(ctx: RenderingContext, kernel: Float, truncationSigma: Float, directionX: Float, directionY: Float, linearSampling: Bool) {
		var uTexture = new Uniform(null);
		var uTexelSize = new Uniform(new Vector2(1,1));
		var shaderParts = generateShaderParts(ctx, kernel, truncationSigma, directionX, directionY, linearSampling);
		var precision = 'mediump';
		super({
			uniforms: {
				texture: uTexture,
				invResolution: uTexelSize,
			},
			vertexShader: '
				precision $precision float;
				attribute vec2 position;

				uniform vec2 invResolution;

				\n${shaderParts.varyingDeclarations.join('\n')}

				const vec2 madd = vec2(0.5, 0.5);

				void main() {
					vec2 texelCoord = (position * madd + madd);

					\n${shaderParts.varyingValues.join('\n')}

					gl_Position = vec4(position, 0.0, 1.);
				}
			',
			fragmentShader: '
				precision $precision float;
				uniform sampler2D texture;

				\n${shaderParts.fragmentDeclarations.join('\n')}

				\n${shaderParts.varyingDeclarations.join('\n')}

				void main() {
					\n${shaderParts.fragmentVariables.join('\n')}

					vec4 blend = vec4(0.0);
					\n${shaderParts.textureSamples.join('\n')};
					gl_FragColor = blend;
				}
			',
		});

		this.uTexture = uTexture;
		this.uTexelSize = uTexelSize;
		this.kernel = kernel;
		this.directionX = directionX;
		this.directionY = directionY;
	}

	static function generateShaderParts(ctx: RenderingContext, kernel: Float, truncationSigma: Float, directionX: Float, directionY: Float, linearSampling: Bool) {
		// Generate sampling offsets and weights
		var N = nearestBestKernel(kernel);

		var centerIndex = (N - 1) / 2;

		// Generate Gaussian sampling weights over kernel
		var offsets = new Array();
		var weights = new Array();
		var totalWeight = 0.0;
		for (i in 0...N) {
			var u = i / (N - 1);
			var w = gaussianWeight(u * 2.0 - 1, truncationSigma);
			offsets[i] = (i - centerIndex);
			weights[i] = w;
			totalWeight += w;
		}

		// Normalize weights
		for (i in 0...weights.length) {
			weights[i] /= totalWeight;
		}

		/**
			Optimize: combine samples to take advantage of hardware linear sampling
		 	Let weights of two samples be A and B
		 	Then the sum of the samples: `Ax + By`
		 	Can be represented with a single lerp sample a (distance to sample x), with new weight W
		 		`Ax + By = W((1-a)x + ay)`
			Solving for W, a in terms of A, B:
				`W = A + B`
				`a = B/(A + B)`
		**/
		var optimizeSamples = linearSampling;
		if (optimizeSamples) {
			var lerpSampleOffsets = new Array<Float>();
			var lerpSampleWeights = new Array<Float>();
			var i = 0;
			while(i < N) {
				var A = weights[i];
				var leftOffset = offsets[i];

				if ((i + 1) < N) {
					// there is a pair to combine with
					var B = weights[i + 1];

					var lerpWeight = A + B;
					var alpha = B/(A + B);
					var lerpOffset = leftOffset + alpha;

					lerpSampleOffsets.push(lerpOffset);
					lerpSampleWeights.push(lerpWeight);
				} else {
					lerpSampleOffsets.push(leftOffset);
					lerpSampleWeights.push(A);
				}

				i += 2;
			}

			// replace with optimized
			offsets = lerpSampleOffsets;
			weights = lerpSampleWeights;
		}

		// Generate shaders
		var maxVaryingRows = ctx.getParameter(RenderingContext.MAX_VARYING_VECTORS);
		var maxVaryingVec2 = maxVaryingRows; // maybe more in practice?

		var varyingCount = Std.int(Math.min(offsets.length, maxVaryingVec2));

		var varyingDeclarations = [
			for (i in 0...varyingCount)
				'varying vec2 sampleCoord$i;'
		];

		var varyingValues = [
			for (i in 0...varyingCount)
				'sampleCoord$i = texelCoord + vec2(${glslFloat(offsets[i] * directionX)}, ${glslFloat(offsets[i] * directionY)}) * invResolution;'
		];

		var fragmentVariables = [
			for (i in varyingCount...offsets.length)
				'vec2 sampleCoord$i = sampleCoord0 + vec2(${glslFloat((offsets[i] - offsets[0]) * directionX)}, ${glslFloat((offsets[i] - offsets[0]) * directionY)}) * invResolution;'
		];

		var textureSamples = [
			for (i in 0...offsets.length)
				'blend += texture2D(texture, sampleCoord$i) * ${glslFloat(weights[i])};'
		];

		return {
			varyingDeclarations: varyingDeclarations,
			varyingValues: varyingValues,
			fragmentDeclarations: varyingCount < offsets.length ? ['uniform vec2 invResolution;'] : [''],
			fragmentVariables: fragmentVariables,
			textureSamples: textureSamples,
		};
	}

	/**
		Best kernels are odd numbers that when divided by 2, their integer part is even, so 5, 9 or 13.
		Other odd kernels optimize correctly but require proportionally more samples, even kernels are
		possible but will produce minor visual artifacts. Since each new kernel requires a new shader we
		want to minimize kernel changes, having gaps between physical kernels is helpful in that regard.
		The gaps between physical kernels are compensated for in the weighting of the samples
	**/
	static function nearestBestKernel(idealKernel: Float): Int {
		var v = Math.round(idealKernel);

		for (k in [v, v - 1, v + 1, v - 2, v + 2]) {
			if (((k % 2) != 0) && ((Math.floor(k / 2) % 2) == 0) && k > 0) {
				return Std.int(Math.max(k, 3));
			}
		}
		return Std.int(Math.max(v, 3));
	}

	/**
		Calculates the value of a Gaussian distribution with sigma 3 at a given point.
	**/
	static function gaussianWeight(x: Float, truncationSigma: Float) {
		var sigma = truncationSigma;
		var denominator = Math.sqrt(2.0 * Math.PI) * sigma;
		var exponent = -((x * x) / (2.0 * sigma * sigma));
		var weight = (1.0 / denominator) * Math.exp(exponent);
		return weight;
	}

	/**
		Convert a float to a string ensuring a '.' is included
	**/
	static function glslFloat(f: Float) {
		var s = Std.string(f);
		if (s.indexOf('.') == -1) {
			s += '.';
		}
		return s;
	}

}