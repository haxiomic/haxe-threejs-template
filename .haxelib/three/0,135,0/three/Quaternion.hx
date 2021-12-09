package three;

/**
	Implementation of a quaternion. This is used for rotating things without incurring in the dreaded gimbal lock issue, amongst other advantages.
**/
@:jsRequire("three", "Quaternion") extern class Quaternion {
	function new(?x:Float, ?y:Float, ?z:Float, ?w:Float);
	var x : Float;
	var y : Float;
	var z : Float;
	var w : Float;
	final isQuaternion : Bool;
	/**
		Sets values of this quaternion.
	**/
	function set(x:Float, y:Float, z:Float, w:Float):Quaternion;
	/**
		Clones this quaternion.
	**/
	function clone():Quaternion;
	/**
		Copies values of q to this quaternion.
	**/
	function copy(q:Quaternion):Quaternion;
	/**
		Sets this quaternion from rotation specified by Euler angles.
	**/
	function setFromEuler(euler:Euler, ?update:Bool):Quaternion;
	/**
		Sets this quaternion from rotation specified by axis and angle.
		Adapted from http://www.euclideanspace.com/maths/geometry/rotations/conversions/angleToQuaternion/index.htm.
		Axis have to be normalized, angle is in radians.
	**/
	function setFromAxisAngle(axis:Vector3, angle:Float):Quaternion;
	/**
		Sets this quaternion from rotation component of m. Adapted from http://www.euclideanspace.com/maths/geometry/rotations/conversions/matrixToQuaternion/index.htm.
	**/
	function setFromRotationMatrix(m:Matrix4):Quaternion;
	function setFromUnitVectors(vFrom:Vector3, vTo:Vector3):Quaternion;
	function angleTo(q:Quaternion):Float;
	function rotateTowards(q:Quaternion, step:Float):Quaternion;
	function identity():Quaternion;
	/**
		Inverts this quaternion.
	**/
	function invert():Quaternion;
	function conjugate():Quaternion;
	function dot(v:Quaternion):Float;
	function lengthSq():Float;
	/**
		Computes length of this quaternion.
	**/
	function length():Float;
	/**
		Normalizes this quaternion.
	**/
	function normalize():Quaternion;
	/**
		Multiplies this quaternion by b.
	**/
	function multiply(q:Quaternion):Quaternion;
	function premultiply(q:Quaternion):Quaternion;
	/**
		Sets this quaternion to a x b
		Adapted from http://www.euclideanspace.com/maths/algebra/realNormedAlgebra/quaternions/code/index.htm.
	**/
	function multiplyQuaternions(a:Quaternion, b:Quaternion):Quaternion;
	function slerp(qb:Quaternion, t:Float):Quaternion;
	function slerpQuaternions(qa:Quaternion, qb:Quaternion, t:Float):Quaternion;
	function equals(v:Quaternion):Bool;
	/**
		Sets this quaternion's x, y, z and w value from the provided array or array-like.
	**/
	function fromArray(array:ts.AnyOf2<Array<Float>, js.lib.ArrayLike<Float>>, ?offset:Float):Quaternion;
	/**
		Returns an array [x, y, z, w], or copies x, y, z and w into the provided array.
		
		Copies x, y, z and w into the provided array-like.
	**/
	@:overload(function(array:js.lib.ArrayLike<Float>, ?offset:Float):js.lib.ArrayLike<Float> { })
	function toArray(?array:Array<Float>, ?offset:Float):Array<Float>;
	function _onChange(callback:() -> Void):Quaternion;
	dynamic function _onChangeCallback():Void;
	function multiplyVector3(v:Dynamic):Dynamic;
	function inverse():Quaternion;
	function random():Quaternion;
	static var prototype : Quaternion;
	static function slerpFlat(dst:Array<Float>, dstOffset:Float, src0:Array<Float>, srcOffset:Float, src1:Array<Float>, stcOffset1:Float, t:Float):Quaternion;
	static function multiplyQuaternionsFlat(dst:Array<Float>, dstOffset:Float, src0:Array<Float>, srcOffset:Float, src1:Array<Float>, stcOffset1:Float):Array<Float>;
	@:native("slerp")
	static function slerp_(qa:Quaternion, qb:Quaternion, qm:Quaternion, t:Float):Float;
}