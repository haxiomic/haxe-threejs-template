package three;

/**
	( class Matrix3 implements Matrix<Matrix3> )
**/
@:jsRequire("three", "Matrix3") extern class Matrix3 {
	/**
		Creates an identity matrix.
	**/
	function new();
	/**
		Array with matrix values.
	**/
	var elements : Array<Float>;
	function set(n11:Float, n12:Float, n13:Float, n21:Float, n22:Float, n23:Float, n31:Float, n32:Float, n33:Float):Matrix3;
	/**
		identity():T;
	**/
	function identity():Matrix3;
	/**
		clone():T;
	**/
	function clone():Matrix3;
	/**
		copy(m:T):T;
	**/
	function copy(m:Matrix3):Matrix3;
	function extractBasis(xAxis:Vector3, yAxis:Vector3, zAxis:Vector3):Matrix3;
	function setFromMatrix4(m:Matrix4):Matrix3;
	/**
		multiplyScalar(s:number):T;
	**/
	function multiplyScalar(s:Float):Matrix3;
	function determinant():Float;
	/**
		Inverts this matrix in place.
	**/
	function invert():Matrix3;
	/**
		Transposes this matrix in place.
	**/
	function transpose():Matrix3;
	function getNormalMatrix(matrix4:Matrix4):Matrix3;
	/**
		Transposes this matrix into the supplied array r, and returns itself.
	**/
	function transposeIntoArray(r:Array<Float>):Matrix3;
	function setUvTransform(tx:Float, ty:Float, sx:Float, sy:Float, rotation:Float, cx:Float, cy:Float):Matrix3;
	function scale(sx:Float, sy:Float):Matrix3;
	function rotate(theta:Float):Matrix3;
	function translate(tx:Float, ty:Float):Matrix3;
	function equals(matrix:Matrix3):Bool;
	/**
		Sets the values of this matrix from the provided array or array-like.
	**/
	function fromArray(array:ts.AnyOf2<Array<Float>, js.lib.ArrayLike<Float>>, ?offset:Float):Matrix3;
	/**
		Returns an array with the values of this matrix, or copies them into the provided array.
		
		Copies he values of this matrix into the provided array-like.
	**/
	@:overload(function(?array:Matrix3Tuple, ?offset:Int):Matrix3Tuple { })
	@:overload(function(?array:js.lib.ArrayLike<Float>, ?offset:Float):js.lib.ArrayLike<Float> { })
	function toArray(?array:Array<Float>, ?offset:Float):Array<Float>;
	/**
		Multiplies this matrix by m.
	**/
	function multiply(m:Matrix3):Matrix3;
	function premultiply(m:Matrix3):Matrix3;
	/**
		Sets this matrix to a x b.
	**/
	function multiplyMatrices(a:Matrix3, b:Matrix3):Matrix3;
	function multiplyVector3(vector:Vector3):Dynamic;
	function multiplyVector3Array(a:Dynamic):Dynamic;
	@:overload(function(matrix:Matrix):Matrix { })
	function getInverse(matrix:Matrix4, ?throwOnDegenerate:Bool):Matrix3;
	function flattenToArrayOffset(array:Array<Float>, offset:Float):Array<Float>;
	static var prototype : Matrix3;
}