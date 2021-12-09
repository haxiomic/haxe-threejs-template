package three;

@:jsRequire("three", "WebGLPrograms") extern class WebGLPrograms {
	function new(renderer:WebGLRenderer, cubemaps:three.src.renderers.webgl.webglcubemaps.WebGLCubeMaps, extensions:WebGLExtensions, capabilities:WebGLCapabilities, bindingStates:three.src.renderers.webgl.webglbindingstates.WebGLBindingStates, clipping:WebGLClipping);
	var programs : Array<WebGLProgram>;
	function getParameters(material:Material, lights:Dynamic, shadows:Array<Dynamic>, scene:Scene, object:Dynamic):Dynamic;
	function getProgramCacheKey(parameters:Dynamic):String;
	function getUniforms(material:Material):Dynamic;
	function acquireProgram(parameters:Dynamic, cacheKey:String):WebGLProgram;
	function releaseProgram(program:WebGLProgram):Void;
	static var prototype : WebGLPrograms;
}