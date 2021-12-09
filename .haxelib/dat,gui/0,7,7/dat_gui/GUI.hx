package dat_gui;

@:jsRequire("dat.gui", "GUI") extern class GUI {
	function new(?option:GUIParams);
	var __controllers : Array<GUIController>;
	var __folders : { };
	var domElement : js.html.Element;
	@:overload(function(target:Dynamic, propName:String, status:Bool):GUIController { })
	@:overload(function(target:Dynamic, propName:String, items:Array<String>):GUIController { })
	@:overload(function(target:Dynamic, propName:String, items:Array<Float>):GUIController { })
	@:overload(function(target:Dynamic, propName:String, items:Dynamic):GUIController { })
	function add(target:Dynamic, propName:String, ?min:Float, ?max:Float, ?step:Float):GUIController;
	function addColor(target:Dynamic, propName:String):GUIController;
	function remove(controller:GUIController):Void;
	function destroy():Void;
	function addFolder(propName:String):GUI;
	function removeFolder(subFolder:GUI):Void;
	function open():Void;
	function close():Void;
	function hide():Void;
	function show():Void;
	function remember(target:Dynamic, additionalTargets:haxe.extern.Rest<Dynamic>):Void;
	function getRoot():GUI;
	function getSaveObject():Dynamic;
	function save():Void;
	function saveAs(presetName:String):Void;
	function revert(gui:GUI):Void;
	function listen(controller:GUIController):Void;
	function updateDisplay():Void;
	final parent : GUI;
	final scrollable : Bool;
	final autoPlace : Bool;
	var preset : String;
	var width : Float;
	var name : String;
	var closed : Bool;
	final load : Dynamic;
	var useLocalStorage : Bool;
	static var prototype : GUI;
	static var CLASS_AUTO_PLACE : String;
	static var CLASS_AUTO_PLACE_CONTAINER : String;
	static var CLASS_MAIN : String;
	static var CLASS_CONTROLLER_ROW : String;
	static var CLASS_TOO_TALL : String;
	static var CLASS_CLOSED : String;
	static var CLASS_CLOSE_BUTTON : String;
	static var CLASS_CLOSE_TOP : String;
	static var CLASS_CLOSE_BOTTOM : String;
	static var CLASS_DRAG : String;
	static var DEFAULT_WIDTH : Float;
	static var TEXT_CLOSED : String;
	static var TEXT_OPEN : String;
}