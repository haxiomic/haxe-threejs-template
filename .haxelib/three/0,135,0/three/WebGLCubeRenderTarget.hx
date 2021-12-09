package three;

@:jsRequire("three", "WebGLCubeRenderTarget") extern class WebGLCubeRenderTarget extends WebGLRenderTarget {
	function new(size:Float, ?options:WebGLRenderTargetOptions);
	function fromEquirectangularTexture(renderer:WebGLRenderer, texture:Texture):WebGLCubeRenderTarget;
	function clear(renderer:WebGLRenderer, color:Bool, depth:Bool, stencil:Bool):Void;
	function clone():WebGLCubeRenderTarget;
	function copy(source:WebGLRenderTarget):WebGLCubeRenderTarget;
	/**
		Adds a listener to an event type.
	**/
	function addEventListener<T>(type:T, listener:EventListener<Event, T, WebGLCubeRenderTarget>):Void;
	/**
		Checks if listener is added to an event type.
	**/
	function hasEventListener<T>(type:T, listener:EventListener<Event, T, WebGLCubeRenderTarget>):Bool;
	/**
		Removes a listener from an event type.
	**/
	function removeEventListener<T>(type:T, listener:EventListener<Event, T, WebGLCubeRenderTarget>):Void;
	static var prototype : WebGLCubeRenderTarget;
}