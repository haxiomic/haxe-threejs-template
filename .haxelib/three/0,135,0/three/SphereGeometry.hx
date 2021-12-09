package three;

@:jsRequire("three", "SphereGeometry") extern class SphereGeometry extends BufferGeometry {
	function new(?radius:Float, ?widthSegments:Float, ?heightSegments:Float, ?phiStart:Float, ?phiLength:Float, ?thetaStart:Float, ?thetaLength:Float);
	var parameters : {
		var radius : Float;
		var widthSegments : Float;
		var heightSegments : Float;
		var phiStart : Float;
		var phiLength : Float;
		var thetaStart : Float;
		var thetaLength : Float;
	};
	function copy(source:BufferGeometry):SphereGeometry;
	/**
		Adds a listener to an event type.
	**/
	function addEventListener<T>(type:T, listener:EventListener<Event, T, SphereGeometry>):Void;
	/**
		Checks if listener is added to an event type.
	**/
	function hasEventListener<T>(type:T, listener:EventListener<Event, T, SphereGeometry>):Bool;
	/**
		Removes a listener from an event type.
	**/
	function removeEventListener<T>(type:T, listener:EventListener<Event, T, SphereGeometry>):Void;
	static var prototype : SphereGeometry;
	static function fromJSON(data:Dynamic):SphereGeometry;
}