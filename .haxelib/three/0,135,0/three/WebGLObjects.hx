package three;

@:jsRequire("three", "WebGLObjects") extern class WebGLObjects {
	function new(gl:js.html.webgl.RenderingContext, geometries:Dynamic, attributes:Dynamic, info:Dynamic);
	function update(object:Dynamic):Dynamic;
	function dispose():Void;
	static var prototype : WebGLObjects;
}