package rendering;

import three.Material;
import three.RawShaderMaterial;
import objects.ClipSpaceTriangle;
import three.OrthographicCamera;
import three.Scene;
import three.ShaderMaterial;
import three.Vector4;
import three.WebGLRenderTarget;
import three.WebGLRenderer;

@:nullSafety
class FragmentRenderer {

	final renderer: WebGLRenderer;
	static final rttScene = new Scene();
	static final rttCamera = new OrthographicCamera(-1, 1, 1, -1, 0, 1);
	static final rttMesh = {
		var mesh = new ClipSpaceTriangle(null);
		rttScene.add(mesh);
		mesh;
	};

	public function new(renderer: WebGLRenderer) {
		this.renderer = renderer;
	}

	var _oldViewport = new Vector4();
	public function render(
		target: Null<WebGLRenderTarget>,
		material: Material,
		?clearColor: three.ColorRepresentation,
		?viewport: Vector4
	) {
		renderer.setRenderTarget(target);

		var restoreViewport = false;
		if (viewport != null) {
			restoreViewport = true;
			renderer.getViewport(_oldViewport);
			renderer.setViewport(viewport.x, viewport.y, viewport.z, viewport.w);
		}

		rttMesh.material = material;
		rttMesh.visible = material != null;

		if (clearColor != null) {
			renderer.setClearColor(clearColor);
			// clearing the depth is important here, just in case the target has a depth buffer
			renderer.clear(true, true, true);
		}

		renderer.render(rttScene, rttCamera);

		if (restoreViewport) {
			renderer.setViewport(_oldViewport.x, _oldViewport.y, _oldViewport.z, _oldViewport.w);
		}
	}

}