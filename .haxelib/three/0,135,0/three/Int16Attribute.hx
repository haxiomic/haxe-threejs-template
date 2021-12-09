package three;

@:jsRequire("three", "Int16Attribute") extern class Int16Attribute extends BufferAttribute {
	function new(array:Dynamic, itemSize:Float);
	function onUpload(callback:() -> Void):Int16Attribute;
	function setUsage(usage:Usage):Int16Attribute;
	function clone():Int16Attribute;
	function copy(source:BufferAttribute):Int16Attribute;
	function copyAt(index1:Float, attribute:BufferAttribute, index2:Float):Int16Attribute;
	function copyArray(array:js.lib.ArrayLike<Float>):Int16Attribute;
	function copyColorsArray(colors:Array<{ var r : Float; var g : Float; var b : Float; }>):Int16Attribute;
	function copyVector2sArray(vectors:Array<{ var x : Float; var y : Float; }>):Int16Attribute;
	function copyVector3sArray(vectors:Array<{ var x : Float; var y : Float; var z : Float; }>):Int16Attribute;
	function copyVector4sArray(vectors:Array<{ var x : Float; var y : Float; var z : Float; var w : Float; }>):Int16Attribute;
	function applyMatrix3(m:Matrix3):Int16Attribute;
	function applyMatrix4(m:Matrix4):Int16Attribute;
	function applyNormalMatrix(m:Matrix3):Int16Attribute;
	function transformDirection(m:Matrix4):Int16Attribute;
	function set(value:ts.AnyOf2<js.lib.ArrayLike<Float>, js.lib.ArrayBufferView>, ?offset:Float):Int16Attribute;
	function setX(index:Float, x:Float):Int16Attribute;
	function setY(index:Float, y:Float):Int16Attribute;
	function setZ(index:Float, z:Float):Int16Attribute;
	function setW(index:Float, z:Float):Int16Attribute;
	function setXY(index:Float, x:Float, y:Float):Int16Attribute;
	function setXYZ(index:Float, x:Float, y:Float, z:Float):Int16Attribute;
	function setXYZW(index:Float, x:Float, y:Float, z:Float, w:Float):Int16Attribute;
	static var prototype : Int16Attribute;
}