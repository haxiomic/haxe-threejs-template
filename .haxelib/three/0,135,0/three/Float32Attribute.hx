package three;

@:jsRequire("three", "Float32Attribute") extern class Float32Attribute extends BufferAttribute {
	function new(array:Dynamic, itemSize:Float);
	function onUpload(callback:() -> Void):Float32Attribute;
	function setUsage(usage:Usage):Float32Attribute;
	function clone():Float32Attribute;
	function copy(source:BufferAttribute):Float32Attribute;
	function copyAt(index1:Float, attribute:BufferAttribute, index2:Float):Float32Attribute;
	function copyArray(array:js.lib.ArrayLike<Float>):Float32Attribute;
	function copyColorsArray(colors:Array<{ var r : Float; var g : Float; var b : Float; }>):Float32Attribute;
	function copyVector2sArray(vectors:Array<{ var x : Float; var y : Float; }>):Float32Attribute;
	function copyVector3sArray(vectors:Array<{ var x : Float; var y : Float; var z : Float; }>):Float32Attribute;
	function copyVector4sArray(vectors:Array<{ var x : Float; var y : Float; var z : Float; var w : Float; }>):Float32Attribute;
	function applyMatrix3(m:Matrix3):Float32Attribute;
	function applyMatrix4(m:Matrix4):Float32Attribute;
	function applyNormalMatrix(m:Matrix3):Float32Attribute;
	function transformDirection(m:Matrix4):Float32Attribute;
	function set(value:ts.AnyOf2<js.lib.ArrayLike<Float>, js.lib.ArrayBufferView>, ?offset:Float):Float32Attribute;
	function setX(index:Float, x:Float):Float32Attribute;
	function setY(index:Float, y:Float):Float32Attribute;
	function setZ(index:Float, z:Float):Float32Attribute;
	function setW(index:Float, z:Float):Float32Attribute;
	function setXY(index:Float, x:Float, y:Float):Float32Attribute;
	function setXYZ(index:Float, x:Float, y:Float, z:Float):Float32Attribute;
	function setXYZW(index:Float, x:Float, y:Float, z:Float, w:Float):Float32Attribute;
	static var prototype : Float32Attribute;
}