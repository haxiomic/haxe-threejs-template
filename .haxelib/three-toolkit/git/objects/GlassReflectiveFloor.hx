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

class GlassReflectiveFloor extends Reflector {

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

		this.name = 'GlassReflectiveFloor';
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
			name: 'ReflectiveFloor',
			fog: false,
			roughness: 0,
			metalness: 0.25,
			color: new Color(0xFFFFFF),
			emissiveIntensity: 0,
			flatShading: false,
			defines: {
				USE_UV: 1,
			},
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
				uniform float opacity;

				varying vec3 vViewPosition;
				varying vec3 vNormal;
				// varying vec3 vPosition;
				varying vec2 vUv;
	
				// reflector
				uniform sampler2D tDiffuse;
				varying vec4 vReflectorUv;

				float F_Schlick( const in float f0, const in float f90, const in float dotVH ) {
					float fresnel = exp2( ( - 5.55473 * dotVH - 6.98316 ) * dotVH );
					return f0 * ( 1.0 - fresnel ) + ( f90 * fresnel );
				}

				void main() {
					vec3 planarReflection = texture2DProj( tDiffuse, vReflectorUv ).rgb;

					vec3 viewDir = normalize( vViewPosition );
					vec3 normal = normalize(vNormal);

					float mask = smoothstep(0.5, 0.2, length(0.5 - vUv));
					gl_FragColor = vec4(planarReflection, F_Schlick(opacity, 1.0, dot(normal, viewDir)) * mask);

					#include <tonemapping_fragment>
					#include <encodings_fragment>
					#include <premultiplied_alpha_fragment>
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