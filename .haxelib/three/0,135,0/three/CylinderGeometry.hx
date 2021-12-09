package three;

@:jsRequire("three", "CylinderGeometry") extern class CylinderGeometry extends BufferGeometry {
	function new(?radiusTop:Float, ?radiusBottom:Float, ?height:Float, ?radialSegments:Float, ?heightSegments:Float, ?openEnded:Bool, ?thetaStart:Float, ?thetaLength:Float);
	var parameters : {
		var radiusTop : Float;
		var radiusBottom : Float;
		var height : Float;
		var radialSegments : Float;
		var heightSegments : Float;
		var openEnded : Bool;
		var thetaStart : Float;
		var thetaLength : Float;
	};
	function copy(source:BufferGeometry):CylinderGeometry;
	/**
		Adds a listener to an event type.
	**/
	function addEventListener<T>(type:T, listener:EventListener<Event, T, CylinderGeometry>):Void;
	/**
		Checks if listener is added to an event type.
	**/
	function hasEventListener<T>(type:T, listener:EventListener<Event, T, CylinderGeometry>):Bool;
	/**
		Removes a listener from an event type.
	**/
	function removeEventListener<T>(type:T, listener:EventListener<Event, T, CylinderGeometry>):Void;
	static var prototype : CylinderGeometry;
	static function fromJSON(data:Dynamic):CylinderGeometry;
}