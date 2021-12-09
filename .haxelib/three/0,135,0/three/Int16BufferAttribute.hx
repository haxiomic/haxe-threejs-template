package three;

@:jsRequire("three", "Int16BufferAttribute") extern class Int16BufferAttribute extends BufferAttribute {
	function new(array:ts.AnyOf4<Float, js.lib.ArrayBuffer, js.lib.ArrayLike<Float>, Iterable<Float>>, itemSize:Float, ?normalized:Bool);
	function onUpload(callback:() -> Void):Int16BufferAttribute;
	function setUsage(usage:Usage):Int16BufferAttribute;
	function clone():Int16BufferAttribute;
	function copy(source:BufferAttribute):Int16BufferAttribute;
	function copyAt(index1:Float, attribute:BufferAttribute, index2:Float):Int16BufferAttribute;
	function copyArray(array:js.lib.ArrayLike<Float>):Int16BufferAttribute;
	function copyColorsArray(colors:Array<{ var r : Float; var g : Float; var b : Float; }>):Int16BufferAttribute;
	function copyVector2sArray(vectors:Array<{ var x : Float; var y : Float; }>):Int16BufferAttribute;
	function copyVector3sArray(vectors:Array<{ var x : Float; var y : Float; var z : Float; }>):Int16BufferAttribute;
	function copyVector4sArray(vectors:Array<{ var x : Float; var y : Float; var z : Float; var w : Float; }>):Int16BufferAttribute;
	function applyMatrix3(m:Matrix3):Int16BufferAttribute;
	function applyMatrix4(m:Matrix4):Int16BufferAttribute;
	function applyNormalMatrix(m:Matrix3):Int16BufferAttribute;
	function transformDirection(m:Matrix4):Int16BufferAttribute;
	function set(value:ts.AnyOf2<js.lib.ArrayLike<Float>, js.lib.ArrayBufferView>, ?offset:Float):Int16BufferAttribute;
	function setX(index:Float, x:Float):Int16BufferAttribute;
	function setY(index:Float, y:Float):Int16BufferAttribute;
	function setZ(index:Float, z:Float):Int16BufferAttribute;
	function setW(index:Float, z:Float):Int16BufferAttribute;
	function setXY(index:Float, x:Float, y:Float):Int16BufferAttribute;
	function setXYZ(index:Float, x:Float, y:Float, z:Float):Int16BufferAttribute;
	function setXYZW(index:Float, x:Float, y:Float, z:Float, w:Float):Int16BufferAttribute;
	static var prototype : Int16BufferAttribute;
}