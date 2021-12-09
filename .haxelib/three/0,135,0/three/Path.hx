package three;

/**
	a 2d path representation, comprising of points, lines, and cubes, similar to the html5 2d canvas api. It extends CurvePath.
**/
@:jsRequire("three", "Path") extern class Path extends CurvePath<Vector2> {
	function new(?points:Array<Vector2>);
	var currentPoint : Vector2;
	function fromPoints(vectors:Array<Vector2>):Path;
	function setFromPoints(vectors:Array<Vector2>):Path;
	function moveTo(x:Float, y:Float):Path;
	function lineTo(x:Float, y:Float):Path;
	function quadraticCurveTo(aCPx:Float, aCPy:Float, aX:Float, aY:Float):Path;
	function bezierCurveTo(aCP1x:Float, aCP1y:Float, aCP2x:Float, aCP2y:Float, aX:Float, aY:Float):Path;
	function splineThru(pts:Array<Vector2>):Path;
	function arc(aX:Float, aY:Float, aRadius:Float, aStartAngle:Float, aEndAngle:Float, aClockwise:Bool):Path;
	function absarc(aX:Float, aY:Float, aRadius:Float, aStartAngle:Float, aEndAngle:Float, aClockwise:Bool):Path;
	function ellipse(aX:Float, aY:Float, xRadius:Float, yRadius:Float, aStartAngle:Float, aEndAngle:Float, aClockwise:Bool, aRotation:Float):Path;
	function absellipse(aX:Float, aY:Float, xRadius:Float, yRadius:Float, aStartAngle:Float, aEndAngle:Float, aClockwise:Bool, aRotation:Float):Path;
	function clone():Path;
	function copy(source:Curve<Vector2>):Path;
	function fromJSON(json:Dynamic):Path;
	static var prototype : Path;
}