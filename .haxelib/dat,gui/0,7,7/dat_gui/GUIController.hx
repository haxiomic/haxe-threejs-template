package dat_gui;

@:jsRequire("dat.gui", "GUIController") extern class GUIController {
	function new(object:Dynamic, property:String);
	var domElement : js.html.Element;
	var object : Dynamic;
	var property : String;
	function options(option:Dynamic):GUIController;
	function name(name:String):GUIController;
	function listen():GUIController;
	function remove():GUIController;
	function onChange(fnc:ts.AnyOf2<() -> Void, (value:Dynamic) -> Void>):GUIController;
	function onFinishChange(fnc:ts.AnyOf2<() -> Void, (value:Dynamic) -> Void>):GUIController;
	function setValue(value:Dynamic):GUIController;
	function getValue():Dynamic;
	function updateDisplay():GUIController;
	function isModified():Bool;
	function min(n:Float):GUIController;
	function max(n:Float):GUIController;
	function step(n:Float):GUIController;
	function fire():GUIController;
	static var prototype : GUIController;
}