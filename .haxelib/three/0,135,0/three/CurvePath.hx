package three;

@:jsRequire("three", "CurvePath") extern class CurvePath<T> extends Curve<T> {
	function new();
	var curves : Array<Curve<T>>;
	var autoClose : Bool;
	function add(curve:Curve<T>):Void;
	function closePath():Void;
	function getCurveLengths():Array<Float>;
	function clone():CurvePath<T>;
	function copy(source:Curve<T>):CurvePath<T>;
	function fromJSON(json:Dynamic):CurvePath<T>;
	static var prototype : CurvePath<Dynamic>;
}