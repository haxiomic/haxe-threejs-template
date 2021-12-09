package tool;

import three.Vector3;
import three.Box3;
import three.Object3D;
import three.OrthographicCamera;

#if (three >= "0.133.0")
private typedef Object3D = three.Object3D<three.Event>;
#end

class CameraTools {

	static public function fitOrthographicView(camera: OrthographicCamera, target: Object3D) {
		target.updateMatrixWorld();
		var bb = new Box3().setFromObject(target);
		var points: Array<Vector3> = [
			new Vector3(bb.min.x, bb.min.y, bb.min.z), // 000
			new Vector3(bb.min.x, bb.min.y, bb.max.z), // 001
			new Vector3(bb.min.x, bb.max.y, bb.min.z), // 010
			new Vector3(bb.min.x, bb.max.y, bb.max.z), // 011
			new Vector3(bb.max.x, bb.min.y, bb.min.z), // 100
			new Vector3(bb.max.x, bb.min.y, bb.max.z), // 101
			new Vector3(bb.max.x, bb.max.y, bb.min.z), // 110
			new Vector3(bb.max.x, bb.max.y, bb.max.z), // 111
		];

		camera.updateMatrixWorld();

		var min = new Vector3(Math.POSITIVE_INFINITY, Math.POSITIVE_INFINITY, Math.POSITIVE_INFINITY);
		var max = new Vector3(Math.NEGATIVE_INFINITY, Math.NEGATIVE_INFINITY, Math.NEGATIVE_INFINITY);
		for (p in points) {
			camera.worldToLocal(p);
			p.z *= -1;
			min.min(p);
			max.max(p);
		}

		camera.left = min.x;
		camera.right = max.x;
		camera.top = max.y;
		camera.bottom = min.y;
		camera.far = max.z;
		camera.near = min.z;
		camera.updateProjectionMatrix();
	}
	
}