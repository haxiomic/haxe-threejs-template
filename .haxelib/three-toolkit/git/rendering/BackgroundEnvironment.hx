package rendering;

import three.Color;
import three.BufferGeometry;
import three.Uniform;
import three.ShaderMaterial;
import three.Texture;
import three.Mesh;
import three.WebGLRenderer;
import three.Scene;
import three.Camera;
import three.Material;
import three.Group;

/**
	Draws the scene's environment texture with variable roughness
	In contrast to scene.background which has fixed roughness
**/
class BackgroundEnvironment extends Mesh<BufferGeometry, EnvironmentMaterial> {

	public var roughness(get, set): Float;
	public var multiplier(get, set): Color;

	public function new(roughness: Float = 0.5) {
		var environmentMaterial = new EnvironmentMaterial(roughness);
		super(new three.BoxGeometry(1, 1, 1), environmentMaterial);

		geometry.deleteAttribute('normal');
		geometry.deleteAttribute('uv');
		
		this.name = 'BackgroundEnvironment';
		this.frustumCulled = false;
		this.castShadow = false;
		this.receiveShadow = false;
		this.matrixAutoUpdate = false;
		this.renderOrder = Math.NEGATIVE_INFINITY; // render last to take advantage of depth culling

		this.onBeforeRender = (renderer:WebGLRenderer, scene:Scene, camera:Camera, geometry:ts.AnyOf2<BufferGeometry, BufferGeometry>, material:Material, group:Group) -> {
			this.material.envMap = scene.environment;
			this.matrixWorld.copyPosition(camera.matrixWorld);
		};
	}

	inline function get_roughness() {
		return this.material.uRoughness.value;
	}
	inline function set_roughness(v: Float) {
		return this.material.uRoughness.value = v;
	}

	inline function get_multiplier() {
		return this.material.uMultiplier.value;
	}
	inline function set_multiplier(v: Color) {
		return this.material.uMultiplier.value = v;
	}

}

class EnvironmentMaterial extends ShaderMaterial {

	@:isVar public var envMap(get, set): Null<Texture>;
	public final uRoughness: Uniform<Float>;
	public final uFlipEnvMap: Uniform<Int>;
	public final uMultiplier: Uniform<Color>;

	final uEnvMap: Uniform<Texture>;

	public function new(roughness: Float) {
		final uRoughness = new Uniform(0.5);
		final uFlipEnvMap = new Uniform(-1);
		final uEnvMap = new Uniform(null);
		final uMultiplier = new Uniform(new Color(1,1,1));

		super({
			name: 'BackgroundEnvironment',
			uniforms: {
				'envMap': uEnvMap,
				'flipEnvMap': uFlipEnvMap,
				'uRoughness': uRoughness,
				'uMultiplier': uMultiplier,
			},
			vertexShader: Three.ShaderLib.cube.vertexShader,
			fragmentShader: 
			'
				uniform float uRoughness;
				uniform vec3 uMultiplier;
				#include <envmap_common_pars_fragment>
				#ifdef USE_ENVMAP
				varying vec3 vWorldDirection;
				#endif
				#include <cube_uv_reflection_fragment>

				void main() {
					#ifdef USE_ENVMAP
						vec3 reflectVec = vWorldDirection;
						#ifdef ENVMAP_TYPE_CUBE
							vec4 envColor = textureCube( envMap, vec3( flipEnvMap * reflectVec.x, reflectVec.yz ) );
						#elif defined( ENVMAP_TYPE_CUBE_UV )
							vec4 envColor = textureCubeUV(envMap, reflectVec, uRoughness);
						#elif defined( ENVMAP_TYPE_EQUIREC )
							vec2 sampleUV;
							reflectVec = normalize( reflectVec );
							sampleUV.y = asin( clamp( reflectVec.y, - 1.0, 1.0 ) ) * RECIPROCAL_PI + 0.5;
							sampleUV.x = atan( reflectVec.z, reflectVec.x ) * RECIPROCAL_PI2 + 0.5;
							vec4 envColor = texture2D( envMap, sampleUV );
						#elif defined( ENVMAP_TYPE_SPHERE )
							reflectVec = normalize( reflectVec );
							vec3 reflectView = normalize( ( viewMatrix * vec4( reflectVec, 0.0 ) ).xyz + vec3( 0.0, 0.0, 1.0 ) );
							vec4 envColor = texture2D( envMap, reflectView.xy * 0.5 + 0.5 );
						#else
							vec4 envColor = vec4( 0.0 );
						#endif
						#ifndef ENVMAP_TYPE_CUBE_UV
							envColor = envMapTexelToLinear( envColor );
						#endif
					#endif
					#ifdef USE_ENVMAP
						gl_FragColor = envColor;
					#else
						gl_FragColor = vec4(1., 1., 1., 1.);
					#endif

					

					gl_FragColor.rgb *= uMultiplier;
					#include <tonemapping_fragment>
					#include <encodings_fragment>
				}
			',
			side: DoubleSide,
			depthWrite: false,
			depthTest: true,
			blending: NoBlending,
		});

		this.uRoughness = uRoughness;
		this.uFlipEnvMap = uFlipEnvMap;
		this.uEnvMap = uEnvMap;
		this.uMultiplier = uMultiplier;

		uRoughness.value = roughness;
	}

	inline function set_envMap(v: Null<Texture>) {
		if (v != envMap) needsUpdate = true;
		if (v != null) {
			uFlipEnvMap.value = untyped v.isCubeTexture == true ? -1 : 1;
		}
		uEnvMap.value = v;
		return this.envMap = v;
	}

	inline function get_envMap() {
		return uEnvMap.value;
	}

}