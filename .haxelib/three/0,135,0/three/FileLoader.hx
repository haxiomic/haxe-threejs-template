package three;

@:jsRequire("three", "FileLoader") extern class FileLoader extends Loader {
	function new(?manager:LoadingManager);
	var mimeType : Null<js.html.MimeType>;
	var responseType : Null<String>;
	function load(url:String, ?onLoad:(response:ts.AnyOf2<String, js.lib.ArrayBuffer>) -> Void, ?onProgress:(request:js.html.ProgressEvent_<js.html.EventTarget>) -> Void, ?onError:(event:js.html.ErrorEvent) -> Void):Dynamic;
	function loadAsync(url:String, ?onProgress:(event:js.html.ProgressEvent_<js.html.EventTarget>) -> Void):js.lib.Promise<ts.AnyOf2<String, js.lib.ArrayBuffer>>;
	function setMimeType(mimeType:js.html.MimeType):FileLoader;
	function setResponseType(responseType:String):FileLoader;
	function setCrossOrigin(crossOrigin:String):FileLoader;
	function setWithCredentials(value:Bool):FileLoader;
	function setPath(path:String):FileLoader;
	function setResourcePath(resourcePath:String):FileLoader;
	function setRequestHeader(requestHeader:{ }):FileLoader;
	static var prototype : FileLoader;
}