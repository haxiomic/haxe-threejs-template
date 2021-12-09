package three;

@:jsRequire("three", "PlaneGeometry") extern class PlaneGeometry extends BufferGeometry {
	function new(?width:Float, ?height:Float, ?widthSegments:Float, ?heightSegments:Float);
	var parameters : {
		var width : Float;
		var height : Float;
		var widthSegments : Float;
		var heightSegments : Float;
	};
	function copy(source:BufferGeometry):PlaneGeometry;
	/**
		Adds a listener to an event type.
	**/
	function addEventListener<T>(type:T, listener:EventListener<Event, T, PlaneGeometry>):Void;
	/**
		Checks if listener is added to an event type.
	**/
	function hasEventListener<T>(type:T, listener:EventListener<Event, T, PlaneGeometry>):Bool;
	/**
		Removes a listener from an event type.
	**/
	function removeEventListener<T>(type:T, listener:EventListener<Event, T, PlaneGeometry>):Void;
	static var prototype : PlaneGeometry;
	static function fromJSON(data:Dynamic):PlaneGeometry;
}