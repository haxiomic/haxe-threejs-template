package three.src.renderers.webgl.webglcubemaps;

@:jsRequire("three/src/renderers/webgl/WebGLCubeMaps", "WebGLCubeMaps") extern class WebGLCubeMaps {
	function new(renderer:three.WebGLRenderer);
	function get(texture:Dynamic):Dynamic;
	function dispose():Void;
	static var prototype : WebGLCubeMaps;
}