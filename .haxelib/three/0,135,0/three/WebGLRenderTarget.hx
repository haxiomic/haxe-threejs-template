package three;

@:jsRequire("three", "WebGLRenderTarget") extern class WebGLRenderTarget extends EventDispatcher<Event> {
	function new(width:Float, height:Float, ?options:WebGLRenderTargetOptions);
	var uuid : String;
	var width : Float;
	var height : Float;
	var depth : Float;
	var scissor : Vector4;
	var scissorTest : Bool;
	var viewport : Vector4;
	var texture : Texture;
	var depthBuffer : Bool;
	var stencilBuffer : Bool;
	var depthTexture : DepthTexture;
	final isWebGLRenderTarget : Bool;
	var wrapS : Dynamic;
	var wrapT : Dynamic;
	var magFilter : Dynamic;
	var minFilter : Dynamic;
	var anisotropy : Dynamic;
	var offset : Dynamic;
	var repeat : Dynamic;
	var format : Dynamic;
	var type : Dynamic;
	var generateMipmaps : Dynamic;
	function setTexture(texture:Texture):Void;
	function setSize(width:Float, height:Float, ?depth:Float):Void;
	function clone():WebGLRenderTarget;
	function copy(source:WebGLRenderTarget):WebGLRenderTarget;
	function dispose():Void;
	/**
		Adds a listener to an event type.
	**/
	function addEventListener<T>(type:T, listener:EventListener<Event, T, WebGLRenderTarget>):Void;
	/**
		Checks if listener is added to an event type.
	**/
	function hasEventListener<T>(type:T, listener:EventListener<Event, T, WebGLRenderTarget>):Bool;
	/**
		Removes a listener from an event type.
	**/
	function removeEventListener<T>(type:T, listener:EventListener<Event, T, WebGLRenderTarget>):Void;
	static var prototype : WebGLRenderTarget;
}