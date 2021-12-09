package three;

@:jsRequire("three", "WebGLUniforms") extern class WebGLUniforms {
	function new(gl:js.html.webgl.RenderingContext, program:WebGLProgram);
	function setValue(gl:js.html.webgl.RenderingContext, name:String, value:Dynamic, textures:WebGLTextures):Void;
	function setOptional(gl:js.html.webgl.RenderingContext, object:Dynamic, name:String):Void;
	static var prototype : WebGLUniforms;
	static function upload(gl:js.html.webgl.RenderingContext, seq:Dynamic, values:Array<Dynamic>, textures:WebGLTextures):Void;
	static function seqWithValue(seq:Dynamic, values:Array<Dynamic>):Array<Dynamic>;
}