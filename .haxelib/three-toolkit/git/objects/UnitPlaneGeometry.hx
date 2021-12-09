package objects;

import three.PlaneGeometry;

class UnitPlaneGeometry extends three.PlaneGeometry {

	public function new() {
		super(1, 1, 1, 1);
	}

	static public final instance = new UnitPlaneGeometry();

}