package three;

/**
	An object with a series of statistical information about the graphics board memory and the rendering process.
**/
@:jsRequire("three", "WebGLInfo") extern class WebGLInfo {
	function new(gl:js.html.webgl.RenderingContext);
	var autoReset : Bool;
	var memory : {
		var geometries : Float;
		var textures : Float;
	};
	var programs : Null<Array<WebGLProgram>>;
	var render : {
		var calls : Float;
		var frame : Float;
		var lines : Float;
		var points : Float;
		var triangles : Float;
	};
	function update(count:Float, mode:Float, instanceCount:Float):Void;
	function reset():Void;
	static var prototype : WebGLInfo;
}