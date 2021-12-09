package three;

@:jsRequire("three", "EdgesGeometry") extern class EdgesGeometry<TBufferGeometry> extends BufferGeometry {
	function new(?geometry:TBufferGeometry, ?thresholdAngle:Float);
	var parameters : {
		var geometry : TBufferGeometry;
		var thresholdAngle : Float;
	};
	function copy(source:BufferGeometry):EdgesGeometry<TBufferGeometry>;
	/**
		Adds a listener to an event type.
	**/
	function addEventListener<T>(type:T, listener:EventListener<Event, T, EdgesGeometry<TBufferGeometry>>):Void;
	/**
		Checks if listener is added to an event type.
	**/
	function hasEventListener<T>(type:T, listener:EventListener<Event, T, EdgesGeometry<TBufferGeometry>>):Bool;
	/**
		Removes a listener from an event type.
	**/
	function removeEventListener<T>(type:T, listener:EventListener<Event, T, EdgesGeometry<TBufferGeometry>>):Void;
	static var prototype : EdgesGeometry<Dynamic>;
}