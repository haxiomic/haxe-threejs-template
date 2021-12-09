package three;

@:jsRequire("three", "WebGLCapabilities") extern class WebGLCapabilities {
	function new(gl:js.html.webgl.RenderingContext, extensions:Dynamic, parameters:WebGLCapabilitiesParameters);
	final isWebGL2 : Bool;
	var precision : String;
	var logarithmicDepthBuffer : Bool;
	var maxTextures : Float;
	var maxVertexTextures : Float;
	var maxTextureSize : Float;
	var maxCubemapSize : Float;
	var maxAttributes : Float;
	var maxVertexUniforms : Float;
	var maxVaryings : Float;
	var maxFragmentUniforms : Float;
	var vertexTextures : Bool;
	var floatFragmentTextures : Bool;
	var floatVertexTextures : Bool;
	function getMaxAnisotropy():Float;
	function getMaxPrecision(precision:String):String;
	static var prototype : WebGLCapabilities;
}