package three;

@:jsRequire("three", "Uint8ClampedAttribute") extern class Uint8ClampedAttribute extends BufferAttribute {
	function new(array:Dynamic, itemSize:Float);
	function onUpload(callback:() -> Void):Uint8ClampedAttribute;
	function setUsage(usage:Usage):Uint8ClampedAttribute;
	function clone():Uint8ClampedAttribute;
	function copy(source:BufferAttribute):Uint8ClampedAttribute;
	function copyAt(index1:Float, attribute:BufferAttribute, index2:Float):Uint8ClampedAttribute;
	function copyArray(array:js.lib.ArrayLike<Float>):Uint8ClampedAttribute;
	function copyColorsArray(colors:Array<{ var r : Float; var g : Float; var b : Float; }>):Uint8ClampedAttribute;
	function copyVector2sArray(vectors:Array<{ var x : Float; var y : Float; }>):Uint8ClampedAttribute;
	function copyVector3sArray(vectors:Array<{ var x : Float; var y : Float; var z : Float; }>):Uint8ClampedAttribute;
	function copyVector4sArray(vectors:Array<{ var x : Float; var y : Float; var z : Float; var w : Float; }>):Uint8ClampedAttribute;
	function applyMatrix3(m:Matrix3):Uint8ClampedAttribute;
	function applyMatrix4(m:Matrix4):Uint8ClampedAttribute;
	function applyNormalMatrix(m:Matrix3):Uint8ClampedAttribute;
	function transformDirection(m:Matrix4):Uint8ClampedAttribute;
	function set(value:ts.AnyOf2<js.lib.ArrayLike<Float>, js.lib.ArrayBufferView>, ?offset:Float):Uint8ClampedAttribute;
	function setX(index:Float, x:Float):Uint8ClampedAttribute;
	function setY(index:Float, y:Float):Uint8ClampedAttribute;
	function setZ(index:Float, z:Float):Uint8ClampedAttribute;
	function setW(index:Float, z:Float):Uint8ClampedAttribute;
	function setXY(index:Float, x:Float, y:Float):Uint8ClampedAttribute;
	function setXYZ(index:Float, x:Float, y:Float, z:Float):Uint8ClampedAttribute;
	function setXYZW(index:Float, x:Float, y:Float, z:Float, w:Float):Uint8ClampedAttribute;
	static var prototype : Uint8ClampedAttribute;
}