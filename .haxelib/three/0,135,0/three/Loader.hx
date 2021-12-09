package three;

/**
	Base class for implementing loaders.
**/
@:jsRequire("three", "Loader") extern class Loader {
	function new(?manager:LoadingManager);
	var crossOrigin : String;
	var withCredentials : Bool;
	var path : String;
	var resourcePath : String;
	var manager : LoadingManager;
	var requestHeader : { };
	function loadAsync(url:String, ?onProgress:(event:js.html.ProgressEvent_<js.html.EventTarget>) -> Void):js.lib.Promise<Dynamic>;
	function setCrossOrigin(crossOrigin:String):Loader;
	function setWithCredentials(value:Bool):Loader;
	function setPath(path:String):Loader;
	function setResourcePath(resourcePath:String):Loader;
	function setRequestHeader(requestHeader:{ }):Loader;
	static var prototype : Loader;
}