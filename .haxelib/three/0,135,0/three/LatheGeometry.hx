package three;

@:jsRequire("three", "LatheGeometry") extern class LatheGeometry extends BufferGeometry {
	function new(?points:Array<Vector2>, ?segments:Float, ?phiStart:Float, ?phiLength:Float);
	var parameters : {
		var points : Array<Vector2>;
		var segments : Float;
		var phiStart : Float;
		var phiLength : Float;
	};
	function copy(source:BufferGeometry):LatheGeometry;
	/**
		Adds a listener to an event type.
	**/
	function addEventListener<T>(type:T, listener:EventListener<Event, T, LatheGeometry>):Void;
	/**
		Checks if listener is added to an event type.
	**/
	function hasEventListener<T>(type:T, listener:EventListener<Event, T, LatheGeometry>):Bool;
	/**
		Removes a listener from an event type.
	**/
	function removeEventListener<T>(type:T, listener:EventListener<Event, T, LatheGeometry>):Void;
	static var prototype : LatheGeometry;
	static function fromJSON(data:Dynamic):LatheGeometry;
}