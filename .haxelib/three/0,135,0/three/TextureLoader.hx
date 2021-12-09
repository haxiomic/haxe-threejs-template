package three;

/**
	Class for loading a texture.
	Unlike other loaders, this one emits events instead of using predefined callbacks. So if you're interested in getting notified when things happen, you need to add listeners to the object.
**/
@:jsRequire("three", "TextureLoader") extern class TextureLoader extends Loader {
	function new(?manager:LoadingManager);
	function load(url:String, ?onLoad:(texture:Texture) -> Void, ?onProgress:(event:js.html.ProgressEvent_<js.html.EventTarget>) -> Void, ?onError:(event:js.html.ErrorEvent) -> Void):Texture;
	function loadAsync(url:String, ?onProgress:(event:js.html.ProgressEvent_<js.html.EventTarget>) -> Void):js.lib.Promise<Texture>;
	function setCrossOrigin(crossOrigin:String):TextureLoader;
	function setWithCredentials(value:Bool):TextureLoader;
	function setPath(path:String):TextureLoader;
	function setResourcePath(resourcePath:String):TextureLoader;
	function setRequestHeader(requestHeader:{ }):TextureLoader;
	static var prototype : TextureLoader;
}