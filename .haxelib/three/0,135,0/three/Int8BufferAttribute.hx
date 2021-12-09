package three;

@:jsRequire("three", "Int8BufferAttribute") extern class Int8BufferAttribute extends BufferAttribute {
	function new(array:ts.AnyOf4<Float, js.lib.ArrayBuffer, js.lib.ArrayLike<Float>, Iterable<Float>>, itemSize:Float, ?normalized:Bool);
	function onUpload(callback:() -> Void):Int8BufferAttribute;
	function setUsage(usage:Usage):Int8BufferAttribute;
	function clone():Int8BufferAttribute;
	function copy(source:BufferAttribute):Int8BufferAttribute;
	function copyAt(index1:Float, attribute:BufferAttribute, index2:Float):Int8BufferAttribute;
	function copyArray(array:js.lib.ArrayLike<Float>):Int8BufferAttribute;
	function copyColorsArray(colors:Array<{ var r : Float; var g : Float; var b : Float; }>):Int8BufferAttribute;
	function copyVector2sArray(vectors:Array<{ var x : Float; var y : Float; }>):Int8BufferAttribute;
	function copyVector3sArray(vectors:Array<{ var x : Float; var y : Float; var z : Float; }>):Int8BufferAttribute;
	function copyVector4sArray(vectors:Array<{ var x : Float; var y : Float; var z : Float; var w : Float; }>):Int8BufferAttribute;
	function applyMatrix3(m:Matrix3):Int8BufferAttribute;
	function applyMatrix4(m:Matrix4):Int8BufferAttribute;
	function applyNormalMatrix(m:Matrix3):Int8BufferAttribute;
	function transformDirection(m:Matrix4):Int8BufferAttribute;
	function set(value:ts.AnyOf2<js.lib.ArrayLike<Float>, js.lib.ArrayBufferView>, ?offset:Float):Int8BufferAttribute;
	function setX(index:Float, x:Float):Int8BufferAttribute;
	function setY(index:Float, y:Float):Int8BufferAttribute;
	function setZ(index:Float, z:Float):Int8BufferAttribute;
	function setW(index:Float, z:Float):Int8BufferAttribute;
	function setXY(index:Float, x:Float, y:Float):Int8BufferAttribute;
	function setXYZ(index:Float, x:Float, y:Float, z:Float):Int8BufferAttribute;
	function setXYZW(index:Float, x:Float, y:Float, z:Float, w:Float):Int8BufferAttribute;
	static var prototype : Int8BufferAttribute;
}