package three;

@:jsRequire("three", "WebXRManager") extern class WebXRManager extends EventDispatcher<Event> {
	function new(renderer:Dynamic, gl:js.html.webgl.RenderingContext);
	var enabled : Bool;
	var isPresenting : Bool;
	function getController(index:Float):Group;
	function getControllerGrip(index:Float):Group;
	function getHand(index:Float):Group;
	function setFramebufferScaleFactor(value:Float):Void;
	function setReferenceSpaceType(value:XRReferenceSpaceType):Void;
	function getReferenceSpace():Null<XRReferenceSpace>;
	function getSession():Null<XRSession>;
	function setSession(value:XRSession):js.lib.Promise<ts.Undefined>;
	function getCamera(camera:Camera):Camera;
	function setAnimationLoop(callback:XRFrameRequestCallback):Void;
	function getFoveation():Null<Float>;
	function setFoveation(foveation:Float):Void;
	function dispose():Void;
	/**
		Adds a listener to an event type.
	**/
	function addEventListener<T>(type:T, listener:EventListener<Event, T, WebXRManager>):Void;
	/**
		Checks if listener is added to an event type.
	**/
	function hasEventListener<T>(type:T, listener:EventListener<Event, T, WebXRManager>):Bool;
	/**
		Removes a listener from an event type.
	**/
	function removeEventListener<T>(type:T, listener:EventListener<Event, T, WebXRManager>):Void;
	static var prototype : WebXRManager;
}