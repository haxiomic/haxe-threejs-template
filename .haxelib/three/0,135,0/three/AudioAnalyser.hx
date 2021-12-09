package three;

@:jsRequire("three", "AudioAnalyser") extern class AudioAnalyser {
	function new(audio:Audio<js.html.audio.AudioNode>, ?fftSize:Float);
	var analyser : js.html.audio.AnalyserNode;
	var data : js.lib.Uint8Array;
	function getFrequencyData():js.lib.Uint8Array;
	function getAverageFrequency():Float;
	function getData(file:Dynamic):Dynamic;
	static var prototype : AudioAnalyser;
}