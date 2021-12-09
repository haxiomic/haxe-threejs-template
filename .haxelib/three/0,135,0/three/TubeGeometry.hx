package three;

@:jsRequire("three", "TubeGeometry") extern class TubeGeometry extends BufferGeometry {
	function new(?path:Curve<Vector3>, ?tubularSegments:Float, ?radius:Float, ?radiusSegments:Float, ?closed:Bool);
	var parameters : {
		var path : Curve<Vector3>;
		var tubularSegments : Float;
		var radius : Float;
		var radialSegments : Float;
		var closed : Bool;
	};
	var tangents : Array<Vector3>;
	var normals : Array<Vector3>;
	var binormals : Array<Vector3>;
	function copy(source:BufferGeometry):TubeGeometry;
	/**
		Adds a listener to an event type.
	**/
	function addEventListener<T>(type:T, listener:EventListener<Event, T, TubeGeometry>):Void;
	/**
		Checks if listener is added to an event type.
	**/
	function hasEventListener<T>(type:T, listener:EventListener<Event, T, TubeGeometry>):Bool;
	/**
		Removes a listener from an event type.
	**/
	function removeEventListener<T>(type:T, listener:EventListener<Event, T, TubeGeometry>):Void;
	static var prototype : TubeGeometry;
	static function fromJSON(data:Dynamic):TubeGeometry;
}