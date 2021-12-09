package three;

@:jsRequire("three", "DodecahedronGeometry") extern class DodecahedronGeometry extends PolyhedronGeometry {
	function new(?radius:Float, ?detail:Float);
	function copy(source:BufferGeometry):DodecahedronGeometry;
	/**
		Adds a listener to an event type.
	**/
	function addEventListener<T>(type:T, listener:EventListener<Event, T, DodecahedronGeometry>):Void;
	/**
		Checks if listener is added to an event type.
	**/
	function hasEventListener<T>(type:T, listener:EventListener<Event, T, DodecahedronGeometry>):Bool;
	/**
		Removes a listener from an event type.
	**/
	function removeEventListener<T>(type:T, listener:EventListener<Event, T, DodecahedronGeometry>):Void;
	static var prototype : DodecahedronGeometry;
	static function fromJSON(data:Dynamic):DodecahedronGeometry;
}