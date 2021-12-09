package three;

/**
	see {@link https://github.com/mrdoob/three.js/blob/master/src/core/InstancedBufferGeometry.js|src/core/InstancedBufferGeometry.js}
**/
@:jsRequire("three", "InstancedBufferGeometry") extern class InstancedBufferGeometry extends BufferGeometry {
	function new();
	var isInstancedBufferGeometry : Bool;
	var instanceCount : Float;
	function addGroup(start:Float, count:Float, instances:Float):Void;
	function copy(source:BufferGeometry):InstancedBufferGeometry;
	/**
		Adds a listener to an event type.
	**/
	function addEventListener<T>(type:T, listener:EventListener<Event, T, InstancedBufferGeometry>):Void;
	/**
		Checks if listener is added to an event type.
	**/
	function hasEventListener<T>(type:T, listener:EventListener<Event, T, InstancedBufferGeometry>):Bool;
	/**
		Removes a listener from an event type.
	**/
	function removeEventListener<T>(type:T, listener:EventListener<Event, T, InstancedBufferGeometry>):Void;
	static var prototype : InstancedBufferGeometry;
}