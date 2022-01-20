package tool;

import three.Vector3;

inline function asMat4(m: three.Matrix4) {
	var e = m.elements;
	return new Mat4(
		e[0],  e[1],  e[2],  e[3],
		e[4],  e[5],  e[6],  e[7],
		e[8],  e[9],  e[10], e[11],
		e[12], e[13], e[14], e[15]
	);
}

inline function asVec3(v: Vector3) {
	return new Vec3(v.x, v.y, v.z);
}