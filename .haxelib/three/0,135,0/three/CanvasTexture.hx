package three;

@:jsRequire("three", "CanvasTexture") extern class CanvasTexture extends Texture {
	function new(canvas:ts.AnyOf4<js.html.ImageElement, js.html.ImageBitmap, js.html.CanvasElement, js.html.VideoElement>, ?mapping:Mapping, ?wrapS:Wrapping, ?wrapT:Wrapping, ?magFilter:TextureFilter, ?minFilter:TextureFilter, ?format:PixelFormat, ?type:TextureDataType, ?anisotropy:Float);
	final isCanvasTexture : Bool;
	function clone():CanvasTexture;
	function copy(source:Texture):CanvasTexture;
	/**
		Adds a listener to an event type.
	**/
	function addEventListener<T>(type:T, listener:EventListener<Event, T, CanvasTexture>):Void;
	/**
		Checks if listener is added to an event type.
	**/
	function hasEventListener<T>(type:T, listener:EventListener<Event, T, CanvasTexture>):Bool;
	/**
		Removes a listener from an event type.
	**/
	function removeEventListener<T>(type:T, listener:EventListener<Event, T, CanvasTexture>):Void;
	static var prototype : CanvasTexture;
}