package three.src.renderers.webgl.webglutils;

@:jsRequire("three/src/renderers/webgl/WebGLUtils", "WebGLUtils") extern class WebGLUtils {
	function new(gl:ts.AnyOf2<js.html.webgl.RenderingContext, js.html.webgl.WebGL2RenderingContext>, extensions:Dynamic, capabilities:Dynamic);
	function convert(p:Dynamic):Void;
	static var prototype : WebGLUtils;
}