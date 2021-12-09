package three;

@:jsRequire("three", "Float64Attribute") extern class Float64Attribute extends BufferAttribute {
	function new(array:Dynamic, itemSize:Float);
	function onUpload(callback:() -> Void):Float64Attribute;
	function setUsage(usage:Usage):Float64Attribute;
	function clone():Float64Attribute;
	function copy(source:BufferAttribute):Float64Attribute;
	function copyAt(index1:Float, attribute:BufferAttribute, index2:Float):Float64Attribute;
	function copyArray(array:js.lib.ArrayLike<Float>):Float64Attribute;
	function copyColorsArray(colors:Array<{ var r : Float; var g : Float; var b : Float; }>):Float64Attribute;
	function copyVector2sArray(vectors:Array<{ var x : Float; var y : Float; }>):Float64Attribute;
	function copyVector3sArray(vectors:Array<{ var x : Float; var y : Float; var z : Float; }>):Float64Attribute;
	function copyVector4sArray(vectors:Array<{ var x : Float; var y : Float; var z : Float; var w : Float; }>):Float64Attribute;
	function applyMatrix3(m:Matrix3):Float64Attribute;
	function applyMatrix4(m:Matrix4):Float64Attribute;
	function applyNormalMatrix(m:Matrix3):Float64Attribute;
	function transformDirection(m:Matrix4):Float64Attribute;
	function set(value:ts.AnyOf2<js.lib.ArrayLike<Float>, js.lib.ArrayBufferView>, ?offset:Float):Float64Attribute;
	function setX(index:Float, x:Float):Float64Attribute;
	function setY(index:Float, y:Float):Float64Attribute;
	function setZ(index:Float, z:Float):Float64Attribute;
	function setW(index:Float, z:Float):Float64Attribute;
	function setXY(index:Float, x:Float, y:Float):Float64Attribute;
	function setXYZ(index:Float, x:Float, y:Float, z:Float):Float64Attribute;
	function setXYZW(index:Float, x:Float, y:Float, z:Float, w:Float):Float64Attribute;
	static var prototype : Float64Attribute;
}