package three.examples.jsm.loaders.rgbeloader;

@:jsRequire("three/examples/jsm/loaders/RGBELoader", "RGBELoader") extern class RGBELoader extends three.DataTextureLoader {
	function new(?manager:three.LoadingManager);
	var type : three.TextureDataType;
	function parse(buffer:js.lib.ArrayBuffer):RGBE;
	function setDataType(type:three.TextureDataType):RGBELoader;
	function setCrossOrigin(crossOrigin:String):RGBELoader;
	function setWithCredentials(value:Bool):RGBELoader;
	function setPath(path:String):RGBELoader;
	function setResourcePath(resourcePath:String):RGBELoader;
	function setRequestHeader(requestHeader:{ }):RGBELoader;
	static var prototype : RGBELoader;
}