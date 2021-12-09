package three;

typedef XRRenderState = {
	final depthNear : Float;
	final depthFar : Float;
	@:optional
	final inlineVerticalFieldOfView : Float;
	@:optional
	final baseLayer : XRWebGLLayer;
};