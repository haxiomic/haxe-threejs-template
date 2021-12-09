package three;

@:jsRequire("three", "CompressedTexture") extern class CompressedTexture extends Texture {
	function new(mipmaps:Array<js.html.ImageData>, width:Float, height:Float, ?format:CompressedPixelFormat, ?type:TextureDataType, ?mapping:Mapping, ?wrapS:Wrapping, ?wrapT:Wrapping, ?magFilter:TextureFilter, ?minFilter:TextureFilter, ?anisotropy:Float, ?encoding:TextureEncoding);
	final isCompressedTexture : Bool;
	function clone():CompressedTexture;
	function copy(source:Texture):CompressedTexture;
	/**
		Adds a listener to an event type.
	**/
	function addEventListener<T>(type:T, listener:EventListener<Event, T, CompressedTexture>):Void;
	/**
		Checks if listener is added to an event type.
	**/
	function hasEventListener<T>(type:T, listener:EventListener<Event, T, CompressedTexture>):Bool;
	/**
		Removes a listener from an event type.
	**/
	function removeEventListener<T>(type:T, listener:EventListener<Event, T, CompressedTexture>):Void;
	static var prototype : CompressedTexture;
}