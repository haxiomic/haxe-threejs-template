package shaders;

import three.Texture;
import three.Uniform;
import three.RawShaderMaterial;

enum abstract ToneMapping(String) to String {
	var ACESFilmic = 'ACESFilmicToneMapping';
	var Reinhard = 'ReinhardToneMapping';
	var OptimizedCineon = 'OptimizedCineonToneMapping';
	var Linear = 'LinearToneMapping';
	var Abs = 'abs';
}

enum abstract Encoding(String) to String {
	var Linear = 'LinearToLinear';
	var Gamma = 'LinearToGamma';
	var sRGB = 'LinearTosRGB';
}

class OutputMap extends RawShaderMaterial {
	
	static public inline function get(texture: Texture, encoding: Encoding, toneMapping: ToneMapping, toneMappingExposure: Float) {
		instance.uTexture.value = texture;
		instance.uToneMappingExposure.value = toneMappingExposure;
		if (
			Reflect.field(instance.defines, 'TONE_MAPPING_FN') != toneMapping ||
			Reflect.field(instance.defines, 'ENCODING_FN') != encoding
		) {
			instance.needsUpdate = true;
		}
		instance.defines = {
			'TONE_MAPPING_FN': toneMapping,
			'ENCODING_FN': encoding,
		};
		return instance;
	}
	static final instance = new OutputMap();

	public final uTexture = new Uniform(cast null);
	public final uToneMappingExposure = new Uniform(1.0);

	public function new() {
		super({
			uniforms: {
				uTexture: uTexture,
				toneMappingExposure: uToneMappingExposure,
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

				#include <tonemapping_pars_fragment>

				vec4 LinearToGamma( in vec4 value, in float gammaFactor ) {
					return vec4( pow( value.rgb, vec3( 1.0 / gammaFactor ) ), value.a );
				}

				vec4 LinearToGamma( in vec4 value ) {
					return vec4( pow( value.rgb, vec3( 1.0 / 2.2 ) ), value.a );
				}

				vec4 LinearTosRGB( in vec4 value ) {
					return vec4( mix( pow( value.rgb, vec3( 0.41666 ) ) * 1.055 - vec3( 0.055 ), value.rgb * 12.92, vec3( lessThanEqual( value.rgb, vec3( 0.0031308 ) ) ) ), value.a );
				}

				vec4 LinearToLinear( in vec4 value ) {
					return value;
				}

				void main() {
					gl_FragColor = texture2D(uTexture, vUv);
					// tone mapping and encoding
					gl_FragColor.rgb = TONE_MAPPING_FN(gl_FragColor.rgb);
					gl_FragColor = ENCODING_FN(gl_FragColor);
				}
			',
			side: DoubleSide
		});
	}

}