package three;

/**
	JavaScript events for custom objects
**/
@:jsRequire("three", "EventDispatcher") extern class EventDispatcher<E> {
	/**
		Creates eventDispatcher object. It needs to be call with '.call' to add the functionality to an object.
	**/
	function new();
	/**
		Adds a listener to an event type.
	**/
	function addEventListener<T>(type:T, listener:EventListener<E, T, EventDispatcher<E>>):Void;
	/**
		Checks if listener is added to an event type.
	**/
	function hasEventListener<T>(type:T, listener:EventListener<E, T, EventDispatcher<E>>):Bool;
	/**
		Removes a listener from an event type.
	**/
	function removeEventListener<T>(type:T, listener:EventListener<E, T, EventDispatcher<E>>):Void;
	/**
		Fire an event type.
	**/
	function dispatchEvent(event:E):Void;
	static var prototype : EventDispatcher<Dynamic>;
}