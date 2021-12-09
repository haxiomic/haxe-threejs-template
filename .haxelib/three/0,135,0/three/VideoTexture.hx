package three;

@:jsRequire("three", "VideoTexture") extern class VideoTexture extends Texture {
	function new(video:js.html.VideoElement, ?mapping:Mapping, ?wrapS:Wrapping, ?wrapT:Wrapping, ?magFilter:TextureFilter, ?minFilter:TextureFilter, ?format:PixelFormat, ?type:TextureDataType, ?anisotropy:Float);
	final isVideoTexture : Bool;
	function clone():VideoTexture;
	function copy(source:Texture):VideoTexture;
	/**
		Adds a listener to an event type.
	**/
	function addEventListener<T>(type:T, listener:EventListener<Event, T, VideoTexture>):Void;
	/**
		Checks if listener is added to an event type.
	**/
	function hasEventListener<T>(type:T, listener:EventListener<Event, T, VideoTexture>):Bool;
	/**
		Removes a listener from an event type.
	**/
	function removeEventListener<T>(type:T, listener:EventListener<Event, T, VideoTexture>):Void;
	static var prototype : VideoTexture;
}