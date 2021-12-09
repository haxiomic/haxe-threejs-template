package three;

/**
	see {@link https://github.com/mrdoob/three.js/blob/master/src/core/GLBufferAttribute.js|src/core/GLBufferAttribute.js}
**/
@:jsRequire("three", "GLBufferAttribute") extern class GLBufferAttribute {
	function new(buffer:js.html.webgl.Buffer, type:Float, itemSize:Float, elementSize:Int, count:Float);
	var buffer : js.html.webgl.Buffer;
	var type : Float;
	var itemSize : Float;
	var elementSize : Int;
	var count : Float;
	var version : Float;
	final isGLBufferAttribute : Bool;
	var needsUpdate : Bool;
	function setBuffer(buffer:js.html.webgl.Buffer):GLBufferAttribute;
	function setType(type:Float, elementSize:Int):GLBufferAttribute;
	function setItemSize(itemSize:Float):GLBufferAttribute;
	function setCount(count:Float):GLBufferAttribute;
	static var prototype : GLBufferAttribute;
}