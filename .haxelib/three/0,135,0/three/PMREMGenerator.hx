package three;

@:jsRequire("three", "PMREMGenerator") extern class PMREMGenerator {
	function new(renderer:WebGLRenderer);
	function fromScene(scene:Scene, ?sigma:Float, ?near:Float, ?far:Float):WebGLRenderTarget;
	function fromEquirectangular(equirectangular:Texture):WebGLRenderTarget;
	function fromCubemap(cubemap:CubeTexture):WebGLRenderTarget;
	function compileCubemapShader():Void;
	function compileEquirectangularShader():Void;
	function dispose():Void;
	static var prototype : PMREMGenerator;
}