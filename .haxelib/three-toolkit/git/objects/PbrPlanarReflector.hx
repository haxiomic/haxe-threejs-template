package objects;

import Structure.extend;
import Structure.extendAny;
import VectorMath;
import material.CustomPhysicalMaterial;
import math.Scalar;
import rendering.PostProcess;
import rendering.WebGLRenderTarget;
import three.Color;
import three.ShaderMaterial;
import three.examples.jsm.objects.reflector.Reflector;
import three.examples.jsm.objects.reflector.ReflectorOptions;

class PbrPlanarReflector extends Reflector {

	public var reflectorResolution: Float;
	public var reflectorKernel: Float;
	public var reflectorSigma: Float;
	public var reflectorPOT: Bool;
	public var reflectorMaterial(get, set): CustomPhysicalMaterial;

	public function new(geometry: three.BufferGeometry, ?options: ReflectorOptions) {
		var options = extend({
			textureWidth: 1,
			textureHeight: 1,
			clipBias: 0.,
			encoding: three.TextureEncoding.LinearEncoding,
		}, options != null ? options : {});
		super(geometry, options);

		this.reflectorResolution = 0.5;
		this.reflectorKernel = 0.020;
		this.reflectorSigma = 0.5;
		this.reflectorPOT = false;

		this.name = 'PbrPlanarReflector';
		var reflectorRenderTarget = this.getRenderTarget();

		// hijack reflector rendering to enable blurring
		var _onBeforeRender = this.onBeforeRender;

		var postProcess: Null<PostProcess> = null;
		this.onBeforeRender = (renderer, scene, camera, geometry, material, group) -> {
			var currentTarget: WebGLRenderTarget = cast renderer.getRenderTarget();
			
			// resize reflector target
			var targetSize = vec2(0);

			if (currentTarget != null) {
				targetSize.x = currentTarget.width;
				targetSize.y = currentTarget.height;
			} else {
				var gl = renderer.getContext();
				targetSize.x = gl.drawingBufferWidth;
				targetSize.y = gl.drawingBufferHeight;
			}
			
			var targetSize = floor(targetSize * reflectorResolution);

			if (reflectorPOT) {
				targetSize.x = Scalar.floorPowerOfTwo(targetSize.x);
				targetSize.y = Scalar.floorPowerOfTwo(targetSize.y);
			}

			if (targetSize != vec2(reflectorRenderTarget.width, reflectorRenderTarget.height)) {
				reflectorRenderTarget.setSize(targetSize.x, targetSize.y);
			}

			// force linear encoding when rendering reflection
			var _previousEncoding = renderer.outputEncoding;
			var _previousToneMapping = renderer.toneMapping;
			var _previousExposure = renderer.toneMappingExposure;
			renderer.outputEncoding = LinearEncoding;

			_onBeforeRender(renderer, scene, camera, geometry, material, group);

			renderer.outputEncoding = _previousEncoding;
			renderer.toneMapping = _previousToneMapping;
			renderer.toneMappingExposure = _previousExposure;

			// blur
			if (reflectorKernel > 0) {
				if (postProcess == null) {
					postProcess = new PostProcess(renderer);
				}
				var previousTarget = renderer.getRenderTarget();
				postProcess.blurSelf('reflection-blur', reflectorRenderTarget, reflectorKernel, reflectorSigma);
				renderer.setRenderTarget(previousTarget);
			}
		}

		var _originalMaterial: ShaderMaterial = cast this.material;

		// override material
		var material = new CustomPhysicalMaterial(_originalMaterial.uniforms, {
			name: 'PbrReflector',
			fog: false,
			roughness: 0,
			metalness: 0.25,
			color: new Color(0xFFFFFF),
			emissiveIntensity: 0,
			flatShading: false,
			vertexShader: '
				#define STANDARD
				varying vec3 vViewPosition;
				#ifdef USE_TRANSMISSION
					varying vec3 vWorldPosition;
				#endif
				#include <common>
				#include <uv_pars_vertex>
				#include <uv2_pars_vertex>
				#include <displacementmap_pars_vertex>
				#include <color_pars_vertex>
				#include <fog_pars_vertex>
				#include <normal_pars_vertex>
				#include <morphtarget_pars_vertex>
				#include <skinning_pars_vertex>
				#include <shadowmap_pars_vertex>
				#include <logdepthbuf_pars_vertex>
				#include <clipping_planes_pars_vertex>

				// reflector
				uniform mat4 textureMatrix;
				varying vec4 vReflectorUv;

				void main() {
					#include <uv_vertex>
					#include <uv2_vertex>
					#include <color_vertex>
					#include <beginnormal_vertex>
					#include <morphnormal_vertex>
					#include <skinbase_vertex>
					#include <skinnormal_vertex>
					#include <defaultnormal_vertex>
					#include <normal_vertex>
					#include <begin_vertex>
					#include <morphtarget_vertex>
					#include <skinning_vertex>
					#include <displacementmap_vertex>
					#include <project_vertex>
					#include <logdepthbuf_vertex>
					#include <clipping_planes_vertex>
					vViewPosition = - mvPosition.xyz;
					#include <worldpos_vertex>
					#include <shadowmap_vertex>
					#include <fog_vertex>
				#ifdef USE_TRANSMISSION
					vWorldPosition = worldPosition.xyz;
				#endif

					vReflectorUv = textureMatrix * vec4( position, 1.0 );
				}
			',
			fragmentShader: '
				#define STANDARD
				#ifdef PHYSICAL
					#define IOR
					#define SPECULAR
				#endif
				uniform vec3 diffuse;
				uniform vec3 emissive;
				uniform float roughness;
				uniform float metalness;
				uniform float opacity;
				#ifdef IOR
					uniform float ior;
				#endif
				#ifdef SPECULAR
					uniform float specularIntensity;
					uniform vec3 specularColor;
					#ifdef USE_SPECULARINTENSITYMAP
						uniform sampler2D specularIntensityMap;
					#endif
					#ifdef USE_SPECULARCOLORMAP
						uniform sampler2D specularColorMap;
					#endif
				#endif
				#ifdef USE_CLEARCOAT
					uniform float clearcoat;
					uniform float clearcoatRoughness;
				#endif
				#ifdef USE_SHEEN
					uniform vec3 sheenColor;
					uniform float sheenRoughness;
					#ifdef USE_SHEENCOLORMAP
						uniform sampler2D sheenColorMap;
					#endif
					#ifdef USE_SHEENROUGHNESSMAP
						uniform sampler2D sheenRoughnessMap;
					#endif
				#endif
				varying vec3 vViewPosition;
				#include <common>
				#include <packing>
				#include <dithering_pars_fragment>
				#include <color_pars_fragment>
				#include <uv_pars_fragment>
				#include <uv2_pars_fragment>
				#include <map_pars_fragment>
				#include <alphamap_pars_fragment>
				#include <alphatest_pars_fragment>
				#include <aomap_pars_fragment>
				#include <lightmap_pars_fragment>
				#include <emissivemap_pars_fragment>
				#include <bsdfs>
				#include <cube_uv_reflection_fragment>
				#include <envmap_common_pars_fragment>
				#include <envmap_physical_pars_fragment>
				#include <fog_pars_fragment>
				#include <lights_pars_begin>
				#include <normal_pars_fragment>
				#include <lights_physical_pars_fragment>
				#include <transmission_pars_fragment>
				#include <shadowmap_pars_fragment>
				#include <bumpmap_pars_fragment>
				#include <normalmap_pars_fragment>
				#include <clearcoat_pars_fragment>
				#include <roughnessmap_pars_fragment>
				#include <metalnessmap_pars_fragment>
				#include <logdepthbuf_pars_fragment>
				#include <clipping_planes_pars_fragment>

				// reflector
				uniform sampler2D tDiffuse;
				varying vec4 vReflectorUv;

				void main() {
					#include <clipping_planes_fragment>
					vec4 diffuseColor = vec4( diffuse, opacity );
					ReflectedLight reflectedLight = ReflectedLight( vec3( 0.0 ), vec3( 0.0 ), vec3( 0.0 ), vec3( 0.0 ) );
					vec3 totalEmissiveRadiance = emissive;
					#include <logdepthbuf_fragment>
					#include <map_fragment>
					#include <color_fragment>
					#include <alphamap_fragment>
					#include <alphatest_fragment>
					#include <roughnessmap_fragment>
					#include <metalnessmap_fragment>
					#include <normal_fragment_begin>
					#include <normal_fragment_maps>
					#include <clearcoat_normal_fragment_begin>
					#include <clearcoat_normal_fragment_maps>
					#include <emissivemap_fragment>

					#include <lights_physical_fragment>
					#include <lights_fragment_begin>

					{	// replacing: lights_fragment_maps
						#if defined( RE_IndirectDiffuse )
							#ifdef USE_LIGHTMAP
								vec4 lightMapTexel = texture2D( lightMap, vUv2 );
								vec3 lightMapIrradiance = lightMapTexelToLinear( lightMapTexel ).rgb * lightMapIntensity;
								#ifndef PHYSICALLY_CORRECT_LIGHTS
									lightMapIrradiance *= PI;
								#endif
								irradiance += lightMapIrradiance;
							#endif
							#if defined( USE_ENVMAP ) && defined( STANDARD ) && defined( ENVMAP_TYPE_CUBE_UV )
								iblIrradiance += getIBLIrradiance( geometry.normal );
							#endif
						#endif

						// replace environment radiance with planar reflection
						vec3 planarReflection = texture2DProj( tDiffuse, vReflectorUv ).rgb;

						radiance += planarReflection;

						#ifdef USE_CLEARCOAT
						clearcoatRadiance += planarReflection;
						#endif
					}

					#include <lights_fragment_end>

					#include <aomap_fragment>

					vec3 totalDiffuse = reflectedLight.directDiffuse + reflectedLight.indirectDiffuse;
					vec3 totalSpecular = reflectedLight.directSpecular + reflectedLight.indirectSpecular;
					#include <transmission_fragment>

					vec3 outgoingLight = totalDiffuse + totalSpecular + totalEmissiveRadiance ;

					#ifdef USE_CLEARCOAT
						float dotNVcc = saturate( dot( geometry.clearcoatNormal, geometry.viewDir ) );
						vec3 Fcc = F_Schlick( material.clearcoatF0, material.clearcoatF90, dotNVcc );
						outgoingLight = outgoingLight * ( 1.0 - clearcoat * Fcc ) + clearcoatSpecular * clearcoat;
					#endif
					
					#include <output_fragment>
					#include <tonemapping_fragment>
					#include <encodings_fragment>
					#include <fog_fragment>
					#include <premultiplied_alpha_fragment>
					#include <dithering_fragment>
				}
			'
		});
		material.uniforms = extendAny(material.uniforms, _originalMaterial.uniforms);

		this.material = material;
	}

	inline function get_reflectorMaterial() return cast this.material;
	inline function set_reflectorMaterial(v: CustomPhysicalMaterial) {
		this.material = v;
		return v;
	}

}