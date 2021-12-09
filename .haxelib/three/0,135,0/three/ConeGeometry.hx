package three;

@:jsRequire("three", "ConeGeometry") extern class ConeGeometry extends CylinderGeometry {
	function new(?radius:Float, ?height:Float, ?radialSegments:Float, ?heightSegments:Float, ?openEnded:Bool, ?thetaStart:Float, ?thetaLength:Float);
	function copy(source:BufferGeometry):ConeGeometry;
	/**
		Adds a listener to an event type.
	**/
	function addEventListener<T>(type:T, listener:EventListener<Event, T, ConeGeometry>):Void;
	/**
		Checks if listener is added to an event type.
	**/
	function hasEventListener<T>(type:T, listener:EventListener<Event, T, ConeGeometry>):Bool;
	/**
		Removes a listener from an event type.
	**/
	function removeEventListener<T>(type:T, listener:EventListener<Event, T, ConeGeometry>):Void;
	static var prototype : ConeGeometry;
	static function fromJSON(data:Dynamic):ConeGeometry;
}