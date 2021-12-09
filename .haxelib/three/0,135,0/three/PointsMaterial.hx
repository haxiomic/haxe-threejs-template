package three;

@:jsRequire("three", "PointsMaterial") extern class PointsMaterial extends Material {
	function new(?parameters:PointsMaterialParameters);
	var color : Color;
	var map : Null<Texture>;
	var alphaMap : Null<Texture>;
	var size : Float;
	var sizeAttenuation : Bool;
	/**
		Sets the properties based on the values.
	**/
	function setValues(parameters:PointsMaterialParameters):Void;
	/**
		Return a new material with the same parameters as this material.
	**/
	function clone():PointsMaterial;
	/**
		Copy the parameters from the passed material into this material.
	**/
	function copy(material:Material):PointsMaterial;
	/**
		Adds a listener to an event type.
	**/
	function addEventListener<T>(type:T, listener:EventListener<Event, T, PointsMaterial>):Void;
	/**
		Checks if listener is added to an event type.
	**/
	function hasEventListener<T>(type:T, listener:EventListener<Event, T, PointsMaterial>):Bool;
	/**
		Removes a listener from an event type.
	**/
	function removeEventListener<T>(type:T, listener:EventListener<Event, T, PointsMaterial>):Void;
	static var prototype : PointsMaterial;
}