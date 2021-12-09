package three;

@:jsRequire("three", "CubeTextureLoader") extern class CubeTextureLoader extends Loader {
	function new(?manager:LoadingManager);
	function load(urls:Array<String>, ?onLoad:(texture:CubeTexture) -> Void, ?onProgress:(event:js.html.ProgressEvent_<js.html.EventTarget>) -> Void, ?onError:(event:js.html.ErrorEvent) -> Void):CubeTexture;
	function loadAsync(url:String, ?onProgress:(event:js.html.ProgressEvent_<js.html.EventTarget>) -> Void):js.lib.Promise<CubeTexture>;
	function setCrossOrigin(crossOrigin:String):CubeTextureLoader;
	function setWithCredentials(value:Bool):CubeTextureLoader;
	function setPath(path:String):CubeTextureLoader;
	function setResourcePath(resourcePath:String):CubeTextureLoader;
	function setRequestHeader(requestHeader:{ }):CubeTextureLoader;
	static var prototype : CubeTextureLoader;
}