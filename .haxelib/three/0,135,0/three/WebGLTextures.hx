package three;

@:jsRequire("three", "WebGLTextures") extern class WebGLTextures {
	function new(gl:js.html.webgl.RenderingContext, extensions:WebGLExtensions, state:WebGLState, properties:WebGLProperties, capabilities:WebGLCapabilities, utils:three.src.renderers.webgl.webglutils.WebGLUtils, info:WebGLInfo);
	function allocateTextureUnit():Void;
	function resetTextureUnits():Void;
	function setTexture2D(texture:Dynamic, slot:Float):Void;
	function setTexture2DArray(texture:Dynamic, slot:Float):Void;
	function setTexture3D(texture:Dynamic, slot:Float):Void;
	function setTextureCube(texture:Dynamic, slot:Float):Void;
	function setupRenderTarget(renderTarget:Dynamic):Void;
	function updateRenderTargetMipmap(renderTarget:Dynamic):Void;
	function updateMultisampleRenderTarget(renderTarget:Dynamic):Void;
	function safeSetTexture2D(texture:Dynamic, slot:Float):Void;
	function safeSetTextureCube(texture:Dynamic, slot:Float):Void;
	static var prototype : WebGLTextures;
}