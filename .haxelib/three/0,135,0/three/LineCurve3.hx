package three;

@:jsRequire("three", "LineCurve3") extern class LineCurve3 extends Curve<Vector3> {
	function new(v1:Vector3, v2:Vector3);
	var v1 : Vector3;
	var v2 : Vector3;
	function clone():LineCurve3;
	function copy(source:Curve<Vector3>):LineCurve3;
	function fromJSON(json:Dynamic):LineCurve3;
	static var prototype : LineCurve3;
}