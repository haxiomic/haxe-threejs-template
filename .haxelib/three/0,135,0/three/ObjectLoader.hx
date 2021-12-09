package three;

@:jsRequire("three", "ObjectLoader") extern class ObjectLoader extends Loader {
	function new(?manager:LoadingManager);
	function load(url:String, ?onLoad:(object:Any) -> Void, ?onProgress:(event:js.html.ProgressEvent_<js.html.EventTarget>) -> Void, ?onError:(event:ts.AnyOf2<js.html.ErrorEvent, js.lib.Error>) -> Void):Void;
	function loadAsync<ObjectType>(url:String, ?onProgress:(event:js.html.ProgressEvent_<js.html.EventTarget>) -> Void):js.lib.Promise<ObjectType>;
	function parse<T>(json:Dynamic, ?onLoad:(object:Object3D<Event>) -> Void):T;
	function parseAsync<T>(json:Dynamic):js.lib.Promise<T>;
	function parseGeometries(json:Dynamic):{ };
	function parseMaterials(json:Dynamic, textures:Array<Texture>):Array<Material>;
	function parseAnimations(json:Dynamic):Array<AnimationClip>;
	function parseImages(json:Dynamic, onLoad:() -> Void):{ };
	function parseImagesAsync(json:Dynamic):js.lib.Promise<{ }>;
	function parseTextures(json:Dynamic, images:Dynamic):Array<Texture>;
	function parseObject<T>(data:Dynamic, geometries:Array<Dynamic>, materials:Array<Material>, animations:Array<AnimationClip>):T;
	function setCrossOrigin(crossOrigin:String):ObjectLoader;
	function setWithCredentials(value:Bool):ObjectLoader;
	function setPath(path:String):ObjectLoader;
	function setResourcePath(resourcePath:String):ObjectLoader;
	function setRequestHeader(requestHeader:{ }):ObjectLoader;
	static var prototype : ObjectLoader;
}