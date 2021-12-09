package shaders;

import three.Texture;
import three.Uniform;
import three.RawShaderMaterial;

class Copy extends RawShaderMaterial {
	
	static public inline function get(texture: Texture) {
		instance.uTexture.value = texture;
		return instance;
	}
	static final instance = new Copy();

	public final uTexture: Uniform<Texture>;

	public function new() {
		var uTexture = new Uniform(cast null);
		super({
			uniforms: {
				uTexture: uTexture,
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

				varying vec2 vUv;

				void main() {
					gl_FragColor = texture2D(uTexture, vUv);
				}
			',
			side: DoubleSide
		});
		this.uTexture = uTexture;
	}

}