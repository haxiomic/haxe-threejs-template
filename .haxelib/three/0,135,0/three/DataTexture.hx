package three;

@:jsRequire("three", "DataTexture") extern class DataTexture extends Texture {
	function new(?data:js.lib.BufferSource, ?width:Float, ?height:Float, ?format:PixelFormat, ?type:TextureDataType, ?mapping:Mapping, ?wrapS:Wrapping, ?wrapT:Wrapping, ?magFilter:TextureFilter, ?minFilter:TextureFilter, ?anisotropy:Float, ?encoding:TextureEncoding);
	final isDataTexture : Bool;
	function clone():DataTexture;
	function copy(source:Texture):DataTexture;
	/**
		Adds a listener to an event type.
	**/
	function addEventListener<T>(type:T, listener:EventListener<Event, T, DataTexture>):Void;
	/**
		Checks if listener is added to an event type.
	**/
	function hasEventListener<T>(type:T, listener:EventListener<Event, T, DataTexture>):Bool;
	/**
		Removes a listener from an event type.
	**/
	function removeEventListener<T>(type:T, listener:EventListener<Event, T, DataTexture>):Void;
	static var prototype : DataTexture;
}