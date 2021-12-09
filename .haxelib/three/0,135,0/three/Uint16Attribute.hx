package three;

@:jsRequire("three", "Uint16Attribute") extern class Uint16Attribute extends BufferAttribute {
	function new(array:Dynamic, itemSize:Float);
	function onUpload(callback:() -> Void):Uint16Attribute;
	function setUsage(usage:Usage):Uint16Attribute;
	function clone():Uint16Attribute;
	function copy(source:BufferAttribute):Uint16Attribute;
	function copyAt(index1:Float, attribute:BufferAttribute, index2:Float):Uint16Attribute;
	function copyArray(array:js.lib.ArrayLike<Float>):Uint16Attribute;
	function copyColorsArray(colors:Array<{ var r : Float; var g : Float; var b : Float; }>):Uint16Attribute;
	function copyVector2sArray(vectors:Array<{ var x : Float; var y : Float; }>):Uint16Attribute;
	function copyVector3sArray(vectors:Array<{ var x : Float; var y : Float; var z : Float; }>):Uint16Attribute;
	function copyVector4sArray(vectors:Array<{ var x : Float; var y : Float; var z : Float; var w : Float; }>):Uint16Attribute;
	function applyMatrix3(m:Matrix3):Uint16Attribute;
	function applyMatrix4(m:Matrix4):Uint16Attribute;
	function applyNormalMatrix(m:Matrix3):Uint16Attribute;
	function transformDirection(m:Matrix4):Uint16Attribute;
	function set(value:ts.AnyOf2<js.lib.ArrayLike<Float>, js.lib.ArrayBufferView>, ?offset:Float):Uint16Attribute;
	function setX(index:Float, x:Float):Uint16Attribute;
	function setY(index:Float, y:Float):Uint16Attribute;
	function setZ(index:Float, z:Float):Uint16Attribute;
	function setW(index:Float, z:Float):Uint16Attribute;
	function setXY(index:Float, x:Float, y:Float):Uint16Attribute;
	function setXYZ(index:Float, x:Float, y:Float, z:Float):Uint16Attribute;
	function setXYZW(index:Float, x:Float, y:Float, z:Float, w:Float):Uint16Attribute;
	static var prototype : Uint16Attribute;
}