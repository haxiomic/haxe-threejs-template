package three;

@:jsRequire("three", "ArcCurve") extern class ArcCurve extends EllipseCurve {
	function new(aX:Float, aY:Float, aRadius:Float, aStartAngle:Float, aEndAngle:Float, aClockwise:Bool);
	function clone():ArcCurve;
	function copy(source:Curve<Vector2>):ArcCurve;
	function fromJSON(json:Dynamic):ArcCurve;
	static var prototype : ArcCurve;
}