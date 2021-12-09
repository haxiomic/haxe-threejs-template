package three;

@:jsRequire("three", "IcosahedronGeometry") extern class IcosahedronGeometry extends PolyhedronGeometry {
	function new(?radius:Float, ?detail:Float);
	function copy(source:BufferGeometry):IcosahedronGeometry;
	/**
		Adds a listener to an event type.
	**/
	function addEventListener<T>(type:T, listener:EventListener<Event, T, IcosahedronGeometry>):Void;
	/**
		Checks if listener is added to an event type.
	**/
	function hasEventListener<T>(type:T, listener:EventListener<Event, T, IcosahedronGeometry>):Bool;
	/**
		Removes a listener from an event type.
	**/
	function removeEventListener<T>(type:T, listener:EventListener<Event, T, IcosahedronGeometry>):Void;
	static var prototype : IcosahedronGeometry;
	static function fromJSON(data:Dynamic):IcosahedronGeometry;
}