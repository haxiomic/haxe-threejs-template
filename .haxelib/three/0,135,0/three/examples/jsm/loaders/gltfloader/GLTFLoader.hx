package three.examples.jsm.loaders.gltfloader;

@:jsRequire("three/examples/jsm/loaders/GLTFLoader", "GLTFLoader") extern class GLTFLoader extends three.Loader {
	function new(?manager:three.LoadingManager);
	var dracoLoader : Null<three.examples.jsm.loaders.dracoloader.DRACOLoader>;
	function load(url:String, onLoad:(gltf:GLTF) -> Void, ?onProgress:(event:js.html.ProgressEvent_<js.html.EventTarget>) -> Void, ?onError:(event:js.html.ErrorEvent) -> Void):Void;
	function loadAsync(url:String, ?onProgress:(event:js.html.ProgressEvent_<js.html.EventTarget>) -> Void):js.lib.Promise<GLTF>;
	function setDRACOLoader(dracoLoader:three.examples.jsm.loaders.dracoloader.DRACOLoader):GLTFLoader;
	function register(callback:(parser:GLTFParser) -> GLTFLoaderPlugin):GLTFLoader;
	function unregister(callback:(parser:GLTFParser) -> GLTFLoaderPlugin):GLTFLoader;
	function setKTX2Loader(ktx2Loader:three.examples.jsm.loaders.ktx2loader.KTX2Loader):GLTFLoader;
	function setMeshoptDecoder(meshoptDecoder:Dynamic):GLTFLoader;
	function parse(data:ts.AnyOf2<String, js.lib.ArrayBuffer>, path:String, onLoad:(gltf:GLTF) -> Void, ?onError:(event:js.html.ErrorEvent) -> Void):Void;
	function parseAsync(data:ts.AnyOf2<String, js.lib.ArrayBuffer>, path:String):js.lib.Promise<ts.Undefined>;
	function setCrossOrigin(crossOrigin:String):GLTFLoader;
	function setWithCredentials(value:Bool):GLTFLoader;
	function setPath(path:String):GLTFLoader;
	function setResourcePath(resourcePath:String):GLTFLoader;
	function setRequestHeader(requestHeader:{ }):GLTFLoader;
	static var prototype : GLTFLoader;
}