package three;

@:jsRequire("three", "Uint32Attribute") extern class Uint32Attribute extends BufferAttribute {
	function new(array:Dynamic, itemSize:Float);
	function onUpload(callback:() -> Void):Uint32Attribute;
	function setUsage(usage:Usage):Uint32Attribute;
	function clone():Uint32Attribute;
	function copy(source:BufferAttribute):Uint32Attribute;
	function copyAt(index1:Float, attribute:BufferAttribute, index2:Float):Uint32Attribute;
	function copyArray(array:js.lib.ArrayLike<Float>):Uint32Attribute;
	function copyColorsArray(colors:Array<{ var r : Float; var g : Float; var b : Float; }>):Uint32Attribute;
	function copyVector2sArray(vectors:Array<{ var x : Float; var y : Float; }>):Uint32Attribute;
	function copyVector3sArray(vectors:Array<{ var x : Float; var y : Float; var z : Float; }>):Uint32Attribute;
	function copyVector4sArray(vectors:Array<{ var x : Float; var y : Float; var z : Float; var w : Float; }>):Uint32Attribute;
	function applyMatrix3(m:Matrix3):Uint32Attribute;
	function applyMatrix4(m:Matrix4):Uint32Attribute;
	function applyNormalMatrix(m:Matrix3):Uint32Attribute;
	function transformDirection(m:Matrix4):Uint32Attribute;
	function set(value:ts.AnyOf2<js.lib.ArrayLike<Float>, js.lib.ArrayBufferView>, ?offset:Float):Uint32Attribute;
	function setX(index:Float, x:Float):Uint32Attribute;
	function setY(index:Float, y:Float):Uint32Attribute;
	function setZ(index:Float, z:Float):Uint32Attribute;
	function setW(index:Float, z:Float):Uint32Attribute;
	function setXY(index:Float, x:Float, y:Float):Uint32Attribute;
	function setXYZ(index:Float, x:Float, y:Float, z:Float):Uint32Attribute;
	function setXYZW(index:Float, x:Float, y:Float, z:Float, w:Float):Uint32Attribute;
	static var prototype : Uint32Attribute;
}