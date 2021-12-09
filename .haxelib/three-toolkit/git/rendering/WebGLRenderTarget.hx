package rendering;

/**
	Wraps three.WebGLRenderTarget but ensures its inner texture always has width and height defined
**/
@:forward
@:forward.new
abstract WebGLRenderTarget(three.WebGLRenderTarget) from three.WebGLRenderTarget to three.WebGLRenderTarget {

	public var texture(get, never): rendering.Texture;
	inline function get_texture() return cast this.texture;

}