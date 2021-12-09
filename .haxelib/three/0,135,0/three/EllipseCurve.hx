package three;

@:jsRequire("three", "EllipseCurve") extern class EllipseCurve extends Curve<Vector2> {
	function new(aX:Float, aY:Float, xRadius:Float, yRadius:Float, aStartAngle:Float, aEndAngle:Float, aClockwise:Bool, aRotation:Float);
	var aX : Float;
	var aY : Float;
	var xRadius : Float;
	var yRadius : Float;
	var aStartAngle : Float;
	var aEndAngle : Float;
	var aClockwise : Bool;
	var aRotation : Float;
	function clone():EllipseCurve;
	function copy(source:Curve<Vector2>):EllipseCurve;
	function fromJSON(json:Dynamic):EllipseCurve;
	static var prototype : EllipseCurve;
}