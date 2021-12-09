package three;

/**
	see {@link https://github.com/mrdoob/three.js/blob/master/src/core/InterleavedBufferAttribute.js|src/core/InterleavedBufferAttribute.js}
**/
@:jsRequire("three", "InterleavedBufferAttribute") extern class InterleavedBufferAttribute {
	function new(interleavedBuffer:InterleavedBuffer, itemSize:Float, offset:Float, ?normalized:Bool);
	var name : String;
	var data : InterleavedBuffer;
	var itemSize : Float;
	var offset : Float;
	var normalized : Bool;
	final count : Float;
	final array : js.lib.ArrayLike<Float>;
	var needsUpdate : Bool;
	final isInterleavedBufferAttribute : Bool;
	function applyMatrix4(m:Matrix4):InterleavedBufferAttribute;
	function clone(?data:Dynamic):BufferAttribute;
	function getX(index:Float):Float;
	function setX(index:Float, x:Float):InterleavedBufferAttribute;
	function getY(index:Float):Float;
	function setY(index:Float, y:Float):InterleavedBufferAttribute;
	function getZ(index:Float):Float;
	function setZ(index:Float, z:Float):InterleavedBufferAttribute;
	function getW(index:Float):Float;
	function setW(index:Float, z:Float):InterleavedBufferAttribute;
	function setXY(index:Float, x:Float, y:Float):InterleavedBufferAttribute;
	function setXYZ(index:Float, x:Float, y:Float, z:Float):InterleavedBufferAttribute;
	function setXYZW(index:Float, x:Float, y:Float, z:Float, w:Float):InterleavedBufferAttribute;
	function toJSON(?data:Dynamic):{
		var isInterleavedBufferAttribute : Bool;
		var itemSize : Float;
		var data : String;
		var offset : Float;
		var normalized : Bool;
	};
	function applyNormalMatrix(matrix:Matrix):InterleavedBufferAttribute;
	function transformDirection(matrix:Matrix):InterleavedBufferAttribute;
	static var prototype : InterleavedBufferAttribute;
}