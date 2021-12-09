package three;

@:jsRequire("three", "CircleGeometry") extern class CircleGeometry extends BufferGeometry {
	function new(?radius:Float, ?segments:Float, ?thetaStart:Float, ?thetaLength:Float);
	var parameters : {
		var radius : Float;
		var segments : Float;
		var thetaStart : Float;
		var thetaLength : Float;
	};
	function copy(source:BufferGeometry):CircleGeometry;
	/**
		Adds a listener to an event type.
	**/
	function addEventListener<T>(type:T, listener:EventListener<Event, T, CircleGeometry>):Void;
	/**
		Checks if listener is added to an event type.
	**/
	function hasEventListener<T>(type:T, listener:EventListener<Event, T, CircleGeometry>):Bool;
	/**
		Removes a listener from an event type.
	**/
	function removeEventListener<T>(type:T, listener:EventListener<Event, T, CircleGeometry>):Void;
	static var prototype : CircleGeometry;
	static function fromJSON(data:Dynamic):CircleGeometry;
}