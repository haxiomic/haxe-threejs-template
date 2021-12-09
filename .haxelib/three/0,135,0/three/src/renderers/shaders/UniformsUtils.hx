package three.src.renderers.shaders;

@:jsRequire("three/src/renderers/shaders/UniformsUtils") @valueModuleOnly extern class UniformsUtils {
	static function cloneUniforms(uniforms_src:Dynamic):Dynamic;
	static function mergeUniforms(uniforms:Array<Dynamic>):Dynamic;
}