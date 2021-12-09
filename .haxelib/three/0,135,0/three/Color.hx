package three;

/**
	Represents a color. See also {@link ColorUtils}.
	
	see {@link https://github.com/mrdoob/three.js/blob/master/src/math/Color.js|src/math/Color.js}
**/
@:jsRequire("three", "Color") extern class Color {
	@:overload(function(r:Float, g:Float, b:Float):Color { })
	function new(?color:ColorRepresentation);
	final isColor : Bool;
	/**
		Red channel value between 0 and 1. Default is 1.
	**/
	var r : Float;
	/**
		Green channel value between 0 and 1. Default is 1.
	**/
	var g : Float;
	/**
		Blue channel value between 0 and 1. Default is 1.
	**/
	var b : Float;
	function set(color:ColorRepresentation):Color;
	function setScalar(scalar:Float):Color;
	function setHex(hex:Float):Color;
	/**
		Sets this color from RGB values.
	**/
	function setRGB(r:Float, g:Float, b:Float):Color;
	/**
		Sets this color from HSL values.
		Based on MochiKit implementation by Bob Ippolito.
	**/
	function setHSL(h:Float, s:Float, l:Float):Color;
	/**
		Sets this color from a CSS context style string.
	**/
	function setStyle(style:String):Color;
	/**
		Sets this color from a color name.
		Faster than {@link Color#setStyle .setStyle()} method if you don't need the other CSS-style formats.
	**/
	function setColorName(style:String):Color;
	/**
		Clones this color.
	**/
	function clone():Color;
	/**
		Copies given color.
	**/
	function copy(color:Color):Color;
	/**
		Copies given color making conversion from gamma to linear space.
	**/
	function copyGammaToLinear(color:Color, ?gammaFactor:Float):Color;
	/**
		Copies given color making conversion from linear to gamma space.
	**/
	function copyLinearToGamma(color:Color, ?gammaFactor:Float):Color;
	/**
		Converts this color from gamma to linear space.
	**/
	function convertGammaToLinear(?gammaFactor:Float):Color;
	/**
		Converts this color from linear to gamma space.
	**/
	function convertLinearToGamma(?gammaFactor:Float):Color;
	/**
		Copies given color making conversion from sRGB to linear space.
	**/
	function copySRGBToLinear(color:Color):Color;
	/**
		Copies given color making conversion from linear to sRGB space.
	**/
	function copyLinearToSRGB(color:Color):Color;
	/**
		Converts this color from sRGB to linear space.
	**/
	function convertSRGBToLinear():Color;
	/**
		Converts this color from linear to sRGB space.
	**/
	function convertLinearToSRGB():Color;
	/**
		Returns the hexadecimal value of this color.
	**/
	function getHex():Float;
	/**
		Returns the string formated hexadecimal value of this color.
	**/
	function getHexString():String;
	function getHSL(target:HSL):HSL;
	/**
		Returns the value of this color in CSS context style.
		Example: rgb(r, g, b)
	**/
	function getStyle():String;
	function offsetHSL(h:Float, s:Float, l:Float):Color;
	function add(color:Color):Color;
	function addColors(color1:Color, color2:Color):Color;
	function addScalar(s:Float):Color;
	function sub(color:Color):Color;
	function multiply(color:Color):Color;
	function multiplyScalar(s:Float):Color;
	function lerp(color:Color, alpha:Float):Color;
	function lerpColors(color1:Color, color2:Color, alpha:Float):Color;
	function lerpHSL(color:Color, alpha:Float):Color;
	function equals(color:Color):Bool;
	/**
		Sets this color's red, green and blue value from the provided array or array-like.
	**/
	function fromArray(array:ts.AnyOf2<Array<Float>, js.lib.ArrayLike<Float>>, ?offset:Float):Color;
	/**
		Returns an array [red, green, blue], or copies red, green and blue into the provided array.
		
		Copies red, green and blue into the provided array-like.
	**/
	@:overload(function(xyz:js.lib.ArrayLike<Float>, ?offset:Float):js.lib.ArrayLike<Float> { })
	function toArray(?array:Array<Float>, ?offset:Float):Array<Float>;
	function fromBufferAttribute(attribute:BufferAttribute, index:Float):Color;
	static var prototype : Color;
	/**
		List of X11 color names.
	**/
	static var NAMES : { };
}