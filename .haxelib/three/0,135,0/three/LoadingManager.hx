package three;

/**
	Handles and keeps track of loaded and pending data.
**/
@:jsRequire("three", "LoadingManager") extern class LoadingManager {
	function new(?onLoad:() -> Void, ?onProgress:(url:String, loaded:Float, total:Float) -> Void, ?onError:(url:String) -> Void);
	/**
		Will be called when loading of an item starts.
	**/
	@:optional
	dynamic function onStart(url:String, loaded:Float, total:Float):Void;
	/**
		Will be called when all items finish loading.
		The default is a function with empty body.
	**/
	dynamic function onLoad():Void;
	/**
		Will be called for each loaded item.
		The default is a function with empty body.
	**/
	dynamic function onProgress(url:String, loaded:Float, total:Float):Void;
	/**
		Will be called when item loading fails.
		The default is a function with empty body.
	**/
	dynamic function onError(url:String):Void;
	/**
		If provided, the callback will be passed each resource URL before a request is sent.
		The callback may return the original URL, or a new URL to override loading behavior.
		This behavior can be used to load assets from .ZIP files, drag-and-drop APIs, and Data URIs.
	**/
	function setURLModifier(?callback:(url:String) -> String):LoadingManager;
	/**
		Given a URL, uses the URL modifier callback (if any) and returns a resolved URL.
		If no URL modifier is set, returns the original URL.
	**/
	function resolveURL(url:String):String;
	function itemStart(url:String):Void;
	function itemEnd(url:String):Void;
	function itemError(url:String):Void;
	function addHandler(regex:js.lib.RegExp, loader:Loader):LoadingManager;
	function removeHandler(regex:js.lib.RegExp):LoadingManager;
	function getHandler(file:String):Null<Loader>;
	static var prototype : LoadingManager;
}