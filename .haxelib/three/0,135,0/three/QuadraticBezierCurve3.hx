package three;

@:jsRequire("three", "QuadraticBezierCurve3") extern class QuadraticBezierCurve3 extends Curve<Vector3> {
	function new(v0:Vector3, v1:Vector3, v2:Vector3);
	var v0 : Vector3;
	var v1 : Vector3;
	var v2 : Vector3;
	function clone():QuadraticBezierCurve3;
	function copy(source:Curve<Vector3>):QuadraticBezierCurve3;
	function fromJSON(json:Dynamic):QuadraticBezierCurve3;
	static var prototype : QuadraticBezierCurve3;
}