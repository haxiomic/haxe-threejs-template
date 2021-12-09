package rendering;

import three.Mesh;
import three.OrthographicCamera;
import three.PixelFormat;
import three.Scene;
import three.ShaderMaterial;
import three.Vector3;
import three.WebGLRenderTarget;
import three.WebGLRenderer;
import tool.CameraTools;

@:nullSafety
class HeightMapRenderer {

	public final renderTarget: WebGLRenderTarget;
	final renderer: WebGLRenderer;
	final camera: OrthographicCamera;
	final scene: Scene;
	final shaderMaterial: ShaderMaterial;
	var mesh: Null<Mesh<Any, Any>>;

	public function new(renderer: WebGLRenderer, width: Int, height: Int, ?mesh: Mesh<Any, Any>) {
		this.renderer = renderer;
		this.camera = new OrthographicCamera(-1, 1, 1, -1, 0, 1);
		this.camera.position.set(0, 1, 0);
		this.camera.lookAt(new three.Vector3());
		this.camera.rotation.z = 0;

		this.renderTarget = new WebGLRenderTarget(width, height, {
			magFilter: LinearFilter,
			minFilter: LinearFilter,
			depthBuffer: false,
			generateMipmaps: false,
			stencilBuffer: false,
			anisotropy: 0,
			type: HalfFloatType,
			format: PixelFormat.RGBAFormat,
		});

		this.scene = new Scene();
		this.shaderMaterial = new ShaderMaterial({
			uniforms: {
			},
			vertexShader: '
				varying vec3 vWorldPosition;
				varying vec3 vWorldNormal;

				#include <common>

				void main() {
					vec4 p = vec4( position, 1.0 );
					vec4 worldP = modelMatrix * p;
					vWorldPosition = worldP.xyz;
					
					vec3 transformedNormal = normalMatrix * normal;

					vWorldNormal = inverseTransformDirection(transformedNormal, viewMatrix);

					gl_Position = projectionMatrix * viewMatrix * worldP;
				}
			',
			fragmentShader: '
				varying vec3 vWorldPosition;
				varying vec3 vWorldNormal;
				
				void main() {
					gl_FragColor = vec4(normalize(vWorldNormal), vWorldPosition.y);
				}
			',
			side: DoubleSide,
		});

		this.scene.overrideMaterial = shaderMaterial;

		if (mesh != null) inline setMesh(mesh);
	}

	public function setMesh(mesh: Mesh<Any, Any>) {
		this.mesh = mesh;
	}

	public function setSize(width: Int, height: Int) {
		renderTarget.setSize(width, height);
	}

	public function render() {
		renderer.setRenderTarget(renderTarget);
		renderer.clear(true, false, false);

		if (mesh != null) {
			var parent = mesh.parent;
			scene.add(mesh);
			CameraTools.fitOrthographicView(camera, mesh);

			// flip view along z
			var t = camera.top;
			camera.top = camera.bottom;
			camera.bottom = t;
			camera.updateProjectionMatrix();

			renderer.render(scene, camera);

			scene.remove(mesh);
			if (parent != null) {
				parent.add(mesh);
			}
		}
	}

}