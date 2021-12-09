package rendering;

/**
	Represents a three.Texture with a width and height field defined
**/
@:forward
@:forward.new
@:transitive
abstract Texture(three.Texture) to three.Texture {

	public var width(get, never): Float;
	public var height(get, never): Float;
	inline function get_width() return untyped this.image.width;
	inline function get_height() return untyped this.image.height;

}