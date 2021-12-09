package three.src.renderers.webgl;

@:jsRequire("three/src/renderers/webgl/WebGLShader") @valueModuleOnly extern class WebGLShader {
	static function WebGLShader(gl:js.html.webgl.RenderingContext, type:String, string:String):js.html.webgl.Shader;
}