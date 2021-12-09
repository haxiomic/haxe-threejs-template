package three;

@:jsRequire("three", "ExtrudeGeometry") extern class ExtrudeGeometry extends BufferGeometry {
	function new(?shapes:ts.AnyOf2<Shape, Array<Shape>>, ?options:ExtrudeGeometryOptions);
	function addShapeList(shapes:Array<Shape>, ?options:Dynamic):Void;
	function addShape(shape:Shape, ?options:Dynamic):Void;
	function copy(source:BufferGeometry):ExtrudeGeometry;
	/**
		Adds a listener to an event type.
	**/
	function addEventListener<T>(type:T, listener:EventListener<Event, T, ExtrudeGeometry>):Void;
	/**
		Checks if listener is added to an event type.
	**/
	function hasEventListener<T>(type:T, listener:EventListener<Event, T, ExtrudeGeometry>):Bool;
	/**
		Removes a listener from an event type.
	**/
	function removeEventListener<T>(type:T, listener:EventListener<Event, T, ExtrudeGeometry>):Void;
	static var prototype : ExtrudeGeometry;
	static function fromJSON(data:Dynamic):ExtrudeGeometry;
}