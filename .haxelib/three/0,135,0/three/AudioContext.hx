package three;

/**
	see {@link https://github.com/mrdoob/three.js/blob/master/src/audio/AudioContext.js|src/audio/AudioContext.js}
**/
@:jsRequire("three", "AudioContext") @valueModuleOnly extern class AudioContext {
	static function getContext():js.html.audio.AudioContext;
	static function setContext():Void;
}