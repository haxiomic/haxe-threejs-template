package rendering;

import shaders.BloomBlend;
import three.MeshBasicMaterial;
import math.Scalar;
import three.Blending;
import three.BlendingDstFactor;
import js.html.webgl.RenderingContext;
import shaders.Blur1D;
import three.RawShaderMaterial;
import three.Texture;
import three.Uniform;
import three.Vector4;
import three.WebGLRenderer;

class PostProcess {

	public final fragmentRenderer: FragmentRenderer;
	final renderer: WebGLRenderer;
	final renderTargetStore: RenderTargetStore;
	final copyShader = new CopyShader();
	final gl: RenderingContext;

	public function new(renderer: WebGLRenderer) {
		this.renderer = renderer;
		this.gl = renderer.getContext();
		this.fragmentRenderer = new FragmentRenderer(renderer);
		this.renderTargetStore = new RenderTargetStore(renderer);
	}

	public function dispose() {
		this.renderTargetStore.clearAndDispose();
	}

	final _blit_viewport = new Vector4();
	public inline function blit(
		source: Texture,
		target: Null<WebGLRenderTarget>,
		?options: {
			viewport: Vector4,
			clearColor: Null<Int>,
			blending: Blending,
			blendSrc: BlendingDstFactor,
			blendDst: BlendingDstFactor,
			transparent: Bool,
			opacity: Float,
		}
	) {
		var options = options != null ? options: {
			clearColor: null,
			viewport: if (target != null) {
					target.viewport;
				} else {
					// drawing to canvas
					_blit_viewport.set(0, 0, gl.drawingBufferWidth, gl.drawingBufferHeight);
				},
			blending: NoBlending,
			blendSrc: BlendingDstFactor.OneFactor,
			blendDst: BlendingDstFactor.OneMinusSrcAlphaFactor,
			transparent: false,
			opacity: 1.,
		};
 		copyShader.setParams(source, options.opacity);
		copyShader.blending = options.blending;
		copyShader.blendSrc = options.blendSrc;
		copyShader.blendDst = options.blendDst;
		copyShader.transparent = options.transparent;
		copyShader.opacity = options.opacity;
 		this.fragmentRenderer.render(target, copyShader, options.clearColor, options.viewport);
	}

	final _blitBasicMaterial = new MeshBasicMaterial({color: 0xFFFFFF});
	public function blitViaBasicMaterial(source: Texture, target: Null<WebGLRenderTarget>, ?viewport: Vector4) {
		_blitBasicMaterial.map = source;
		var viewport = if (viewport != null) viewport else {
			if (target != null) {
			target.viewport;
			} else {
				// drawing to canvas
				_blit_viewport.set(0, 0, gl.drawingBufferWidth, gl.drawingBufferHeight);
			}
		}
		this.fragmentRenderer.render(target, _blitBasicMaterial, 0x000000, viewport);
	}

	final bloomBlendMaterial = new BloomBlend();
	public inline function bloomBlend(blurredSource: Texture, target: Null<WebGLRenderTarget>, options: {
		/** Setting to 0 gives additive blending, setting to 1.0 is full replace **/
		mix: Float,
		multiplier: Float,
		exponent: Float,
		subtract: Float,
	}) {
		bloomBlendMaterial.uBloomMix.value = Math.pow(options.mix, 1.0 / renderer.gammaFactor);
		bloomBlendMaterial.uBloomMultiplier.value = options.multiplier;
		bloomBlendMaterial.uBloomExponent.value = options.exponent;
		bloomBlendMaterial.uBloomSubtract.value = options.subtract;
		bloomBlendMaterial.uTexture.value = blurredSource;

		var viewport = if (target != null) {
			target.viewport;
		} else {
			// drawing to canvas
			_blit_viewport.set(0, 0, gl.drawingBufferWidth, gl.drawingBufferHeight);
		}

		fragmentRenderer.render(target, bloomBlendMaterial, null, viewport);
	}

	public function resize(uid: String, source: Texture, width: Float, height: Float): rendering.Texture {
		var options = {
			wrapS: source.wrapS,
			wrapT: source.wrapT,
			magFilter: source.magFilter,
			minFilter: source.minFilter,
			format: source.format,
			type: source.type,
			anisotropy: source.anisotropy,
			generateMipmaps: source.generateMipmaps,
			encoding: source.encoding,
			depthBuffer: false,
			stencilBuffer: false,
			depthTexture: null,
		};

		var target = this.renderTargetStore.acquire('resize.$uid', width, height, options);

		// hopefully the gc will eventually get the gpu framebuffer structure

		copyShader.setParams(source, 1.);
		fragmentRenderer.render(target, copyShader);
	
		return target.texture;
	}
	
	public function iterativeDownsample(uid: String, source: rendering.Texture, iterations: Int, floorPowerOfTwo: Bool = true) {
		for (i in 0...iterations) {
			var w: Int;
			var h: Int;
			if (floorPowerOfTwo) {
				w = Std.int(Scalar.floorPowerOfTwo(source.width * 0.5));
				h = Std.int(Scalar.floorPowerOfTwo(source.height * 0.5));
			} else {
				w = Math.ceil(source.width * 0.5);
				h = Math.ceil(source.height * 0.5);
			}
			source = resize('downsample.$i.$uid', source, w, h);
			if (w <= 1 && h <= 1) break;
		}
		return source;
	}

	/**
		Returns a blurred copy of the source texture.
		Requires linear filtering on the source texture
	**/
	public function blur(uid: String, source: rendering.Texture, kernel_yFraction: Float, sigma = 0.5, downsampleIterations: Int = 0) {
		var blurInput = source;

		for (i in 0...downsampleIterations) {
			var w = Std.int(Scalar.floorPowerOfTwo(blurInput.width * 0.5));
			var h = Std.int(Scalar.floorPowerOfTwo(blurInput.height * 0.5));
			blurInput = resize('blur.$i.$uid', blurInput, w, h);
			if (w <= 1 && h <= 1) break;
		}

		return inline blurInternal(uid, blurInput, kernel_yFraction, sigma, null);
	}

	/**
		Blurs the source render target, modifying it in the process.
		Requires linear filtering on the source texture
	**/
	public function blurSelf(uid: String, source: WebGLRenderTarget, kernel_yFraction: Float, sigma = 0.5) {
		return inline blurInternal(uid, source.texture, kernel_yFraction, sigma, source);
	}

	function blurInternal(uid: String, blurInput: rendering.Texture, kernel_yFraction: Float, sigma: Float, outputTarget: Null<WebGLRenderTarget>) {
		if (kernel_yFraction == 0) {
			return blurInput;
		}

		var width = blurInput.width;
		var height = blurInput.height;

		var targetOptions = {
			wrapS: blurInput.wrapS,
			wrapT: blurInput.wrapT,
			encoding: blurInput.encoding,
			generateMipmaps: blurInput.generateMipmaps,
			anisotropy: blurInput.anisotropy,
			type: blurInput.type,
			format: blurInput.format,
			minFilter: blurInput.minFilter,
			magFilter: blurInput.magFilter,
		};

		var blurXTarget = renderTargetStore.acquire('blurX.$uid', width, height, targetOptions);
		var blurXYTarget = outputTarget != null ? outputTarget : renderTargetStore.acquire('blurXY.$uid', width, height, targetOptions);

		var aspect = blurInput.width / blurInput.height;
		var kernelY_texels = kernel_yFraction * blurInput.height;
		var kernelX_texels = kernel_yFraction * (1/aspect) * blurInput.width;

		fragmentRenderer.render(blurXTarget, Blur1D.get(gl, kernelX_texels, sigma, 1., 0., blurInput, blurInput.width, blurInput.height), 0x0);
		fragmentRenderer.render(blurXYTarget, Blur1D.get(gl, kernelY_texels, sigma, 0., 1., blurXTarget.texture, blurXTarget.width, blurXTarget.height), 0x0);

		return blurXYTarget.texture;
	}
	
}

class CopyShader extends RawShaderMaterial {

	final uTexture: Uniform<Texture>;
	final uOpacity: Uniform<Float>;

	public function new() {
		var uTexture = new Uniform<Texture>(null);
		var uOpacity = new Uniform<Float>(1.);
		super({
			uniforms: {
				uTexture: uTexture,
				uOpacity: uOpacity,
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
				uniform sampler2D uTexture;
				uniform float uOpacity;
				varying vec2 vUv;

				void main() {
					gl_FragColor = texture2D(uTexture, vUv);
					gl_FragColor.a *= uOpacity;
				}
			',
			side: DoubleSide,
			depthWrite: false,
			depthTest: false,
			fog: false,
			lights: false,
			toneMapped: false,

			blending: NoBlending,
		});

		this.uTexture = uTexture;
		this.uOpacity = uOpacity;
	}

	public function setParams(texture: Texture, opacity: Float) {
		uTexture.value = texture;
		uOpacity.value = opacity;
	}

}