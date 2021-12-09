package math;

import three.Matrix4;
import three.Plane;

function reflectionMatrixFromPlane(plane: Plane, ?target: Matrix4): Matrix4 {
	var reflectionMatrix = target != null ? target : new Matrix4();
	var a = plane.normal.x;
	var b = plane.normal.y;
	var c = plane.normal.z;
	var d = plane.constant;
	reflectionMatrix.set(
		1-2*a*a,  -2*a*b,  -2*a*c, -2*a*d,
		 -2*a*b, 1-2*b*b,  -2*b*c, -2*b*d,
		 -2*a*c,  -2*b*c, 1-2*c*c, -2*c*d,
			  0,       0,       0,      1
	);
	return reflectionMatrix;
}