package rendering;

import three.Vector2;
import js.lib.Float32Array;
import js.lib.Uint8Array;
import three.Uniform;
import three.PixelFormat;
import three.WebGLRenderer;
import three.WebGLRenderTarget;
import three.RawShaderMaterial;
import three.Texture;

class FloatTexturePacker {

	public final renderTarget: WebGLRenderTarget;
	final shader: RawShaderMaterial;
	final renderer: WebGLRenderer;
	final fragmentRenderer: FragmentRenderer;

	final uSource = new Uniform(cast null);
	final uRange = new Uniform(new Vector2(0, 1));

	public function new(renderer: WebGLRenderer, channel: String) {
		this.renderer = renderer;
		this.fragmentRenderer = new FragmentRenderer(renderer);
		this.renderTarget = new WebGLRenderTarget(2, 1, {
			minFilter: NearestFilter,
			magFilter: NearestFilter,
			encoding: LinearEncoding,
			type: UnsignedByteType,
			stencilBuffer: false,
			depthBuffer: false,
			anisotropy: 0,
			format: PixelFormat.RGBAFormat,
			generateMipmaps: false,
		});

		this.shader = new RawShaderMaterial({
			uniforms: {
				uSource: uSource,
				uRange: uRange,
			},
			vertexShader: '
				attribute vec2 position;

				varying vec2 vUv;

				void main() {
					vUv = position * 0.5 + 0.5;
					gl_Position = vec4(position, 0., 1.);
				}
			',
			fragmentShader: '
				precision highp float;

				uniform sampler2D uSource;
				uniform vec2 uRange;

				varying vec2 vUv;

				vec4 packFloat8bitRGBA(in float val){
					vec4 pack = vec4(1.0, 255.0, 65025.0, 16581375.0) * val;

					pack = fract(pack);
					pack -= vec4(pack.yzw / 255.0, 0.0);
					pack.x += step(1.0, val);

					return pack;
				}

				void main() {
					float sample = texture2D(uSource, vUv).$channel;
					float rangeLength = uRange.y - uRange.x;
					float sampleNormalized = clamp((sample - uRange.x) / rangeLength, 0., 1.); // converted to 0<->1 range
					gl_FragColor = packFloat8bitRGBA(sampleNormalized);
				}
			',
		});
	}

	public function render(source: Texture, width: Int, height: Int, min: Float, max: Float) {
		if (renderTarget.width != width || renderTarget.height != height) {
			renderTarget.setSize(width, height);
		}
		uSource.value = source;
		(uRange.value: Vector2).x = min;
		(uRange.value: Vector2).y = max;

		fragmentRenderer.render(renderTarget, shader);
	}

	public function readFloats(source: Texture, x: Int, y: Int, width: Int, height: Int, min: Float, max: Float): Float32Array {
		render(source, width, height, min, max);

		var pixelCount = width * height;
		var bytes = new Uint8Array(pixelCount * 4);
		renderer.readRenderTargetPixels(renderTarget, x, y, width, height, bytes);

		// unpack bytes to floats
		var floats = new Float32Array(pixelCount);
		var rangeLength = max - min;
		for (i in 0...pixelCount) {
			var offset = i * 4;
			floats[i] = unpackFloat8bitRGBA(
				bytes[offset + 0],
				bytes[offset + 1],
				bytes[offset + 2],
				bytes[offset + 3]
			) * rangeLength + min;
		}

		return floats;
	}

	inline function unpackFloat8bitRGBA(b0: Int, b1: Int, b2: Int, b3: Int){
		return (
			b0 +
			b1 / 255.0 +
			b2 / 65025.0 + 
			b3 / 16581375.0
		) / 255.0;
	}

}