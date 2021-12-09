package three;

typedef XRWebGLLayerInit = {
	@:optional
	var antialias : Bool;
	@:optional
	var depth : Bool;
	@:optional
	var stencil : Bool;
	@:optional
	var alpha : Bool;
	@:optional
	var ignoreDepthValues : Bool;
	@:optional
	var framebufferScaleFactor : Float;
};