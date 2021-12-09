package three;

@:jsRequire("three", "SphericalHarmonics3") extern class SphericalHarmonics3 {
	function new();
	var coefficients : Array<Vector3>;
	final isSphericalHarmonics3 : Bool;
	function set(coefficients:Array<Vector3>):SphericalHarmonics3;
	function zero():SphericalHarmonics3;
	function add(sh:SphericalHarmonics3):SphericalHarmonics3;
	function addScaledSH(sh:SphericalHarmonics3, s:Float):SphericalHarmonics3;
	function scale(s:Float):SphericalHarmonics3;
	function lerp(sh:SphericalHarmonics3, alpha:Float):SphericalHarmonics3;
	function equals(sh:SphericalHarmonics3):Bool;
	function copy(sh:SphericalHarmonics3):SphericalHarmonics3;
	function clone():SphericalHarmonics3;
	/**
		Sets the values of this spherical harmonics from the provided array or array-like.
	**/
	function fromArray(array:ts.AnyOf2<Array<Float>, js.lib.ArrayLike<Float>>, ?offset:Float):SphericalHarmonics3;
	/**
		Returns an array with the values of this spherical harmonics, or copies them into the provided array.
		
		Returns an array with the values of this spherical harmonics, or copies them into the provided array-like.
	**/
	@:overload(function(array:js.lib.ArrayLike<Float>, ?offset:Float):js.lib.ArrayLike<Float> { })
	function toArray(?array:Array<Float>, ?offset:Float):Array<Float>;
	function getAt(normal:Vector3, target:Vector3):Vector3;
	function getIrradianceAt(normal:Vector3, target:Vector3):Vector3;
	static var prototype : SphericalHarmonics3;
	static function getBasisAt(normal:Vector3, shBasis:Array<Float>):Void;
}