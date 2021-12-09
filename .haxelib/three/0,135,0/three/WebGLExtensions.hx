package three;

@:jsRequire("three", "WebGLExtensions") extern class WebGLExtensions {
	function new(gl:js.html.webgl.RenderingContext);
	function has(name:String):Bool;
	function init(capabilities:WebGLCapabilities):Void;
	function get(name:String):Dynamic;
	static var prototype : WebGLExtensions;
}