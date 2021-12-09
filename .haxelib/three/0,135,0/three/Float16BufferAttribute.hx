package three;

@:jsRequire("three", "Float16BufferAttribute") extern class Float16BufferAttribute extends BufferAttribute {
	function new(array:ts.AnyOf4<Float, js.lib.ArrayBuffer, js.lib.ArrayLike<Float>, Iterable<Float>>, itemSize:Float, ?normalized:Bool);
	function onUpload(callback:() -> Void):Float16BufferAttribute;
	function setUsage(usage:Usage):Float16BufferAttribute;
	function clone():Float16BufferAttribute;
	function copy(source:BufferAttribute):Float16BufferAttribute;
	function copyAt(index1:Float, attribute:BufferAttribute, index2:Float):Float16BufferAttribute;
	function copyArray(array:js.lib.ArrayLike<Float>):Float16BufferAttribute;
	function copyColorsArray(colors:Array<{ var r : Float; var g : Float; var b : Float; }>):Float16BufferAttribute;
	function copyVector2sArray(vectors:Array<{ var x : Float; var y : Float; }>):Float16BufferAttribute;
	function copyVector3sArray(vectors:Array<{ var x : Float; var y : Float; var z : Float; }>):Float16BufferAttribute;
	function copyVector4sArray(vectors:Array<{ var x : Float; var y : Float; var z : Float; var w : Float; }>):Float16BufferAttribute;
	function applyMatrix3(m:Matrix3):Float16BufferAttribute;
	function applyMatrix4(m:Matrix4):Float16BufferAttribute;
	function applyNormalMatrix(m:Matrix3):Float16BufferAttribute;
	function transformDirection(m:Matrix4):Float16BufferAttribute;
	function set(value:ts.AnyOf2<js.lib.ArrayLike<Float>, js.lib.ArrayBufferView>, ?offset:Float):Float16BufferAttribute;
	function setX(index:Float, x:Float):Float16BufferAttribute;
	function setY(index:Float, y:Float):Float16BufferAttribute;
	function setZ(index:Float, z:Float):Float16BufferAttribute;
	function setW(index:Float, z:Float):Float16BufferAttribute;
	function setXY(index:Float, x:Float, y:Float):Float16BufferAttribute;
	function setXYZ(index:Float, x:Float, y:Float, z:Float):Float16BufferAttribute;
	function setXYZW(index:Float, x:Float, y:Float, z:Float, w:Float):Float16BufferAttribute;
	static var prototype : Float16BufferAttribute;
}