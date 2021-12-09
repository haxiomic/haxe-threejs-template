package three;

import rendering.RenderLayer;

@:jsRequire("three", "Layers") extern class Layers {
	function new();
	var mask : Int;
	function set(channel:RenderLayer):Void;
	function enable(channel:RenderLayer):Void;
	function enableAll():Void;
	function toggle(channel:RenderLayer):Void;
	function disable(channel:RenderLayer):Void;
	function disableAll():Void;
	function test(layers:Layers):Bool;
	static var prototype : Layers;
}