package three;

@:jsRequire("three", "TetrahedronGeometry") extern class TetrahedronGeometry extends PolyhedronGeometry {
	function new(?radius:Float, ?detail:Float);
	function copy(source:BufferGeometry):TetrahedronGeometry;
	/**
		Adds a listener to an event type.
	**/
	function addEventListener<T>(type:T, listener:EventListener<Event, T, TetrahedronGeometry>):Void;
	/**
		Checks if listener is added to an event type.
	**/
	function hasEventListener<T>(type:T, listener:EventListener<Event, T, TetrahedronGeometry>):Bool;
	/**
		Removes a listener from an event type.
	**/
	function removeEventListener<T>(type:T, listener:EventListener<Event, T, TetrahedronGeometry>):Void;
	static var prototype : TetrahedronGeometry;
	static function fromJSON(data:Dynamic):TetrahedronGeometry;
}