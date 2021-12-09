package three;

typedef XRRenderStateInit = {
	@:optional
	var depthNear : Float;
	@:optional
	var depthFar : Float;
	@:optional
	var inlineVerticalFieldOfView : Float;
	@:optional
	var baseLayer : XRWebGLLayer;
};