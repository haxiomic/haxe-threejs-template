package three;

@:jsRequire("three", "Float32BufferAttribute") extern class Float32BufferAttribute extends BufferAttribute {
	function new(array:ts.AnyOf4<Float, js.lib.ArrayBuffer, js.lib.ArrayLike<Float>, Iterable<Float>>, itemSize:Float, ?normalized:Bool);
	function onUpload(callback:() -> Void):Float32BufferAttribute;
	function setUsage(usage:Usage):Float32BufferAttribute;
	function clone():Float32BufferAttribute;
	function copy(source:BufferAttribute):Float32BufferAttribute;
	function copyAt(index1:Float, attribute:BufferAttribute, index2:Float):Float32BufferAttribute;
	function copyArray(array:js.lib.ArrayLike<Float>):Float32BufferAttribute;
	function copyColorsArray(colors:Array<{ var r : Float; var g : Float; var b : Float; }>):Float32BufferAttribute;
	function copyVector2sArray(vectors:Array<{ var x : Float; var y : Float; }>):Float32BufferAttribute;
	function copyVector3sArray(vectors:Array<{ var x : Float; var y : Float; var z : Float; }>):Float32BufferAttribute;
	function copyVector4sArray(vectors:Array<{ var x : Float; var y : Float; var z : Float; var w : Float; }>):Float32BufferAttribute;
	function applyMatrix3(m:Matrix3):Float32BufferAttribute;
	function applyMatrix4(m:Matrix4):Float32BufferAttribute;
	function applyNormalMatrix(m:Matrix3):Float32BufferAttribute;
	function transformDirection(m:Matrix4):Float32BufferAttribute;
	function set(value:ts.AnyOf2<js.lib.ArrayLike<Float>, js.lib.ArrayBufferView>, ?offset:Float):Float32BufferAttribute;
	function setX(index:Float, x:Float):Float32BufferAttribute;
	function setY(index:Float, y:Float):Float32BufferAttribute;
	function setZ(index:Float, z:Float):Float32BufferAttribute;
	function setW(index:Float, z:Float):Float32BufferAttribute;
	function setXY(index:Float, x:Float, y:Float):Float32BufferAttribute;
	function setXYZ(index:Float, x:Float, y:Float, z:Float):Float32BufferAttribute;
	function setXYZW(index:Float, x:Float, y:Float, z:Float, w:Float):Float32BufferAttribute;
	static var prototype : Float32BufferAttribute;
}