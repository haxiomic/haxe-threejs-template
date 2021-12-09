package three;

/**
	A 4x4 Matrix.
**/
@:jsRequire("three", "Matrix4") extern class Matrix4 {
	function new();
	/**
		Array with matrix values.
	**/
	var elements : Array<Float>;
	/**
		Sets all fields of this matrix.
	**/
	function set(n11:Float, n12:Float, n13:Float, n14:Float, n21:Float, n22:Float, n23:Float, n24:Float, n31:Float, n32:Float, n33:Float, n34:Float, n41:Float, n42:Float, n43:Float, n44:Float):Matrix4;
	/**
		Resets this matrix to identity.
	**/
	function identity():Matrix4;
	/**
		clone():T;
	**/
	function clone():Matrix4;
	/**
		copy(m:T):T;
	**/
	function copy(m:Matrix4):Matrix4;
	function copyPosition(m:Matrix4):Matrix4;
	function extractBasis(xAxis:Vector3, yAxis:Vector3, zAxis:Vector3):Matrix4;
	function makeBasis(xAxis:Vector3, yAxis:Vector3, zAxis:Vector3):Matrix4;
	/**
		Copies the rotation component of the supplied matrix m into this matrix rotation component.
	**/
	function extractRotation(m:Matrix4):Matrix4;
	function makeRotationFromEuler(euler:Euler):Matrix4;
	function makeRotationFromQuaternion(q:Quaternion):Matrix4;
	/**
		Constructs a rotation matrix, looking from eye towards center with defined up vector.
	**/
	function lookAt(eye:Vector3, target:Vector3, up:Vector3):Matrix4;
	/**
		Multiplies this matrix by m.
	**/
	function multiply(m:Matrix4):Matrix4;
	function premultiply(m:Matrix4):Matrix4;
	/**
		Sets this matrix to a x b.
	**/
	function multiplyMatrices(a:Matrix4, b:Matrix4):Matrix4;
	/**
		Sets this matrix to a x b and stores the result into the flat array r.
		r can be either a regular Array or a TypedArray.
	**/
	function multiplyToArray(a:Matrix4, b:Matrix4, r:Array<Float>):Matrix4;
	/**
		Multiplies this matrix by s.
	**/
	function multiplyScalar(s:Float):Matrix4;
	/**
		Computes determinant of this matrix.
		Based on http://www.euclideanspace.com/maths/algebra/matrix/functions/inverse/fourD/index.htm
	**/
	function determinant():Float;
	/**
		Transposes this matrix.
	**/
	function transpose():Matrix4;
	/**
		Sets the position component for this matrix from vector v.
	**/
	function setPosition(v:ts.AnyOf2<Float, Vector3>, ?y:Float, ?z:Float):Matrix4;
	/**
		Inverts this matrix.
	**/
	function invert():Matrix4;
	/**
		Multiplies the columns of this matrix by vector v.
	**/
	function scale(v:Vector3):Matrix4;
	function getMaxScaleOnAxis():Float;
	/**
		Sets this matrix as translation transform.
	**/
	function makeTranslation(x:Float, y:Float, z:Float):Matrix4;
	/**
		Sets this matrix as rotation transform around x axis by theta radians.
	**/
	function makeRotationX(theta:Float):Matrix4;
	/**
		Sets this matrix as rotation transform around y axis by theta radians.
	**/
	function makeRotationY(theta:Float):Matrix4;
	/**
		Sets this matrix as rotation transform around z axis by theta radians.
	**/
	function makeRotationZ(theta:Float):Matrix4;
	/**
		Sets this matrix as rotation transform around axis by angle radians.
		Based on http://www.gamedev.net/reference/articles/article1199.asp.
	**/
	function makeRotationAxis(axis:Vector3, angle:Float):Matrix4;
	/**
		Sets this matrix as scale transform.
	**/
	function makeScale(x:Float, y:Float, z:Float):Matrix4;
	/**
		Sets this matrix as shear transform.
	**/
	function makeShear(xy:Float, xz:Float, yx:Float, yz:Float, zx:Float, zy:Float):Matrix4;
	/**
		Sets this matrix to the transformation composed of translation, rotation and scale.
	**/
	function compose(translation:Vector3, rotation:Quaternion, scale:Vector3):Matrix4;
	/**
		Decomposes this matrix into it's position, quaternion and scale components.
	**/
	function decompose(translation:Vector3, rotation:Quaternion, scale:Vector3):Matrix4;
	/**
		Creates a frustum matrix.
		
		Creates a perspective projection matrix.
	**/
	@:overload(function(fov:Float, aspect:Float, near:Float, far:Float):Matrix4 { })
	function makePerspective(left:Float, right:Float, bottom:Float, top:Float, near:Float, far:Float):Matrix4;
	/**
		Creates an orthographic projection matrix.
	**/
	function makeOrthographic(left:Float, right:Float, top:Float, bottom:Float, near:Float, far:Float):Matrix4;
	function equals(matrix:Matrix4):Bool;
	/**
		Sets the values of this matrix from the provided array or array-like.
	**/
	function fromArray(array:ts.AnyOf2<Array<Float>, js.lib.ArrayLike<Float>>, ?offset:Float):Matrix4;
	/**
		Returns an array with the values of this matrix, or copies them into the provided array.
		
		Copies he values of this matrix into the provided array-like.
	**/
	@:overload(function(?array:Matrix4Tuple, ?offset:Int):Matrix4Tuple { })
	@:overload(function(?array:js.lib.ArrayLike<Float>, ?offset:Float):js.lib.ArrayLike<Float> { })
	function toArray(?array:Array<Float>, ?offset:Float):Array<Float>;
	/**
		Set the upper 3x3 elements of this matrix to the values of the Matrix3 m.
	**/
	function setFromMatrix3(m:Matrix3):Matrix4;
	function extractPosition(m:Matrix4):Matrix4;
	function setRotationFromQuaternion(q:Quaternion):Matrix4;
	function multiplyVector3(v:Dynamic):Dynamic;
	function multiplyVector4(v:Dynamic):Dynamic;
	function multiplyVector3Array(array:Array<Float>):Array<Float>;
	function rotateAxis(v:Dynamic):Void;
	function crossVector(v:Dynamic):Void;
	function flattenToArrayOffset(array:Array<Float>, offset:Float):Array<Float>;
	function getInverse(matrix:Matrix):Matrix;
	static var prototype : Matrix4;
}