package rendering;

import three.RawShaderMaterial;

/**
	Base for fragment renderer shaders
**/
class FragmentShader<T> extends RawShaderMaterial {

	public final typedUniforms: T;

	public function new(?parameters: ShaderMaterialParameters<T>, ?fragmentShader: String) {
		var baseParameters = {
			uniforms: { },
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
				varying vec2 vUv;

				void main() {
					gl_FragColor = vec4(vUv, 0.0, 1.);
				}
			',
			depthWrite: false,
			depthTest: false,
		}
		if (parameters != null) {
			baseParameters = Structure.extendAny(baseParameters, parameters);
		}
		if (fragmentShader != null) {
			baseParameters.fragmentShader = fragmentShader;
		}

		super(baseParameters);

		this.typedUniforms = cast this.uniforms;
	}
	
}