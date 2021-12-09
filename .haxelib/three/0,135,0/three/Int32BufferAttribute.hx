package three;

@:jsRequire("three", "Int32BufferAttribute") extern class Int32BufferAttribute extends BufferAttribute {
	function new(array:ts.AnyOf4<Float, js.lib.ArrayBuffer, js.lib.ArrayLike<Float>, Iterable<Float>>, itemSize:Float, ?normalized:Bool);
	function onUpload(callback:() -> Void):Int32BufferAttribute;
	function setUsage(usage:Usage):Int32BufferAttribute;
	function clone():Int32BufferAttribute;
	function copy(source:BufferAttribute):Int32BufferAttribute;
	function copyAt(index1:Float, attribute:BufferAttribute, index2:Float):Int32BufferAttribute;
	function copyArray(array:js.lib.ArrayLike<Float>):Int32BufferAttribute;
	function copyColorsArray(colors:Array<{ var r : Float; var g : Float; var b : Float; }>):Int32BufferAttribute;
	function copyVector2sArray(vectors:Array<{ var x : Float; var y : Float; }>):Int32BufferAttribute;
	function copyVector3sArray(vectors:Array<{ var x : Float; var y : Float; var z : Float; }>):Int32BufferAttribute;
	function copyVector4sArray(vectors:Array<{ var x : Float; var y : Float; var z : Float; var w : Float; }>):Int32BufferAttribute;
	function applyMatrix3(m:Matrix3):Int32BufferAttribute;
	function applyMatrix4(m:Matrix4):Int32BufferAttribute;
	function applyNormalMatrix(m:Matrix3):Int32BufferAttribute;
	function transformDirection(m:Matrix4):Int32BufferAttribute;
	function set(value:ts.AnyOf2<js.lib.ArrayLike<Float>, js.lib.ArrayBufferView>, ?offset:Float):Int32BufferAttribute;
	function setX(index:Float, x:Float):Int32BufferAttribute;
	function setY(index:Float, y:Float):Int32BufferAttribute;
	function setZ(index:Float, z:Float):Int32BufferAttribute;
	function setW(index:Float, z:Float):Int32BufferAttribute;
	function setXY(index:Float, x:Float, y:Float):Int32BufferAttribute;
	function setXYZ(index:Float, x:Float, y:Float, z:Float):Int32BufferAttribute;
	function setXYZW(index:Float, x:Float, y:Float, z:Float, w:Float):Int32BufferAttribute;
	static var prototype : Int32BufferAttribute;
}