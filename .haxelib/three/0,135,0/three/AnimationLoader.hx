package three;

@:jsRequire("three", "AnimationLoader") extern class AnimationLoader extends Loader {
	function new(?manager:LoadingManager);
	function load(url:String, onLoad:(response:Array<AnimationClip>) -> Void, ?onProgress:(request:js.html.ProgressEvent_<js.html.EventTarget>) -> Void, ?onError:(event:js.html.ErrorEvent) -> Void):Void;
	function loadAsync(url:String, ?onProgress:(event:js.html.ProgressEvent_<js.html.EventTarget>) -> Void):js.lib.Promise<Array<AnimationClip>>;
	function parse(json:Dynamic):Array<AnimationClip>;
	function setCrossOrigin(crossOrigin:String):AnimationLoader;
	function setWithCredentials(value:Bool):AnimationLoader;
	function setPath(path:String):AnimationLoader;
	function setResourcePath(resourcePath:String):AnimationLoader;
	function setRequestHeader(requestHeader:{ }):AnimationLoader;
	static var prototype : AnimationLoader;
}