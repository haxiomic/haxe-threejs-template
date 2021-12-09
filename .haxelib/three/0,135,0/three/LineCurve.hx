package three;

@:jsRequire("three", "LineCurve") extern class LineCurve extends Curve<Vector2> {
	function new(v1:Vector2, v2:Vector2);
	var v1 : Vector2;
	var v2 : Vector2;
	function clone():LineCurve;
	function copy(source:Curve<Vector2>):LineCurve;
	function fromJSON(json:Dynamic):LineCurve;
	static var prototype : LineCurve;
}