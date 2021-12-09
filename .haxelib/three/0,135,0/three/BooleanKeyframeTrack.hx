package three;

@:jsRequire("three", "BooleanKeyframeTrack") extern class BooleanKeyframeTrack extends KeyframeTrack {
	function new(name:String, times:Array<Dynamic>, values:Array<Dynamic>);
	function clone():BooleanKeyframeTrack;
	static var prototype : BooleanKeyframeTrack;
}