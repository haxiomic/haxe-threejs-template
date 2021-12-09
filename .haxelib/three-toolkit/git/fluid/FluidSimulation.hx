package fluid;

import Structure.extendAny;
import Structure.extend;
import three.TextureEncoding;
import rendering.DualRenderTarget;
import rendering.FragmentRenderer;
import three.PixelFormat;
import three.RawShaderMaterial;
import three.Texture;
import three.TextureFilter;
import three.Uniform;
import three.Vector3;
import three.WebGLRenderTarget;
import three.WebGLRenderTargetOptions;
import three.WebGLRenderer;
import tool.CompileTime;

typedef SharedUniforms = {
	invResolution: Uniform<Vector3>,
	dx: Uniform<Float>,
	rdx: Uniform<Float>,
	halfRdx: Uniform<Float>,
	dxAlpha: Uniform<Float>,
	dt: Uniform<Float>,
	velocityBoundaryEnabled: Uniform<Bool>,
	velocity: Uniform<Texture>,
	pressure: Uniform<Texture>,
	divergence: Uniform<Texture>,
	color: Uniform<Texture>,
}

@:nullSafety
class FluidSimulation {

	// uniforms
	public final sharedUniforms: SharedUniforms;
	public var iterations = 25;
	
	// textures
	public final colorTexture: DualRenderTarget;
	public final velocityTexture: DualRenderTarget;
	public final pressureTexture: DualRenderTarget;
	public var divergenceTexture: WebGLRenderTarget;

	public var width(default, null): Int;
	public var height(default, null): Int;
	public var periodicBoundary(get, set): Bool;
	public var simulationTextureScale: Float;
	var simulationWidth: Int;
	var simulationHeight: Int;

	final fragmentRenderer: FragmentRenderer;

	// shaders
	final advectShader: Advect;
	final divergenceShader: Divergence;
	final pressureSolveShader: PressureSolve;
	final pressureGradientSubtractShader: PressureGradientSubtract;

	final textureOptions: WebGLRenderTargetOptions;
	final textureOptionsNearest: WebGLRenderTargetOptions;

	public function new(
		renderer: WebGLRenderer,
		width: Int,
		height: Int,
		periodicBoundary: Bool,
		physicsScale: Float,
		simulationTextureScale = 0.25,
		generateMipmaps = false
	) {
		fragmentRenderer = new FragmentRenderer(renderer);
		this.width = width;
		this.height = height;
		this.simulationTextureScale = simulationTextureScale;
		this._periodicBoundary = periodicBoundary;

		simulationWidth = Std.int(width * simulationTextureScale);
		simulationHeight = Std.int(height * simulationTextureScale);

		textureOptions = {
			encoding: LinearEncoding,
			generateMipmaps: false,
			stencilBuffer: false,
			depthBuffer: false,
			anisotropy: 0,
			type: HalfFloatType,
			minFilter: LinearFilter,
			magFilter: LinearFilter,
			format: PixelFormat.RGBAFormat,
			wrapT: periodicBoundary ? RepeatWrapping : ClampToEdgeWrapping,
			wrapS: periodicBoundary ? RepeatWrapping : ClampToEdgeWrapping,
		}

		textureOptionsNearest = extend(textureOptions, {
			minFilter: TextureFilter.NearestFilter,
			magFilter: TextureFilter.NearestFilter,
		});

		// use gamma decode when displaying the color texture (advection is still handled in linear-space)
		colorTexture = new DualRenderTarget(renderer, width, height, generateMipmaps ? extend(textureOptions, {
			magFilter: TextureFilter.LinearFilter,
			minFilter: TextureFilter.LinearMipMapLinearFilter,
			generateMipmaps: true,
		}) : textureOptions);
		velocityTexture = new DualRenderTarget(renderer, simulationWidth, simulationHeight, textureOptions);
		pressureTexture = new DualRenderTarget(renderer, simulationWidth, simulationHeight, textureOptionsNearest);
		divergenceTexture = new WebGLRenderTarget(simulationWidth, simulationHeight, textureOptionsNearest);

		sharedUniforms = {
			invResolution: new Uniform(new Vector3(1,1,1)), // set during step
			dt: new Uniform(0.), // set during step

			dx: new Uniform(physicsScale),
			rdx: new Uniform(1.0 / physicsScale),
			halfRdx: new Uniform(0.5 / physicsScale),
			dxAlpha: new Uniform(-physicsScale * physicsScale),
			velocityBoundaryEnabled: new Uniform(!periodicBoundary),
			velocity: velocityTexture.uniform,
			pressure: pressureTexture.uniform,
			divergence: new Uniform(divergenceTexture.texture),
			color: colorTexture.uniform,
		}

		advectShader = new Advect(sharedUniforms);
		divergenceShader = new Divergence(sharedUniforms);
		pressureSolveShader = new PressureSolve(sharedUniforms);
		pressureGradientSubtractShader = new PressureGradientSubtract(sharedUniforms);
	}

	public function step(
		t_s: Float,
		dt_s: Float,
		applyForces: (velocityTarget: WebGLRenderTarget) -> Void,
		applyColor: (colorTarget: WebGLRenderTarget) -> Void
	) {
		// resize simulation textures if required
		if (this.simulationWidth != Std.int(this.width * simulationTextureScale)) {
			resize(width, height);
		} 

		sharedUniforms.dt.value = dt_s;
		// simulation domain
		var simulationWidth = velocityTexture.width;
		var simulationHeight = velocityTexture.height;
		sharedUniforms.invResolution.value.set(1/simulationWidth, 1/simulationHeight, simulationHeight/simulationWidth);

		// advect velocity
		advectShader.target.value = velocityTexture.getTexture();
		fragmentRenderer.render(velocityTexture.getRenderTarget(), advectShader);
		velocityTexture.swap();

		// apply user forces
		// write to user-input to velocity texture
		applyForces(velocityTexture.getRenderTarget());
		velocityTexture.swap();

		// compute velocity field divergence
		fragmentRenderer.render(divergenceTexture, divergenceShader);

		// solve pressure
		for (_ in 0...iterations) {
			fragmentRenderer.render(pressureTexture.getRenderTarget(), pressureSolveShader);
			pressureTexture.swap();
		}

		// subtract pressure gradient from velocity
		fragmentRenderer.render(velocityTexture.getRenderTarget(), pressureGradientSubtractShader);
		velocityTexture.swap();
		
		// color domain
		var colorWidth = colorTexture.width;
		var colorHeight = colorTexture.height;
		sharedUniforms.invResolution.value.set(1/colorWidth, 1/colorHeight, colorHeight/colorWidth);
		// apply user color
		applyColor(colorTexture.getRenderTarget());
		colorTexture.swap();

		// advect color
		advectShader.target.value = colorTexture.getTexture();
		fragmentRenderer.render(colorTexture.getRenderTarget(), advectShader);
		colorTexture.swap();
	}

	public function resize(newWidth: Int, newHeight: Int) {
		this.width = newWidth;
		this.height = newHeight;
		this.simulationWidth = Std.int(newWidth * simulationTextureScale);
		this.simulationHeight = Std.int(newHeight * simulationTextureScale);

		colorTexture.resize(width, height);
		velocityTexture.resize(simulationWidth, simulationHeight);
		pressureTexture.resize(simulationWidth, simulationHeight);

		divergenceTexture.dispose();
		divergenceTexture = new WebGLRenderTarget(simulationWidth, simulationHeight, textureOptionsNearest);
		sharedUniforms.divergence.value = divergenceTexture.texture;
	}

	public function clipSpaceToSimulationSpaceX(x: Float) {
		var aspect = this.simulationWidth / this.simulationHeight;
		return x * aspect;
	}

	public function clipSpaceToSimulationSpaceY(y: Float) {
		return y;
	}

	var _periodicBoundary = false;
	function get_periodicBoundary() {
		return _periodicBoundary;
	}

	function set_periodicBoundary(v: Bool) {
		sharedUniforms.velocityBoundaryEnabled.value = !v;
		
		textureOptions.wrapT = v ? RepeatWrapping : ClampToEdgeWrapping;
		textureOptions.wrapS = v ? RepeatWrapping : ClampToEdgeWrapping;
		
		colorTexture.setOptions(textureOptions);
		velocityTexture.setOptions(textureOptions);
		pressureTexture.setOptions(textureOptions);
		divergenceTexture.dispose();
		divergenceTexture = new WebGLRenderTarget(simulationWidth, simulationHeight, textureOptionsNearest);
		sharedUniforms.divergence.value = divergenceTexture.texture;
		return _periodicBoundary = v;
	}

	static public final precision = 'highp';
	static final vertexShader = CompileTime.embedShader('./vertex-shader.glsl');
	static public function getVertexShader(uv: Bool, finiteDifferences: Bool, simulationPosition: Bool) {
		return '
			precision $precision float;
			${uv ? '#define UV' : ''}
			${finiteDifferences ? '#define FINITE_DIFFERENCE' : ''}
			${simulationPosition ? '#define SIMULATION_POSITION' : ''}

			$vertexShader
		';
	}
	static public final sharedShader = CompileTime.embedShader('./shared.glsl');

}

class Advect extends RawShaderMaterial {

	public final target: Uniform<Texture>;

	public function new(sharedUniforms) {
		var target = new Uniform<Texture>(null);
		super({
			uniforms: extendAny(sharedUniforms, {
				target: target,
			}),
			vertexShader: FluidSimulation.getVertexShader(true, false, true),
			fragmentShader: '
				precision ${FluidSimulation.precision} float;

				uniform vec3 invResolution;
				uniform bool velocityBoundaryEnabled;
				uniform float rdx;
				uniform float dt;

				uniform sampler2D velocity;
				uniform sampler2D target;

				varying vec2 vUv;
				varying vec2 p;

				${FluidSimulation.sharedShader}

				void main(void){
					vec2 tracedPos = p - dt * rdx * texture2D(velocity, vUv).xy;

					gl_FragColor = texture2D(target, simToTexelSpace(tracedPos));
				}
			',
		});
		this.target = target;
	}

}

class Divergence extends RawShaderMaterial {

	public function new(sharedUniforms) {
		super({
			uniforms: sharedUniforms,
			vertexShader: FluidSimulation.getVertexShader(false, true, false),
			fragmentShader: '
				precision ${FluidSimulation.precision} float;

				uniform vec3 invResolution;
				uniform bool velocityBoundaryEnabled;
				uniform sampler2D velocity;
				uniform float halfRdx;

				varying vec2 vL;
				varying vec2 vR;
				varying vec2 vB;
				varying vec2 vT;
			
				${FluidSimulation.sharedShader}

				void main(void){
					// compute the divergence according to the finite difference formula
					vec2 L = sampleVelocity(velocity, vL);
					vec2 R = sampleVelocity(velocity, vR);
					vec2 B = sampleVelocity(velocity, vB);
					vec2 T = sampleVelocity(velocity, vT);

					gl_FragColor = vec4( halfRdx * ((R.x - L.x) + (T.y - B.y)), 0., 0., 1.);
				}

			',
		});
	}

}

class PressureSolve extends RawShaderMaterial {

	public function new(sharedUniforms) {
		super({
			uniforms: sharedUniforms,
			vertexShader: FluidSimulation.getVertexShader(true, true, false),
			fragmentShader: '
				precision ${FluidSimulation.precision} float;

				uniform vec3 invResolution;
				uniform bool velocityBoundaryEnabled;

				uniform sampler2D pressure;
				uniform sampler2D divergence;
				uniform float dxAlpha; // alpha = -(dx)^2, where dx = grid cell size

				varying vec2 vUv;

				varying vec2 vL;
				varying vec2 vR;
				varying vec2 vB;
				varying vec2 vT;

				${FluidSimulation.sharedShader}

				void main(void){
					// left, right, bottom, and top x samples
					// texelSize = 1./resolution;
					float L = samplePressure(pressure, vL);
					float R = samplePressure(pressure, vR);
					float B = samplePressure(pressure, vB);
					float T = samplePressure(pressure, vT);

					float bC = texture2D(divergence, vUv).x;

					gl_FragColor = vec4( (L + R + B + T + dxAlpha * bC) * .25, 0, 0, 1 ); // rBeta = .25
				}
			',
		});
	}

}

class PressureGradientSubtract extends RawShaderMaterial {

	public function new(sharedUniforms) {
		super({
			uniforms: sharedUniforms,
			vertexShader: FluidSimulation.getVertexShader(true, true, false),
			fragmentShader: '
				precision ${FluidSimulation.precision} float;

				uniform vec3 invResolution;
				uniform bool velocityBoundaryEnabled;

				uniform sampler2D pressure;
				uniform sampler2D velocity;
				uniform float halfRdx;

				varying vec2 vUv;

				varying vec2 vL;
				varying vec2 vR;
				varying vec2 vB;
				varying vec2 vT;

				${FluidSimulation.sharedShader}

				void main(void){
					float L = samplePressure(pressure, vL);
					float R = samplePressure(pressure, vR);
					float B = samplePressure(pressure, vB);
					float T = samplePressure(pressure, vT);

					vec2 v = texture2D(velocity, vUv).xy;

					gl_FragColor = vec4(v - halfRdx*vec2(R-L, T-B), 0, 1);
				}
			',
		});
	}

}