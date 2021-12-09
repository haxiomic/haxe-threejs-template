package rendering;

import Structure.extend;
import objects.ClipSpaceTriangle;
import three.BlendingDstFactor;
import three.ShaderMaterial;
import three.Side;
import three.Texture;
import three.Uniform;

/**
	Render a texture that spans screen-space
**/
class CompLayer extends ClipSpaceTriangle<ShaderMaterial> {

	public final shaderMaterial: ShaderMaterial;
	public final uTexture: Uniform<Texture>;

	public function new(options: {
		depth: Float,
		alphaBlend: Bool,
		?premultipliedAlpha: Bool,
		?encodingAndToneMapping: Bool,
		?depthWrite: Bool,
		?depthTest: Bool,
	}, ?texture: Texture) {
		var options = extend({
			depth: 0.0,
			alphaBlend: false,
			premultipliedAlpha: false,
			encodingAndToneMapping: false,
			depthWrite: true,
			depthTest: true,
		}, options);
		var uTexture = new Uniform(texture);
		var shaderMaterial = new ShaderMaterial({
			uniforms: {
				uTexture: uTexture,
				uDepth: new Uniform(options.depth),
				uToneMappingAndEncoding: new Uniform(options.encodingAndToneMapping),
			},
			vertexShader: '
				uniform float uDepth;

				varying vec2 vUv;

				void main() {
					vUv = position.xy * 0.5 + 0.5;
					gl_Position = vec4(position.xy, uDepth, 1.0);
				}
			',
			fragmentShader: '
				precision highp float;
				uniform sampler2D uTexture;
				uniform bool uToneMappingAndEncoding;

				varying vec2 vUv;

				void main() {
					gl_FragColor = texture2D(uTexture, vUv);

					if (uToneMappingAndEncoding) {
						#include <tonemapping_fragment>
						#include <encodings_fragment>
						#include <premultiplied_alpha_fragment>
					}
				}
			',
			side: Side.DoubleSide,
			depthWrite: options.depthWrite,
			depthTest: options.depthTest,
			fog: false,
			lights: false,
		});
		if (options.alphaBlend) {
			shaderMaterial.blending = CustomBlending;
			shaderMaterial.blendEquation = AddEquation;
			shaderMaterial.blendSrc = BlendingDstFactor.OneFactor;
			shaderMaterial.blendDst = BlendingDstFactor.OneMinusSrcAlphaFactor;
			shaderMaterial.premultipliedAlpha = options.premultipliedAlpha;
		} else {
			shaderMaterial.blending = NoBlending;
		}
		super(shaderMaterial);
		this.uTexture = uTexture;
		this.shaderMaterial = shaderMaterial;
	}

}