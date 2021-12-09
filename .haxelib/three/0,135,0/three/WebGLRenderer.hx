package three;

/**
	The WebGL renderer displays your beautifully crafted scenes using WebGL, if your device supports it.
	This renderer has way better performance than CanvasRenderer.
	
	see {@link https://github.com/mrdoob/three.js/blob/master/src/renderers/WebGLRenderer.js|src/renderers/WebGLRenderer.js}
**/
@:jsRequire("three", "WebGLRenderer") extern class WebGLRenderer {
	/**
		parameters is an optional object with properties defining the renderer's behaviour.
		The constructor also accepts no parameters at all.
		In all cases, it will assume sane defaults when parameters are missing.
	**/
	function new(?parameters:WebGLRendererParameters);
	/**
		A Canvas where the renderer draws its output.
		This is automatically created by the renderer in the constructor (if not provided already); you just need to add it to your page.
	**/
	var domElement : js.html.CanvasElement;
	/**
		The HTML5 Canvas's 'webgl' context obtained from the canvas where the renderer will draw.
	**/
	var context : js.html.webgl.RenderingContext;
	/**
		Defines whether the renderer should automatically clear its output before rendering.
	**/
	var autoClear : Bool;
	/**
		If autoClear is true, defines whether the renderer should clear the color buffer. Default is true.
	**/
	var autoClearColor : Bool;
	/**
		If autoClear is true, defines whether the renderer should clear the depth buffer. Default is true.
	**/
	var autoClearDepth : Bool;
	/**
		If autoClear is true, defines whether the renderer should clear the stencil buffer. Default is true.
	**/
	var autoClearStencil : Bool;
	/**
		Debug configurations.
	**/
	var debug : WebGLDebug;
	/**
		Defines whether the renderer should sort objects. Default is true.
	**/
	var sortObjects : Bool;
	var clippingPlanes : Array<Dynamic>;
	var localClippingEnabled : Bool;
	var extensions : WebGLExtensions;
	/**
		Default is LinearEncoding.
	**/
	var outputEncoding : TextureEncoding;
	var physicallyCorrectLights : Bool;
	var toneMapping : ToneMapping;
	var toneMappingExposure : Float;
	var info : WebGLInfo;
	var shadowMap : WebGLShadowMap;
	var pixelRatio : Float;
	var capabilities : WebGLCapabilities;
	var properties : WebGLProperties;
	var renderLists : WebGLRenderLists;
	var state : WebGLState;
	var xr : WebXRManager;
	/**
		Return the WebGL context.
	**/
	function getContext():js.html.webgl.RenderingContext;
	function getContextAttributes():Dynamic;
	function forceContextLoss():Void;
	function forceContextRestore():Void;
	function getMaxAnisotropy():Float;
	function getPrecision():String;
	function getPixelRatio():Float;
	function setPixelRatio(value:Float):Void;
	function getDrawingBufferSize(target:Vector2):Vector2;
	function setDrawingBufferSize(width:Float, height:Float, pixelRatio:Float):Void;
	function getSize(target:Vector2):Vector2;
	/**
		Resizes the output canvas to (width, height), and also sets the viewport to fit that size, starting in (0, 0).
	**/
	function setSize(width:Float, height:Float, ?updateStyle:Bool):Void;
	function getCurrentViewport(target:Vector4):Vector4;
	/**
		Copies the viewport into target.
	**/
	function getViewport(target:Vector4):Vector4;
	/**
		Sets the viewport to render from (x, y) to (x + width, y + height).
		(x, y) is the lower-left corner of the region.
	**/
	function setViewport(x:ts.AnyOf2<Float, Vector4>, ?y:Float, ?width:Float, ?height:Float):Void;
	/**
		Copies the scissor area into target.
	**/
	function getScissor(target:Vector4):Vector4;
	/**
		Sets the scissor area from (x, y) to (x + width, y + height).
	**/
	function setScissor(x:ts.AnyOf2<Float, Vector4>, ?y:Float, ?width:Float, ?height:Float):Void;
	/**
		Returns true if scissor test is enabled; returns false otherwise.
	**/
	function getScissorTest():Bool;
	/**
		Enable the scissor test. When this is enabled, only the pixels within the defined scissor area will be affected by further renderer actions.
	**/
	function setScissorTest(enable:Bool):Void;
	/**
		Sets the custom opaque sort function for the WebGLRenderLists. Pass null to use the default painterSortStable function.
	**/
	function setOpaqueSort(method:(a:Dynamic, b:Dynamic) -> Float):Void;
	/**
		Sets the custom transparent sort function for the WebGLRenderLists. Pass null to use the default reversePainterSortStable function.
	**/
	function setTransparentSort(method:(a:Dynamic, b:Dynamic) -> Float):Void;
	/**
		Returns a THREE.Color instance with the current clear color.
	**/
	function getClearColor(target:Color):Color;
	/**
		Sets the clear color, using color for the color and alpha for the opacity.
	**/
	function setClearColor(color:ColorRepresentation, ?alpha:Float):Void;
	/**
		Returns a float with the current clear alpha. Ranges from 0 to 1.
	**/
	function getClearAlpha():Float;
	function setClearAlpha(alpha:Float):Void;
	/**
		Tells the renderer to clear its color, depth or stencil drawing buffer(s).
		Arguments default to true
	**/
	function clear(?color:Bool, ?depth:Bool, ?stencil:Bool):Void;
	function clearColor():Void;
	function clearDepth():Void;
	function clearStencil():Void;
	function clearTarget(renderTarget:WebGLRenderTarget, color:Bool, depth:Bool, stencil:Bool):Void;
	function resetGLState():Void;
	function dispose():Void;
	function renderBufferDirect(camera:Camera, scene:Scene, geometry:BufferGeometry, material:Material, object:Object3D<Event>, geometryGroup:Dynamic):Void;
	/**
		A build in function that can be used instead of requestAnimationFrame. For WebXR projects this function must be used.
	**/
	function setAnimationLoop(callback:Null<XRAnimationLoopCallback>):Void;
	function animate(callback:() -> Void):Void;
	/**
		Compiles all materials in the scene with the camera. This is useful to precompile shaders before the first rendering.
	**/
	function compile(scene:Object3D<Event>, camera:Camera):Void;
	/**
		Render a scene or an object using a camera.
		The render is done to a previously specified {@link WebGLRenderTarget#renderTarget .renderTarget} set by calling
		{@link WebGLRenderer#setRenderTarget .setRenderTarget} or to the canvas as usual.
		
		By default render buffers are cleared before rendering but you can prevent this by setting the property
		{@link WebGLRenderer#autoClear autoClear} to false. If you want to prevent only certain buffers being cleared
		you can set either the {@link WebGLRenderer#autoClearColor autoClearColor},
		{@link WebGLRenderer#autoClearStencil autoClearStencil} or {@link WebGLRenderer#autoClearDepth autoClearDepth}
		properties to false. To forcibly clear one ore more buffers call {@link WebGLRenderer#clear .clear}.
	**/
	function render(scene:Object3D<Event>, camera:Camera):Void;
	/**
		Returns the current active cube face.
	**/
	function getActiveCubeFace():Float;
	/**
		Returns the current active mipmap level.
	**/
	function getActiveMipmapLevel():Float;
	/**
		Returns the current render target. If no render target is set, null is returned.
	**/
	function getRenderTarget():Null<WebGLRenderTarget>;
	function getCurrentRenderTarget():Null<WebGLRenderTarget>;
	/**
		Sets the active render target.
	**/
	function setRenderTarget(renderTarget:Null<ts.AnyOf2<WebGLRenderTarget, WebGLMultipleRenderTargets>>, ?activeCubeFace:Float, ?activeMipmapLevel:Float):Void;
	function readRenderTargetPixels(renderTarget:ts.AnyOf2<WebGLRenderTarget, WebGLMultipleRenderTargets>, x:Float, y:Float, width:Float, height:Float, buffer:Dynamic, ?activeCubeFaceIndex:Float):Void;
	/**
		Copies a region of the currently bound framebuffer into the selected mipmap level of the selected texture.
		This region is defined by the size of the destination texture's mip level, offset by the input position.
	**/
	function copyFramebufferToTexture(position:Vector2, texture:Texture, ?level:Float):Void;
	/**
		Copies srcTexture to the specified level of dstTexture, offset by the input position.
	**/
	function copyTextureToTexture(position:Vector2, srcTexture:Texture, dstTexture:Texture, ?level:Float):Void;
	/**
		Copies the pixels of a texture in the bounds sourceBox in the desination texture starting from the given position.
	**/
	function copyTextureToTexture3D(sourceBox:Box3, position:Vector3, srcTexture:Texture, dstTexture:ts.AnyOf2<DataTexture3D, DataTexture2DArray>, ?level:Float):Void;
	/**
		Initializes the given texture. Can be used to preload a texture rather than waiting until first render (which can cause noticeable lags due to decode and GPU upload overhead).
	**/
	function initTexture(texture:Texture):Void;
	/**
		Can be used to reset the internal WebGL state.
	**/
	function resetState():Void;
	var gammaFactor : Float;
	var vr : Bool;
	var shadowMapEnabled : Bool;
	var shadowMapType : ShadowMapType;
	var shadowMapCullFace : CullFace;
	function supportsFloatTextures():Dynamic;
	function supportsHalfFloatTextures():Dynamic;
	function supportsStandardDerivatives():Dynamic;
	function supportsCompressedTextureS3TC():Dynamic;
	function supportsCompressedTexturePVRTC():Dynamic;
	function supportsBlendMinMax():Dynamic;
	function supportsVertexTextures():Dynamic;
	function supportsInstancedArrays():Dynamic;
	function enableScissorTest(boolean:Dynamic):Dynamic;
	static var prototype : WebGLRenderer;
}