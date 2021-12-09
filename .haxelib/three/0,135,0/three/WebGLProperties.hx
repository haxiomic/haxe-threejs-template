package three;

@:jsRequire("three", "WebGLProperties") extern class WebGLProperties {
	function new();
	function get(object:Dynamic):Dynamic;
	function remove(object:Dynamic):Void;
	function update(object:Dynamic, key:Dynamic, value:Dynamic):Dynamic;
	function dispose():Void;
	static var prototype : WebGLProperties;
}