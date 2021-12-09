package three;

/**
	see {@link https://github.com/mrdoob/three.js/blob/master/src/core/InterleavedBuffer.js|src/core/InterleavedBuffer.js}
**/
@:jsRequire("three", "InterleavedBuffer") extern class InterleavedBuffer {
	function new(array:js.lib.ArrayLike<Float>, stride:Float);
	var array : js.lib.ArrayLike<Float>;
	var stride : Float;
	var usage : Usage;
	var updateRange : {
		var offset : Float;
		var count : Float;
	};
	var version : Float;
	var length : Float;
	var count : Float;
	var needsUpdate : Bool;
	var uuid : String;
	function setUsage(usage:Usage):InterleavedBuffer;
	function clone(data:Dynamic):InterleavedBuffer;
	function copy(source:InterleavedBuffer):InterleavedBuffer;
	function copyAt(index1:Float, attribute:InterleavedBufferAttribute, index2:Float):InterleavedBuffer;
	function set(value:js.lib.ArrayLike<Float>, index:Float):InterleavedBuffer;
	function toJSON(data:Dynamic):{
		var uuid : String;
		var buffer : String;
		var type : String;
		var stride : Float;
	};
	static var prototype : InterleavedBuffer;
}