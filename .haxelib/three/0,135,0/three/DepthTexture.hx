package three;

@:jsRequire("three", "DepthTexture") extern class DepthTexture extends Texture {
	function new(width:Float, height:Float, ?type:TextureDataType, ?mapping:Mapping, ?wrapS:Wrapping, ?wrapT:Wrapping, ?magFilter:TextureFilter, ?minFilter:TextureFilter, ?anisotropy:Float);
	final isDepthTexture : Bool;
	function clone():DepthTexture;
	function copy(source:Texture):DepthTexture;
	/**
		Adds a listener to an event type.
	**/
	function addEventListener<T>(type:T, listener:EventListener<Event, T, DepthTexture>):Void;
	/**
		Checks if listener is added to an event type.
	**/
	function hasEventListener<T>(type:T, listener:EventListener<Event, T, DepthTexture>):Bool;
	/**
		Removes a listener from an event type.
	**/
	function removeEventListener<T>(type:T, listener:EventListener<Event, T, DepthTexture>):Void;
	static var prototype : DepthTexture;
}