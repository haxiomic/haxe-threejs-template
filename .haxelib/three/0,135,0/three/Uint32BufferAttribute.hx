package three;

@:jsRequire("three", "Uint32BufferAttribute") extern class Uint32BufferAttribute extends BufferAttribute {
	function new(array:ts.AnyOf4<Float, js.lib.ArrayBuffer, js.lib.ArrayLike<Float>, Iterable<Float>>, itemSize:Float, ?normalized:Bool);
	function onUpload(callback:() -> Void):Uint32BufferAttribute;
	function setUsage(usage:Usage):Uint32BufferAttribute;
	function clone():Uint32BufferAttribute;
	function copy(source:BufferAttribute):Uint32BufferAttribute;
	function copyAt(index1:Float, attribute:BufferAttribute, index2:Float):Uint32BufferAttribute;
	function copyArray(array:js.lib.ArrayLike<Float>):Uint32BufferAttribute;
	function copyColorsArray(colors:Array<{ var r : Float; var g : Float; var b : Float; }>):Uint32BufferAttribute;
	function copyVector2sArray(vectors:Array<{ var x : Float; var y : Float; }>):Uint32BufferAttribute;
	function copyVector3sArray(vectors:Array<{ var x : Float; var y : Float; var z : Float; }>):Uint32BufferAttribute;
	function copyVector4sArray(vectors:Array<{ var x : Float; var y : Float; var z : Float; var w : Float; }>):Uint32BufferAttribute;
	function applyMatrix3(m:Matrix3):Uint32BufferAttribute;
	function applyMatrix4(m:Matrix4):Uint32BufferAttribute;
	function applyNormalMatrix(m:Matrix3):Uint32BufferAttribute;
	function transformDirection(m:Matrix4):Uint32BufferAttribute;
	function set(value:ts.AnyOf2<js.lib.ArrayLike<Float>, js.lib.ArrayBufferView>, ?offset:Float):Uint32BufferAttribute;
	function setX(index:Float, x:Float):Uint32BufferAttribute;
	function setY(index:Float, y:Float):Uint32BufferAttribute;
	function setZ(index:Float, z:Float):Uint32BufferAttribute;
	function setW(index:Float, z:Float):Uint32BufferAttribute;
	function setXY(index:Float, x:Float, y:Float):Uint32BufferAttribute;
	function setXYZ(index:Float, x:Float, y:Float, z:Float):Uint32BufferAttribute;
	function setXYZW(index:Float, x:Float, y:Float, z:Float, w:Float):Uint32BufferAttribute;
	static var prototype : Uint32BufferAttribute;
}