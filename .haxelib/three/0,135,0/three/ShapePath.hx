package three;

@:jsRequire("three", "ShapePath") extern class ShapePath {
	function new();
	var type : String;
	var color : Color;
	var subPaths : Array<Dynamic>;
	var currentPath : Dynamic;
	function moveTo(x:Float, y:Float):ShapePath;
	function lineTo(x:Float, y:Float):ShapePath;
	function quadraticCurveTo(aCPx:Float, aCPy:Float, aX:Float, aY:Float):ShapePath;
	function bezierCurveTo(aCP1x:Float, aCP1y:Float, aCP2x:Float, aCP2y:Float, aX:Float, aY:Float):ShapePath;
	function splineThru(pts:Array<Vector2>):ShapePath;
	function toShapes(isCCW:Bool, ?noHoles:Bool):Array<Shape>;
	static var prototype : ShapePath;
}