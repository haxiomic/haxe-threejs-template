package three;

@:jsRequire("three", "Texture") extern class Texture extends EventDispatcher<Event> {
	function new(?image:ts.AnyOf3<js.html.ImageElement, js.html.CanvasElement, js.html.VideoElement>, ?mapping:Mapping, ?wrapS:Wrapping, ?wrapT:Wrapping, ?magFilter:TextureFilter, ?minFilter:TextureFilter, ?format:PixelFormat, ?type:TextureDataType, ?anisotropy:Float, ?encoding:TextureEncoding);
	var id : Float;
	var uuid : String;
	var name : String;
	var sourceFile : String;
	var image : Dynamic;
	var mipmaps : Array<Dynamic>;
	var mapping : Mapping;
	var wrapS : Wrapping;
	var wrapT : Wrapping;
	var magFilter : TextureFilter;
	var minFilter : TextureFilter;
	var anisotropy : Float;
	var format : PixelFormat;
	var internalFormat : Null<PixelFormatGPU>;
	var type : TextureDataType;
	var matrix : Matrix3;
	var matrixAutoUpdate : Bool;
	var offset : Vector2;
	var repeat : Vector2;
	var center : Vector2;
	var rotation : Float;
	var generateMipmaps : Bool;
	var premultiplyAlpha : Bool;
	var flipY : Bool;
	var unpackAlignment : Float;
	var encoding : TextureEncoding;
	var isRenderTargetTexture : Bool;
	/**
		An object that can be used to store custom data about the Material. It should not hold references to functions as these will not be cloned.
	**/
	var userData : Dynamic;
	var version : Float;
	var needsUpdate : Bool;
	final isTexture : Bool;
	dynamic function onUpdate():Void;
	function clone():Texture;
	function copy(source:Texture):Texture;
	function toJSON(meta:Dynamic):Dynamic;
	function dispose():Void;
	function transformUv(uv:Vector2):Vector2;
	function updateMatrix():Void;
	/**
		Adds a listener to an event type.
	**/
	function addEventListener<T>(type:T, listener:EventListener<Event, T, Texture>):Void;
	/**
		Checks if listener is added to an event type.
	**/
	function hasEventListener<T>(type:T, listener:EventListener<Event, T, Texture>):Bool;
	/**
		Removes a listener from an event type.
	**/
	function removeEventListener<T>(type:T, listener:EventListener<Event, T, Texture>):Void;
	static var prototype : Texture;
	static var DEFAULT_IMAGE : Dynamic;
	static var DEFAULT_MAPPING : Dynamic;
}