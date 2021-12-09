package three;

/**
	see {@link https://github.com/mrdoob/three.js/blob/master/src/core/InstancedBufferAttribute.js|src/core/InstancedBufferAttribute.js}
**/
@:jsRequire("three", "InstancedBufferAttribute") extern class InstancedBufferAttribute extends BufferAttribute {
	function new(array:js.lib.ArrayLike<Float>, itemSize:Float, ?normalized:Bool, ?meshPerAttribute:Float);
	var meshPerAttribute : Float;
	function onUpload(callback:() -> Void):InstancedBufferAttribute;
	function setUsage(usage:Usage):InstancedBufferAttribute;
	function clone():InstancedBufferAttribute;
	function copy(source:BufferAttribute):InstancedBufferAttribute;
	function copyAt(index1:Float, attribute:BufferAttribute, index2:Float):InstancedBufferAttribute;
	function copyArray(array:js.lib.ArrayLike<Float>):InstancedBufferAttribute;
	function copyColorsArray(colors:Array<{ var r : Float; var g : Float; var b : Float; }>):InstancedBufferAttribute;
	function copyVector2sArray(vectors:Array<{ var x : Float; var y : Float; }>):InstancedBufferAttribute;
	function copyVector3sArray(vectors:Array<{ var x : Float; var y : Float; var z : Float; }>):InstancedBufferAttribute;
	function copyVector4sArray(vectors:Array<{ var x : Float; var y : Float; var z : Float; var w : Float; }>):InstancedBufferAttribute;
	function applyMatrix3(m:Matrix3):InstancedBufferAttribute;
	function applyMatrix4(m:Matrix4):InstancedBufferAttribute;
	function applyNormalMatrix(m:Matrix3):InstancedBufferAttribute;
	function transformDirection(m:Matrix4):InstancedBufferAttribute;
	function set(value:ts.AnyOf2<js.lib.ArrayLike<Float>, js.lib.ArrayBufferView>, ?offset:Float):InstancedBufferAttribute;
	function setX(index:Float, x:Float):InstancedBufferAttribute;
	function setY(index:Float, y:Float):InstancedBufferAttribute;
	function setZ(index:Float, z:Float):InstancedBufferAttribute;
	function setW(index:Float, z:Float):InstancedBufferAttribute;
	function setXY(index:Float, x:Float, y:Float):InstancedBufferAttribute;
	function setXYZ(index:Float, x:Float, y:Float, z:Float):InstancedBufferAttribute;
	function setXYZW(index:Float, x:Float, y:Float, z:Float, w:Float):InstancedBufferAttribute;
	static var prototype : InstancedBufferAttribute;
}