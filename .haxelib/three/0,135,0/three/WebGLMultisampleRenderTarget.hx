package three;

@:jsRequire("three", "WebGLMultisampleRenderTarget") extern class WebGLMultisampleRenderTarget extends WebGLRenderTarget {
	function new(width:Float, height:Float, ?options:WebGLRenderTargetOptions);
	final isWebGLMultisampleRenderTarget : Bool;
	/**
		Specifies the number of samples to be used for the renderbuffer storage.However, the maximum supported size for multisampling is platform dependent and defined via gl.MAX_SAMPLES.
	**/
	var samples : Float;
	function clone():WebGLMultisampleRenderTarget;
	function copy(source:WebGLRenderTarget):WebGLMultisampleRenderTarget;
	/**
		Adds a listener to an event type.
	**/
	function addEventListener<T>(type:T, listener:EventListener<Event, T, WebGLMultisampleRenderTarget>):Void;
	/**
		Checks if listener is added to an event type.
	**/
	function hasEventListener<T>(type:T, listener:EventListener<Event, T, WebGLMultisampleRenderTarget>):Bool;
	/**
		Removes a listener from an event type.
	**/
	function removeEventListener<T>(type:T, listener:EventListener<Event, T, WebGLMultisampleRenderTarget>):Void;
	static var prototype : WebGLMultisampleRenderTarget;
}