package three.examples.jsm.loaders.dracoloader;

@:jsRequire("three/examples/jsm/loaders/DRACOLoader", "DRACOLoader") extern class DRACOLoader extends three.Loader {
	function new(?manager:three.LoadingManager);
	function load(url:String, onLoad:(geometry:three.BufferGeometry) -> Void, ?onProgress:(event:js.html.ProgressEvent_<js.html.EventTarget>) -> Void, ?onError:(event:js.html.ErrorEvent) -> Void):Void;
	function loadAsync(url:String, ?onProgress:(event:js.html.ProgressEvent_<js.html.EventTarget>) -> Void):js.lib.Promise<three.BufferGeometry>;
	function setDecoderPath(path:String):DRACOLoader;
	function setDecoderConfig(config:Dynamic):DRACOLoader;
	function setWorkerLimit(workerLimit:Float):DRACOLoader;
	function preload():DRACOLoader;
	function dispose():DRACOLoader;
	function setCrossOrigin(crossOrigin:String):DRACOLoader;
	function setWithCredentials(value:Bool):DRACOLoader;
	function setPath(path:String):DRACOLoader;
	function setResourcePath(resourcePath:String):DRACOLoader;
	function setRequestHeader(requestHeader:{ }):DRACOLoader;
	static var prototype : DRACOLoader;
}