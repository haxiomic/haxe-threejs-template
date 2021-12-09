package three;

@:jsRequire("three", "CubeTexture") extern class CubeTexture extends Texture {
	function new(?images:Array<Dynamic>, ?mapping:Mapping, ?wrapS:Wrapping, ?wrapT:Wrapping, ?magFilter:TextureFilter, ?minFilter:TextureFilter, ?format:PixelFormat, ?type:TextureDataType, ?anisotropy:Float, ?encoding:TextureEncoding);
	var images : Dynamic;
	final isCubeTexture : Bool;
	function clone():CubeTexture;
	function copy(source:Texture):CubeTexture;
	/**
		Adds a listener to an event type.
	**/
	function addEventListener<T>(type:T, listener:EventListener<Event, T, CubeTexture>):Void;
	/**
		Checks if listener is added to an event type.
	**/
	function hasEventListener<T>(type:T, listener:EventListener<Event, T, CubeTexture>):Bool;
	/**
		Removes a listener from an event type.
	**/
	function removeEventListener<T>(type:T, listener:EventListener<Event, T, CubeTexture>):Void;
	static var prototype : CubeTexture;
}