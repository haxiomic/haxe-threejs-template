package three;

@:jsRequire("three", "CompressedTextureLoader") extern class CompressedTextureLoader extends Loader {
	function new(?manager:LoadingManager);
	function load(url:String, onLoad:(texture:CompressedTexture) -> Void, ?onProgress:(event:js.html.ProgressEvent_<js.html.EventTarget>) -> Void, ?onError:(event:js.html.ErrorEvent) -> Void):CompressedTexture;
	function loadAsync(url:String, ?onProgress:(event:js.html.ProgressEvent_<js.html.EventTarget>) -> Void):js.lib.Promise<CompressedTexture>;
	function setCrossOrigin(crossOrigin:String):CompressedTextureLoader;
	function setWithCredentials(value:Bool):CompressedTextureLoader;
	function setPath(path:String):CompressedTextureLoader;
	function setResourcePath(resourcePath:String):CompressedTextureLoader;
	function setRequestHeader(requestHeader:{ }):CompressedTextureLoader;
	static var prototype : CompressedTextureLoader;
}