package three;

/**
	A loader for loading an image.
	Unlike other loaders, this one emits events instead of using predefined callbacks. So if you're interested in getting notified when things happen, you need to add listeners to the object.
**/
@:jsRequire("three", "ImageLoader") extern class ImageLoader extends Loader {
	function new(?manager:LoadingManager);
	function load(url:String, ?onLoad:(image:js.html.ImageElement) -> Void, ?onProgress:(event:js.html.ProgressEvent_<js.html.EventTarget>) -> Void, ?onError:(event:js.html.ErrorEvent) -> Void):js.html.ImageElement;
	function loadAsync(url:String, ?onProgress:(event:js.html.ProgressEvent_<js.html.EventTarget>) -> Void):js.lib.Promise<js.html.ImageElement>;
	function setCrossOrigin(crossOrigin:String):ImageLoader;
	function setWithCredentials(value:Bool):ImageLoader;
	function setPath(path:String):ImageLoader;
	function setResourcePath(resourcePath:String):ImageLoader;
	function setRequestHeader(requestHeader:{ }):ImageLoader;
	static var prototype : ImageLoader;
}