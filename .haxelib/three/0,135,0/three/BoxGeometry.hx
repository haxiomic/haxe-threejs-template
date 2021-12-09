package three;

@:jsRequire("three", "BoxGeometry") extern class BoxGeometry extends BufferGeometry {
	function new(?width:Float, ?height:Float, ?depth:Float, ?widthSegments:Float, ?heightSegments:Float, ?depthSegments:Float);
	var parameters : {
		var width : Float;
		var height : Float;
		var depth : Float;
		var widthSegments : Float;
		var heightSegments : Float;
		var depthSegments : Float;
	};
	function copy(source:BufferGeometry):BoxGeometry;
	/**
		Adds a listener to an event type.
	**/
	function addEventListener<T>(type:T, listener:EventListener<Event, T, BoxGeometry>):Void;
	/**
		Checks if listener is added to an event type.
	**/
	function hasEventListener<T>(type:T, listener:EventListener<Event, T, BoxGeometry>):Bool;
	/**
		Removes a listener from an event type.
	**/
	function removeEventListener<T>(type:T, listener:EventListener<Event, T, BoxGeometry>):Void;
	static var prototype : BoxGeometry;
	static function fromJSON(data:Dynamic):BoxGeometry;
}