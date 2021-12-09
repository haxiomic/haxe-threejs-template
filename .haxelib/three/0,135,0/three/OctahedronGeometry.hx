package three;

@:jsRequire("three", "OctahedronGeometry") extern class OctahedronGeometry extends PolyhedronGeometry {
	function new(?radius:Float, ?detail:Float);
	function copy(source:BufferGeometry):OctahedronGeometry;
	/**
		Adds a listener to an event type.
	**/
	function addEventListener<T>(type:T, listener:EventListener<Event, T, OctahedronGeometry>):Void;
	/**
		Checks if listener is added to an event type.
	**/
	function hasEventListener<T>(type:T, listener:EventListener<Event, T, OctahedronGeometry>):Bool;
	/**
		Removes a listener from an event type.
	**/
	function removeEventListener<T>(type:T, listener:EventListener<Event, T, OctahedronGeometry>):Void;
	static var prototype : OctahedronGeometry;
	static function fromJSON(data:Dynamic):OctahedronGeometry;
}