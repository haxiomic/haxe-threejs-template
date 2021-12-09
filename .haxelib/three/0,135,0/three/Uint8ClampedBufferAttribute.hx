package three;

@:jsRequire("three", "Uint8ClampedBufferAttribute") extern class Uint8ClampedBufferAttribute extends BufferAttribute {
	function new(array:ts.AnyOf4<Float, js.lib.ArrayBuffer, js.lib.ArrayLike<Float>, Iterable<Float>>, itemSize:Float, ?normalized:Bool);
	function onUpload(callback:() -> Void):Uint8ClampedBufferAttribute;
	function setUsage(usage:Usage):Uint8ClampedBufferAttribute;
	function clone():Uint8ClampedBufferAttribute;
	function copy(source:BufferAttribute):Uint8ClampedBufferAttribute;
	function copyAt(index1:Float, attribute:BufferAttribute, index2:Float):Uint8ClampedBufferAttribute;
	function copyArray(array:js.lib.ArrayLike<Float>):Uint8ClampedBufferAttribute;
	function copyColorsArray(colors:Array<{ var r : Float; var g : Float; var b : Float; }>):Uint8ClampedBufferAttribute;
	function copyVector2sArray(vectors:Array<{ var x : Float; var y : Float; }>):Uint8ClampedBufferAttribute;
	function copyVector3sArray(vectors:Array<{ var x : Float; var y : Float; var z : Float; }>):Uint8ClampedBufferAttribute;
	function copyVector4sArray(vectors:Array<{ var x : Float; var y : Float; var z : Float; var w : Float; }>):Uint8ClampedBufferAttribute;
	function applyMatrix3(m:Matrix3):Uint8ClampedBufferAttribute;
	function applyMatrix4(m:Matrix4):Uint8ClampedBufferAttribute;
	function applyNormalMatrix(m:Matrix3):Uint8ClampedBufferAttribute;
	function transformDirection(m:Matrix4):Uint8ClampedBufferAttribute;
	function set(value:ts.AnyOf2<js.lib.ArrayLike<Float>, js.lib.ArrayBufferView>, ?offset:Float):Uint8ClampedBufferAttribute;
	function setX(index:Float, x:Float):Uint8ClampedBufferAttribute;
	function setY(index:Float, y:Float):Uint8ClampedBufferAttribute;
	function setZ(index:Float, z:Float):Uint8ClampedBufferAttribute;
	function setW(index:Float, z:Float):Uint8ClampedBufferAttribute;
	function setXY(index:Float, x:Float, y:Float):Uint8ClampedBufferAttribute;
	function setXYZ(index:Float, x:Float, y:Float, z:Float):Uint8ClampedBufferAttribute;
	function setXYZW(index:Float, x:Float, y:Float, z:Float, w:Float):Uint8ClampedBufferAttribute;
	static var prototype : Uint8ClampedBufferAttribute;
}