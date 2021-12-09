package three;

@:jsRequire("three", "TorusGeometry") extern class TorusGeometry extends BufferGeometry {
	function new(?radius:Float, ?tube:Float, ?radialSegments:Float, ?tubularSegments:Float, ?arc:Float);
	var parameters : {
		var radius : Float;
		var tube : Float;
		var radialSegments : Float;
		var tubularSegments : Float;
		var arc : Float;
	};
	function copy(source:BufferGeometry):TorusGeometry;
	/**
		Adds a listener to an event type.
	**/
	function addEventListener<T>(type:T, listener:EventListener<Event, T, TorusGeometry>):Void;
	/**
		Checks if listener is added to an event type.
	**/
	function hasEventListener<T>(type:T, listener:EventListener<Event, T, TorusGeometry>):Bool;
	/**
		Removes a listener from an event type.
	**/
	function removeEventListener<T>(type:T, listener:EventListener<Event, T, TorusGeometry>):Void;
	static var prototype : TorusGeometry;
	static function fromJSON(data:Dynamic):TorusGeometry;
}