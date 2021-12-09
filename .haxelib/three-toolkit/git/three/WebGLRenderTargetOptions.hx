package three;

import three.PixelFormat;

/**
	Redefines WebGLRenderTargetOptions to correct type of format (PixelFormat)
**/
typedef WebGLRenderTargetOptions = {
	@:optional
	var wrapS : Wrapping;
	@:optional
	var wrapT : Wrapping;
	@:optional
	var magFilter : TextureFilter;
	@:optional
	var minFilter : TextureFilter;
	@:optional
	var format : PixelFormat;
	@:optional
	var type : TextureDataType;
	@:optional
	var anisotropy : Float;
	@:optional
	var depthBuffer : Bool;
	@:optional
	var stencilBuffer : Bool;
	@:optional
	var generateMipmaps : Bool;
	@:optional
	var depthTexture : DepthTexture;
	@:optional
	var encoding : TextureEncoding;
};