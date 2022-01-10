package three.examples.jsm.loaders.ktx2loader;

@:jsRequire("three/examples/jsm/loaders/KTX2Loader", "KTX2Loader") extern class KTX2Loader extends three.CompressedTextureLoader {
	function new(?manager:three.LoadingManager);
	function setTranscoderPath(path:String):KTX2Loader;
	function setWorkerLimit(limit:Float):KTX2Loader;
	function detectSupport(renderer:three.WebGLRenderer):KTX2Loader;
	function dispose():KTX2Loader;
	function parse(buffer:js.lib.ArrayBuffer, onLoad:(texture:three.CompressedTexture) -> Void, ?onError:(event:js.html.ErrorEvent) -> Void):KTX2Loader;
	function setCrossOrigin(crossOrigin:String):KTX2Loader;
	function setWithCredentials(value:Bool):KTX2Loader;
	function setPath(path:String):KTX2Loader;
	function setResourcePath(resourcePath:String):KTX2Loader;
	function setRequestHeader(requestHeader:{ }):KTX2Loader;
	static var prototype : KTX2Loader;
}