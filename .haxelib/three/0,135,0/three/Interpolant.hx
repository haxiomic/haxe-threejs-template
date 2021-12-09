package three;

@:jsRequire("three", "Interpolant") extern class Interpolant {
	function new(parameterPositions:Dynamic, sampleValues:Dynamic, sampleSize:Float, ?resultBuffer:Dynamic);
	var parameterPositions : Dynamic;
	var sampleValues : Dynamic;
	var valueSize : Float;
	var resultBuffer : Dynamic;
	function evaluate(time:Float):Dynamic;
	static var prototype : Interpolant;
}