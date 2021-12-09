package three;

@:jsRequire("three", "Int8Attribute") extern class Int8Attribute extends BufferAttribute {
	function new(array:Dynamic, itemSize:Float);
	function onUpload(callback:() -> Void):Int8Attribute;
	function setUsage(usage:Usage):Int8Attribute;
	function clone():Int8Attribute;
	function copy(source:BufferAttribute):Int8Attribute;
	function copyAt(index1:Float, attribute:BufferAttribute, index2:Float):Int8Attribute;
	function copyArray(array:js.lib.ArrayLike<Float>):Int8Attribute;
	function copyColorsArray(colors:Array<{ var r : Float; var g : Float; var b : Float; }>):Int8Attribute;
	function copyVector2sArray(vectors:Array<{ var x : Float; var y : Float; }>):Int8Attribute;
	function copyVector3sArray(vectors:Array<{ var x : Float; var y : Float; var z : Float; }>):Int8Attribute;
	function copyVector4sArray(vectors:Array<{ var x : Float; var y : Float; var z : Float; var w : Float; }>):Int8Attribute;
	function applyMatrix3(m:Matrix3):Int8Attribute;
	function applyMatrix4(m:Matrix4):Int8Attribute;
	function applyNormalMatrix(m:Matrix3):Int8Attribute;
	function transformDirection(m:Matrix4):Int8Attribute;
	function set(value:ts.AnyOf2<js.lib.ArrayLike<Float>, js.lib.ArrayBufferView>, ?offset:Float):Int8Attribute;
	function setX(index:Float, x:Float):Int8Attribute;
	function setY(index:Float, y:Float):Int8Attribute;
	function setZ(index:Float, z:Float):Int8Attribute;
	function setW(index:Float, z:Float):Int8Attribute;
	function setXY(index:Float, x:Float, y:Float):Int8Attribute;
	function setXYZ(index:Float, x:Float, y:Float, z:Float):Int8Attribute;
	function setXYZW(index:Float, x:Float, y:Float, z:Float, w:Float):Int8Attribute;
	static var prototype : Int8Attribute;
}