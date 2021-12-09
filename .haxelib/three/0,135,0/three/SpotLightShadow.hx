package three;

@:jsRequire("three", "SpotLightShadow") extern class SpotLightShadow extends LightShadow {
	function new();
	final isSpotLightShadow : Bool;
	var focus : Float;
	function copy(source:LightShadow):SpotLightShadow;
	function clone(?recursive:Bool):SpotLightShadow;
	static var prototype : SpotLightShadow;
}