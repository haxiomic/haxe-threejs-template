package three.examples.jsm.objects.reflector;

typedef ReflectorOptions = {
	@:optional
	var color : three.ColorRepresentation;
	@:optional
	var textureWidth : Float;
	@:optional
	var textureHeight : Float;
	@:optional
	var clipBias : Float;
	@:optional
	var shader : Dynamic;
	@:optional
	var encoding : three.TextureEncoding;
};