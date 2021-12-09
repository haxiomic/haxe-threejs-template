package three;

@:jsRequire("three", "XRWebGLLayer") extern class XRWebGLLayer {
	function new(session:XRSession, gl:Null<WebGLRenderingContext>, ?options:XRWebGLLayerInit);
	var framebuffer : js.html.webgl.Framebuffer;
	var framebufferWidth : Float;
	var framebufferHeight : Float;
	function getViewport(view:XRView):XRViewport;
	static var prototype : XRWebGLLayer;
}