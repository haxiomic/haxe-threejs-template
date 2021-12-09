package three;

/**
	This class originall extended WebGLMultipleRenderTarget
	However, there are some issues with this method as documented below
**/
@:jsRequire("three", "WebGLMultipleRenderTargets") extern class WebGLMultipleRenderTargets extends EventDispatcher<Event> {
	function new(width:Float, height:Float, count:Float);
	var texture : Array<Texture>;
	final isWebGLMultipleRenderTargets : Bool;
	function setSize(width:Float, height:Float, ?depth:Float):WebGLMultipleRenderTargets;
	function copy(source:WebGLMultipleRenderTargets):WebGLMultipleRenderTargets;
	function clone():WebGLMultipleRenderTargets;
	function dispose():Void;
	function setTexture(texture:Texture):Void;
	/**
		Adds a listener to an event type.
	**/
	function addEventListener<T>(type:T, listener:EventListener<Event, T, WebGLMultipleRenderTargets>):Void;
	/**
		Checks if listener is added to an event type.
	**/
	function hasEventListener<T>(type:T, listener:EventListener<Event, T, WebGLMultipleRenderTargets>):Bool;
	/**
		Removes a listener from an event type.
	**/
	function removeEventListener<T>(type:T, listener:EventListener<Event, T, WebGLMultipleRenderTargets>):Void;
	static var prototype : WebGLMultipleRenderTargets;
}