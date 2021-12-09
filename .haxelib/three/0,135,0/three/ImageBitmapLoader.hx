package three;

@:jsRequire("three", "ImageBitmapLoader") extern class ImageBitmapLoader extends Loader {
	function new(?manager:LoadingManager);
	var options : Null<Dynamic>;
	final isImageBitmapLoader : Bool;
	function setOptions(options:Dynamic):ImageBitmapLoader;
	function load(url:String, ?onLoad:(response:js.html.ImageBitmap) -> Void, ?onProgress:(request:js.html.ProgressEvent_<js.html.EventTarget>) -> Void, ?onError:(event:js.html.ErrorEvent) -> Void):Dynamic;
	function loadAsync(url:String, ?onProgress:(event:js.html.ProgressEvent_<js.html.EventTarget>) -> Void):js.lib.Promise<js.html.ImageBitmap>;
	function setCrossOrigin(crossOrigin:String):ImageBitmapLoader;
	function setWithCredentials(value:Bool):ImageBitmapLoader;
	function setPath(path:String):ImageBitmapLoader;
	function setResourcePath(resourcePath:String):ImageBitmapLoader;
	function setRequestHeader(requestHeader:{ }):ImageBitmapLoader;
	static var prototype : ImageBitmapLoader;
}