package three;

@:jsRequire("three", "LineBasicMaterial") extern class LineBasicMaterial extends Material {
	function new(?parameters:LineBasicMaterialParameters);
	var color : Color;
	var linewidth : Float;
	var linecap : String;
	var linejoin : String;
	/**
		Sets the properties based on the values.
	**/
	function setValues(parameters:LineBasicMaterialParameters):Void;
	/**
		Return a new material with the same parameters as this material.
	**/
	function clone():LineBasicMaterial;
	/**
		Copy the parameters from the passed material into this material.
	**/
	function copy(material:Material):LineBasicMaterial;
	/**
		Adds a listener to an event type.
	**/
	function addEventListener<T>(type:T, listener:EventListener<Event, T, LineBasicMaterial>):Void;
	/**
		Checks if listener is added to an event type.
	**/
	function hasEventListener<T>(type:T, listener:EventListener<Event, T, LineBasicMaterial>):Bool;
	/**
		Removes a listener from an event type.
	**/
	function removeEventListener<T>(type:T, listener:EventListener<Event, T, LineBasicMaterial>):Void;
	static var prototype : LineBasicMaterial;
}