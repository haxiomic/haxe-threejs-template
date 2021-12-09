package three;

@:jsRequire("three", "Uint8Attribute") extern class Uint8Attribute extends BufferAttribute {
	function new(array:Dynamic, itemSize:Float);
	function onUpload(callback:() -> Void):Uint8Attribute;
	function setUsage(usage:Usage):Uint8Attribute;
	function clone():Uint8Attribute;
	function copy(source:BufferAttribute):Uint8Attribute;
	function copyAt(index1:Float, attribute:BufferAttribute, index2:Float):Uint8Attribute;
	function copyArray(array:js.lib.ArrayLike<Float>):Uint8Attribute;
	function copyColorsArray(colors:Array<{ var r : Float; var g : Float; var b : Float; }>):Uint8Attribute;
	function copyVector2sArray(vectors:Array<{ var x : Float; var y : Float; }>):Uint8Attribute;
	function copyVector3sArray(vectors:Array<{ var x : Float; var y : Float; var z : Float; }>):Uint8Attribute;
	function copyVector4sArray(vectors:Array<{ var x : Float; var y : Float; var z : Float; var w : Float; }>):Uint8Attribute;
	function applyMatrix3(m:Matrix3):Uint8Attribute;
	function applyMatrix4(m:Matrix4):Uint8Attribute;
	function applyNormalMatrix(m:Matrix3):Uint8Attribute;
	function transformDirection(m:Matrix4):Uint8Attribute;
	function set(value:ts.AnyOf2<js.lib.ArrayLike<Float>, js.lib.ArrayBufferView>, ?offset:Float):Uint8Attribute;
	function setX(index:Float, x:Float):Uint8Attribute;
	function setY(index:Float, y:Float):Uint8Attribute;
	function setZ(index:Float, z:Float):Uint8Attribute;
	function setW(index:Float, z:Float):Uint8Attribute;
	function setXY(index:Float, x:Float, y:Float):Uint8Attribute;
	function setXYZ(index:Float, x:Float, y:Float, z:Float):Uint8Attribute;
	function setXYZW(index:Float, x:Float, y:Float, z:Float, w:Float):Uint8Attribute;
	static var prototype : Uint8Attribute;
}