package tool;

inline function mat4FromThree(m: three.Matrix4) {
	var e = m.elements;
	return new Mat4(
		e[0],  e[1],  e[2],  e[3],
		e[4],  e[5],  e[6],  e[7],
		e[8],  e[9],  e[10], e[11],
		e[12], e[13], e[14], e[15]
	);
}