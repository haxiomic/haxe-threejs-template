package three;

@:jsRequire("three", "ShapeUtils") @valueModuleOnly extern class ShapeUtils {
	static function area(contour:Array<Vec2>):Float;
	static function triangulateShape(contour:Array<Vec2>, holes:Array<Array<Vec2>>):Array<Array<Float>>;
	static function isClockWise(pts:Array<Vec2>):Bool;
}