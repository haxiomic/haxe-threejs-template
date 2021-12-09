package three;

@:jsRequire("three", "DataTexture2DArray") extern class DataTexture2DArray extends Texture {
	function new(?data:js.lib.BufferSource, ?width:Float, ?height:Float, ?depth:Float);
	var wrapR : Bool;
	final isDataTexture2DArray : Bool;
	function clone():DataTexture2DArray;
	function copy(source:Texture):DataTexture2DArray;
	/**
		Adds a listener to an event type.
	**/
	function addEventListener<T>(type:T, listener:EventListener<Event, T, DataTexture2DArray>):Void;
	/**
		Checks if listener is added to an event type.
	**/
	function hasEventListener<T>(type:T, listener:EventListener<Event, T, DataTexture2DArray>):Bool;
	/**
		Removes a listener from an event type.
	**/
	function removeEventListener<T>(type:T, listener:EventListener<Event, T, DataTexture2DArray>):Void;
	static var prototype : DataTexture2DArray;
}