package three;

@:jsRequire("three", "Uint16BufferAttribute") extern class Uint16BufferAttribute extends BufferAttribute {
	function new(array:ts.AnyOf4<Float, js.lib.ArrayBuffer, js.lib.ArrayLike<Float>, Iterable<Float>>, itemSize:Float, ?normalized:Bool);
	function onUpload(callback:() -> Void):Uint16BufferAttribute;
	function setUsage(usage:Usage):Uint16BufferAttribute;
	function clone():Uint16BufferAttribute;
	function copy(source:BufferAttribute):Uint16BufferAttribute;
	function copyAt(index1:Float, attribute:BufferAttribute, index2:Float):Uint16BufferAttribute;
	function copyArray(array:js.lib.ArrayLike<Float>):Uint16BufferAttribute;
	function copyColorsArray(colors:Array<{ var r : Float; var g : Float; var b : Float; }>):Uint16BufferAttribute;
	function copyVector2sArray(vectors:Array<{ var x : Float; var y : Float; }>):Uint16BufferAttribute;
	function copyVector3sArray(vectors:Array<{ var x : Float; var y : Float; var z : Float; }>):Uint16BufferAttribute;
	function copyVector4sArray(vectors:Array<{ var x : Float; var y : Float; var z : Float; var w : Float; }>):Uint16BufferAttribute;
	function applyMatrix3(m:Matrix3):Uint16BufferAttribute;
	function applyMatrix4(m:Matrix4):Uint16BufferAttribute;
	function applyNormalMatrix(m:Matrix3):Uint16BufferAttribute;
	function transformDirection(m:Matrix4):Uint16BufferAttribute;
	function set(value:ts.AnyOf2<js.lib.ArrayLike<Float>, js.lib.ArrayBufferView>, ?offset:Float):Uint16BufferAttribute;
	function setX(index:Float, x:Float):Uint16BufferAttribute;
	function setY(index:Float, y:Float):Uint16BufferAttribute;
	function setZ(index:Float, z:Float):Uint16BufferAttribute;
	function setW(index:Float, z:Float):Uint16BufferAttribute;
	function setXY(index:Float, x:Float, y:Float):Uint16BufferAttribute;
	function setXYZ(index:Float, x:Float, y:Float, z:Float):Uint16BufferAttribute;
	function setXYZW(index:Float, x:Float, y:Float, z:Float, w:Float):Uint16BufferAttribute;
	static var prototype : Uint16BufferAttribute;
}