package three;

@:jsRequire("three", "RingGeometry") extern class RingGeometry extends BufferGeometry {
	function new(?innerRadius:Float, ?outerRadius:Float, ?thetaSegments:Float, ?phiSegments:Float, ?thetaStart:Float, ?thetaLength:Float);
	var parameters : {
		var innerRadius : Float;
		var outerRadius : Float;
		var thetaSegments : Float;
		var phiSegments : Float;
		var thetaStart : Float;
		var thetaLength : Float;
	};
	function copy(source:BufferGeometry):RingGeometry;
	/**
		Adds a listener to an event type.
	**/
	function addEventListener<T>(type:T, listener:EventListener<Event, T, RingGeometry>):Void;
	/**
		Checks if listener is added to an event type.
	**/
	function hasEventListener<T>(type:T, listener:EventListener<Event, T, RingGeometry>):Bool;
	/**
		Removes a listener from an event type.
	**/
	function removeEventListener<T>(type:T, listener:EventListener<Event, T, RingGeometry>):Void;
	static var prototype : RingGeometry;
	static function fromJSON(data:Dynamic):RingGeometry;
}