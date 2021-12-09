package three;

@:jsRequire("three", "Float64BufferAttribute") extern class Float64BufferAttribute extends BufferAttribute {
	function new(array:ts.AnyOf4<Float, js.lib.ArrayBuffer, js.lib.ArrayLike<Float>, Iterable<Float>>, itemSize:Float, ?normalized:Bool);
	function onUpload(callback:() -> Void):Float64BufferAttribute;
	function setUsage(usage:Usage):Float64BufferAttribute;
	function clone():Float64BufferAttribute;
	function copy(source:BufferAttribute):Float64BufferAttribute;
	function copyAt(index1:Float, attribute:BufferAttribute, index2:Float):Float64BufferAttribute;
	function copyArray(array:js.lib.ArrayLike<Float>):Float64BufferAttribute;
	function copyColorsArray(colors:Array<{ var r : Float; var g : Float; var b : Float; }>):Float64BufferAttribute;
	function copyVector2sArray(vectors:Array<{ var x : Float; var y : Float; }>):Float64BufferAttribute;
	function copyVector3sArray(vectors:Array<{ var x : Float; var y : Float; var z : Float; }>):Float64BufferAttribute;
	function copyVector4sArray(vectors:Array<{ var x : Float; var y : Float; var z : Float; var w : Float; }>):Float64BufferAttribute;
	function applyMatrix3(m:Matrix3):Float64BufferAttribute;
	function applyMatrix4(m:Matrix4):Float64BufferAttribute;
	function applyNormalMatrix(m:Matrix3):Float64BufferAttribute;
	function transformDirection(m:Matrix4):Float64BufferAttribute;
	function set(value:ts.AnyOf2<js.lib.ArrayLike<Float>, js.lib.ArrayBufferView>, ?offset:Float):Float64BufferAttribute;
	function setX(index:Float, x:Float):Float64BufferAttribute;
	function setY(index:Float, y:Float):Float64BufferAttribute;
	function setZ(index:Float, z:Float):Float64BufferAttribute;
	function setW(index:Float, z:Float):Float64BufferAttribute;
	function setXY(index:Float, x:Float, y:Float):Float64BufferAttribute;
	function setXYZ(index:Float, x:Float, y:Float, z:Float):Float64BufferAttribute;
	function setXYZW(index:Float, x:Float, y:Float, z:Float, w:Float):Float64BufferAttribute;
	static var prototype : Float64BufferAttribute;
}