package three;

@:enum @:jsRequire("three") extern abstract GLSLVersion(Int) from Int to Int {
	final GLSL1 : GLSLVersion;
	final GLSL3 : GLSLVersion;
}