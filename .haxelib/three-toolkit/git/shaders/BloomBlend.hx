package shaders;

import three.BlendingDstFactor;
import three.RawShaderMaterial;
import three.Texture;
import three.Uniform;

class BloomBlend extends RawShaderMaterial {

	public final uTexture: Uniform<Texture>;
	/** Setting to 0 gives additive blending, setting to 1.0 is full replace **/
	public final uBloomMix: Uniform<Float>;
	public final uBloomMultiplier: Uniform<Float>;
	public final uBloomSubtract: Uniform<Float>;
	public final uBloomExponent: Uniform<Float>;

	public function new() {
		var uTexture = new Uniform(cast null);
		var uBloomMix = new Uniform(0.0);
		var uBloomMultiplier = new Uniform(1.);
		var uBloomSubtract = new Uniform(0.0);
		var uBloomExponent = new Uniform(1.);
		super({
			uniforms: {
				uTexture: uTexture,
				uBloomMix: uBloomMix,
				uBloomMultiplier: uBloomMultiplier,
				uBloomSubtract: uBloomSubtract,
				uBloomExponent: uBloomExponent, 
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
				uniform float uBloomMix;
				uniform float uBloomMultiplier;
				uniform float uBloomSubtract;
				uniform float uBloomExponent;

				varying vec2 vUv;

				void main() {
					gl_FragColor = texture2D(uTexture, vUv);
					gl_FragColor.rgb = max(gl_FragColor.rgb - uBloomSubtract, vec3(0.));
					gl_FragColor.rgb = pow(gl_FragColor.rgb, vec3(uBloomExponent)) * uBloomMultiplier;
					gl_FragColor.a *= uBloomMix;
				}
			',
			side: DoubleSide,

			// color = src + dst * (1.0 - src.a)
			blending: CustomBlending,
			blendEquation: AddEquation,
			blendSrc: BlendingDstFactor.OneFactor,
			blendDst: BlendingDstFactor.OneMinusSrcAlphaFactor,
			
		});

		this.uTexture = uTexture;
		this.uBloomMix = uBloomMix;
		this.uBloomMultiplier = uBloomMultiplier;
		this.uBloomSubtract = uBloomSubtract;
		this.uBloomExponent = uBloomExponent;
	}

}