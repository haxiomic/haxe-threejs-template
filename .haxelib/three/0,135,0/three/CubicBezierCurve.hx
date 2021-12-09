package three;

@:jsRequire("three", "CubicBezierCurve") extern class CubicBezierCurve extends Curve<Vector2> {
	function new(v0:Vector2, v1:Vector2, v2:Vector2, v3:Vector2);
	var v0 : Vector2;
	var v1 : Vector2;
	var v2 : Vector2;
	var v3 : Vector2;
	function clone():CubicBezierCurve;
	function copy(source:Curve<Vector2>):CubicBezierCurve;
	function fromJSON(json:Dynamic):CubicBezierCurve;
	static var prototype : CubicBezierCurve;
}