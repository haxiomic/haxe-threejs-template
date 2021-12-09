package three;

@:jsRequire("three", "ShapeGeometry") extern class ShapeGeometry extends BufferGeometry {
	function new(?shapes:ts.AnyOf2<Shape, Array<Shape>>, ?curveSegments:Float);
	function copy(source:BufferGeometry):ShapeGeometry;
	/**
		Adds a listener to an event type.
	**/
	function addEventListener<T>(type:T, listener:EventListener<Event, T, ShapeGeometry>):Void;
	/**
		Checks if listener is added to an event type.
	**/
	function hasEventListener<T>(type:T, listener:EventListener<Event, T, ShapeGeometry>):Bool;
	/**
		Removes a listener from an event type.
	**/
	function removeEventListener<T>(type:T, listener:EventListener<Event, T, ShapeGeometry>):Void;
	static var prototype : ShapeGeometry;
	static function fromJSON(data:Dynamic):ShapeGeometry;
}