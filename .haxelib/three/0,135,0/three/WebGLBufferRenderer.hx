package three;

@:jsRequire("three", "WebGLBufferRenderer") extern class WebGLBufferRenderer {
	function new(gl:js.html.webgl.RenderingContext, extensions:WebGLExtensions, info:WebGLInfo, capabilities:WebGLCapabilities);
	function setMode(value:Dynamic):Void;
	function render(start:Dynamic, count:Float):Void;
	function renderInstances(start:Dynamic, count:Float, primcount:Float):Void;
	static var prototype : WebGLBufferRenderer;
}