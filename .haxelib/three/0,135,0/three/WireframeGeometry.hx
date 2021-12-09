package three;

@:jsRequire("three", "WireframeGeometry") extern class WireframeGeometry<TBufferGeometry> extends BufferGeometry {
	function new(?geometry:TBufferGeometry);
	var parameters : {
		var geometry : TBufferGeometry;
	};
	function copy(source:BufferGeometry):WireframeGeometry<TBufferGeometry>;
	/**
		Adds a listener to an event type.
	**/
	function addEventListener<T>(type:T, listener:EventListener<Event, T, WireframeGeometry<TBufferGeometry>>):Void;
	/**
		Checks if listener is added to an event type.
	**/
	function hasEventListener<T>(type:T, listener:EventListener<Event, T, WireframeGeometry<TBufferGeometry>>):Bool;
	/**
		Removes a listener from an event type.
	**/
	function removeEventListener<T>(type:T, listener:EventListener<Event, T, WireframeGeometry<TBufferGeometry>>):Void;
	static var prototype : WireframeGeometry<Dynamic>;
}