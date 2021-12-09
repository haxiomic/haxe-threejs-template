package three;

@:jsRequire("three", "Layers") extern class Layers {
	function new();
	var mask : Float;
	function set(channel:Float):Void;
	function enable(channel:Float):Void;
	function enableAll():Void;
	function toggle(channel:Float):Void;
	function disable(channel:Float):Void;
	function disableAll():Void;
	function test(layers:Layers):Bool;
	function isEnabled(channel:Float):Bool;
	static var prototype : Layers;
}