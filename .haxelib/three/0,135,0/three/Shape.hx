package three;

/**
	Defines a 2d shape plane using paths.
**/
@:jsRequire("three", "Shape") extern class Shape extends Path {
	function new(?points:Array<Vector2>);
	var uuid : String;
	var holes : Array<Path>;
	function getPointsHoles(divisions:Float):Array<Array<Vector2>>;
	function extractPoints(divisions:Float):{
		var shape : Array<Vector2>;
		var holes : Array<Array<Vector2>>;
	};
	function fromPoints(vectors:Array<Vector2>):Shape;
	function setFromPoints(vectors:Array<Vector2>):Shape;
	function moveTo(x:Float, y:Float):Shape;
	function lineTo(x:Float, y:Float):Shape;
	function quadraticCurveTo(aCPx:Float, aCPy:Float, aX:Float, aY:Float):Shape;
	function bezierCurveTo(aCP1x:Float, aCP1y:Float, aCP2x:Float, aCP2y:Float, aX:Float, aY:Float):Shape;
	function splineThru(pts:Array<Vector2>):Shape;
	function arc(aX:Float, aY:Float, aRadius:Float, aStartAngle:Float, aEndAngle:Float, aClockwise:Bool):Shape;
	function absarc(aX:Float, aY:Float, aRadius:Float, aStartAngle:Float, aEndAngle:Float, aClockwise:Bool):Shape;
	function ellipse(aX:Float, aY:Float, xRadius:Float, yRadius:Float, aStartAngle:Float, aEndAngle:Float, aClockwise:Bool, aRotation:Float):Shape;
	function absellipse(aX:Float, aY:Float, xRadius:Float, yRadius:Float, aStartAngle:Float, aEndAngle:Float, aClockwise:Bool, aRotation:Float):Shape;
	function clone():Shape;
	function copy(source:Curve<Vector2>):Shape;
	function fromJSON(json:Dynamic):Shape;
	static var prototype : Shape;
}