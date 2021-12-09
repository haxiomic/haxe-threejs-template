package three;

@:jsRequire("three", "TorusKnotGeometry") extern class TorusKnotGeometry extends BufferGeometry {
	function new(?radius:Float, ?tube:Float, ?tubularSegments:Float, ?radialSegments:Float, ?p:Float, ?q:Float);
	var parameters : {
		var radius : Float;
		var tube : Float;
		var tubularSegments : Float;
		var radialSegments : Float;
		var p : Float;
		var q : Float;
	};
	function copy(source:BufferGeometry):TorusKnotGeometry;
	/**
		Adds a listener to an event type.
	**/
	function addEventListener<T>(type:T, listener:EventListener<Event, T, TorusKnotGeometry>):Void;
	/**
		Checks if listener is added to an event type.
	**/
	function hasEventListener<T>(type:T, listener:EventListener<Event, T, TorusKnotGeometry>):Bool;
	/**
		Removes a listener from an event type.
	**/
	function removeEventListener<T>(type:T, listener:EventListener<Event, T, TorusKnotGeometry>):Void;
	static var prototype : TorusKnotGeometry;
	static function fromJSON(data:Dynamic):TorusKnotGeometry;
}