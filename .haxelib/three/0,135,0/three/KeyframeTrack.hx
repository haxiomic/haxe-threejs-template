package three;

@:jsRequire("three", "KeyframeTrack") extern class KeyframeTrack {
	function new(name:String, times:js.lib.ArrayLike<Dynamic>, values:js.lib.ArrayLike<Dynamic>, ?interpolation:InterpolationModes);
	var name : String;
	var times : js.lib.Float32Array;
	var values : js.lib.Float32Array;
	var ValueTypeName : String;
	var TimeBufferType : js.lib.Float32Array;
	var ValueBufferType : js.lib.Float32Array;
	var DefaultInterpolation : InterpolationModes;
	function InterpolantFactoryMethodDiscrete(result:Dynamic):DiscreteInterpolant;
	function InterpolantFactoryMethodLinear(result:Dynamic):LinearInterpolant;
	function InterpolantFactoryMethodSmooth(result:Dynamic):CubicInterpolant;
	function setInterpolation(interpolation:InterpolationModes):KeyframeTrack;
	function getInterpolation():InterpolationModes;
	function getValueSize():Float;
	function shift(timeOffset:Float):KeyframeTrack;
	function scale(timeScale:Float):KeyframeTrack;
	function trim(startTime:Float, endTime:Float):KeyframeTrack;
	function validate():Bool;
	function optimize():KeyframeTrack;
	function clone():KeyframeTrack;
	static var prototype : KeyframeTrack;
	static function toJSON(track:KeyframeTrack):Dynamic;
}