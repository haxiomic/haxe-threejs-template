package three;

@:jsRequire("three", "SplineCurve") extern class SplineCurve extends Curve<Vector2> {
	function new(?points:Array<Vector2>);
	var points : Array<Vector2>;
	function clone():SplineCurve;
	function copy(source:Curve<Vector2>):SplineCurve;
	function fromJSON(json:Dynamic):SplineCurve;
	static var prototype : SplineCurve;
}