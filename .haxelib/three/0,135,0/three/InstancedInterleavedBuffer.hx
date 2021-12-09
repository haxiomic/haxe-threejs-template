package three;

/**
	see {@link https://github.com/mrdoob/three.js/blob/master/src/core/InstancedInterleavedBuffer.js|src/core/InstancedInterleavedBuffer.js}
**/
@:jsRequire("three", "InstancedInterleavedBuffer") extern class InstancedInterleavedBuffer extends InterleavedBuffer {
	function new(array:js.lib.ArrayLike<Float>, stride:Float, ?meshPerAttribute:Float);
	var meshPerAttribute : Float;
	function copy(source:InterleavedBuffer):InstancedInterleavedBuffer;
	static var prototype : InstancedInterleavedBuffer;
}