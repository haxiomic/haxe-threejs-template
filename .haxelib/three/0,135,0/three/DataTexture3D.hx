package three;

@:jsRequire("three", "DataTexture3D") extern class DataTexture3D extends Texture {
	function new(data:js.lib.BufferSource, width:Float, height:Float, depth:Float);
	var wrapR : Bool;
	final isDataTexture3D : Bool;
	function clone():DataTexture3D;
	function copy(source:Texture):DataTexture3D;
	/**
		Adds a listener to an event type.
	**/
	function addEventListener<T>(type:T, listener:EventListener<Event, T, DataTexture3D>):Void;
	/**
		Checks if listener is added to an event type.
	**/
	function hasEventListener<T>(type:T, listener:EventListener<Event, T, DataTexture3D>):Bool;
	/**
		Removes a listener from an event type.
	**/
	function removeEventListener<T>(type:T, listener:EventListener<Event, T, DataTexture3D>):Void;
	static var prototype : DataTexture3D;
}