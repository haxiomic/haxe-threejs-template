package three;

@:jsRequire("three", "PolyhedronGeometry") extern class PolyhedronGeometry extends BufferGeometry {
	function new(?vertices:Array<Float>, ?indices:Array<Float>, ?radius:Float, ?detail:Float);
	var parameters : {
		var vertices : Array<Float>;
		var indices : Array<Float>;
		var radius : Float;
		var detail : Float;
	};
	function copy(source:BufferGeometry):PolyhedronGeometry;
	/**
		Adds a listener to an event type.
	**/
	function addEventListener<T>(type:T, listener:EventListener<Event, T, PolyhedronGeometry>):Void;
	/**
		Checks if listener is added to an event type.
	**/
	function hasEventListener<T>(type:T, listener:EventListener<Event, T, PolyhedronGeometry>):Bool;
	/**
		Removes a listener from an event type.
	**/
	function removeEventListener<T>(type:T, listener:EventListener<Event, T, PolyhedronGeometry>):Void;
	static var prototype : PolyhedronGeometry;
	static function fromJSON(data:Dynamic):PolyhedronGeometry;
}