package objects;

import three.Material;
import three.BufferAttribute;
import js.lib.Float32Array;
import three.BufferGeometry;
import three.Mesh;

class ClipSpaceTriangle<T: Material> extends Mesh<BufferGeometry, T> {

	public function new(material: Null<T>) {
		super(globalGeom, material);
		this.frustumCulled = false;
		this.castShadow = false;
		this.receiveShadow = false;
	}

	static final globalGeom: BufferGeometry = {
		var buffer = new BufferGeometry();
		var triangle = new Float32Array([
			-1, -1,
			 3, -1,
			-1,  3,
		]);
		var uv = new Float32Array(triangle.map(v -> v * 0.5 + 0.5));
		buffer.setAttribute('position', new BufferAttribute(triangle, 2));
		buffer.setAttribute('uv', new BufferAttribute(uv, 2));

		buffer;
	};

}