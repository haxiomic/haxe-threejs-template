package three;

@:jsRequire("three", "StringKeyframeTrack") extern class StringKeyframeTrack extends KeyframeTrack {
	function new(name:String, times:Array<Dynamic>, values:Array<Dynamic>, ?interpolation:InterpolationModes);
	function clone():StringKeyframeTrack;
	static var prototype : StringKeyframeTrack;
}