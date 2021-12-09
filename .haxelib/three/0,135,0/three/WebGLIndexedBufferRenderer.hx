package three;

@:jsRequire("three", "WebGLIndexedBufferRenderer") extern class WebGLIndexedBufferRenderer {
	function new(gl:js.html.webgl.RenderingContext, extensions:Dynamic, info:Dynamic, capabilities:Dynamic);
	function setMode(value:Dynamic):Void;
	function setIndex(index:Dynamic):Void;
	function render(start:Dynamic, count:Float):Void;
	function renderInstances(start:Dynamic, count:Float, primcount:Float):Void;
	static var prototype : WebGLIndexedBufferRenderer;
}