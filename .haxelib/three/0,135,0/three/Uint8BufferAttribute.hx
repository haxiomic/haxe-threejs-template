package three;

@:jsRequire("three", "Uint8BufferAttribute") extern class Uint8BufferAttribute extends BufferAttribute {
	function new(array:ts.AnyOf4<Float, js.lib.ArrayBuffer, js.lib.ArrayLike<Float>, Iterable<Float>>, itemSize:Float, ?normalized:Bool);
	function onUpload(callback:() -> Void):Uint8BufferAttribute;
	function setUsage(usage:Usage):Uint8BufferAttribute;
	function clone():Uint8BufferAttribute;
	function copy(source:BufferAttribute):Uint8BufferAttribute;
	function copyAt(index1:Float, attribute:BufferAttribute, index2:Float):Uint8BufferAttribute;
	function copyArray(array:js.lib.ArrayLike<Float>):Uint8BufferAttribute;
	function copyColorsArray(colors:Array<{ var r : Float; var g : Float; var b : Float; }>):Uint8BufferAttribute;
	function copyVector2sArray(vectors:Array<{ var x : Float; var y : Float; }>):Uint8BufferAttribute;
	function copyVector3sArray(vectors:Array<{ var x : Float; var y : Float; var z : Float; }>):Uint8BufferAttribute;
	function copyVector4sArray(vectors:Array<{ var x : Float; var y : Float; var z : Float; var w : Float; }>):Uint8BufferAttribute;
	function applyMatrix3(m:Matrix3):Uint8BufferAttribute;
	function applyMatrix4(m:Matrix4):Uint8BufferAttribute;
	function applyNormalMatrix(m:Matrix3):Uint8BufferAttribute;
	function transformDirection(m:Matrix4):Uint8BufferAttribute;
	function set(value:ts.AnyOf2<js.lib.ArrayLike<Float>, js.lib.ArrayBufferView>, ?offset:Float):Uint8BufferAttribute;
	function setX(index:Float, x:Float):Uint8BufferAttribute;
	function setY(index:Float, y:Float):Uint8BufferAttribute;
	function setZ(index:Float, z:Float):Uint8BufferAttribute;
	function setW(index:Float, z:Float):Uint8BufferAttribute;
	function setXY(index:Float, x:Float, y:Float):Uint8BufferAttribute;
	function setXYZ(index:Float, x:Float, y:Float, z:Float):Uint8BufferAttribute;
	function setXYZW(index:Float, x:Float, y:Float, z:Float, w:Float):Uint8BufferAttribute;
	static var prototype : Uint8BufferAttribute;
}