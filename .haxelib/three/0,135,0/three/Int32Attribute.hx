package three;

@:jsRequire("three", "Int32Attribute") extern class Int32Attribute extends BufferAttribute {
	function new(array:Dynamic, itemSize:Float);
	function onUpload(callback:() -> Void):Int32Attribute;
	function setUsage(usage:Usage):Int32Attribute;
	function clone():Int32Attribute;
	function copy(source:BufferAttribute):Int32Attribute;
	function copyAt(index1:Float, attribute:BufferAttribute, index2:Float):Int32Attribute;
	function copyArray(array:js.lib.ArrayLike<Float>):Int32Attribute;
	function copyColorsArray(colors:Array<{ var r : Float; var g : Float; var b : Float; }>):Int32Attribute;
	function copyVector2sArray(vectors:Array<{ var x : Float; var y : Float; }>):Int32Attribute;
	function copyVector3sArray(vectors:Array<{ var x : Float; var y : Float; var z : Float; }>):Int32Attribute;
	function copyVector4sArray(vectors:Array<{ var x : Float; var y : Float; var z : Float; var w : Float; }>):Int32Attribute;
	function applyMatrix3(m:Matrix3):Int32Attribute;
	function applyMatrix4(m:Matrix4):Int32Attribute;
	function applyNormalMatrix(m:Matrix3):Int32Attribute;
	function transformDirection(m:Matrix4):Int32Attribute;
	function set(value:ts.AnyOf2<js.lib.ArrayLike<Float>, js.lib.ArrayBufferView>, ?offset:Float):Int32Attribute;
	function setX(index:Float, x:Float):Int32Attribute;
	function setY(index:Float, y:Float):Int32Attribute;
	function setZ(index:Float, z:Float):Int32Attribute;
	function setW(index:Float, z:Float):Int32Attribute;
	function setXY(index:Float, x:Float, y:Float):Int32Attribute;
	function setXYZ(index:Float, x:Float, y:Float, z:Float):Int32Attribute;
	function setXYZW(index:Float, x:Float, y:Float, z:Float, w:Float):Int32Attribute;
	static var prototype : Int32Attribute;
}