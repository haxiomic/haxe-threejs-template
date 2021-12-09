package three;

@:jsRequire("three", "LineDashedMaterial") extern class LineDashedMaterial extends LineBasicMaterial {
	function new(?parameters:LineDashedMaterialParameters);
	var scale : Float;
	var dashSize : Float;
	var gapSize : Float;
	final isLineDashedMaterial : Bool;
	/**
		Sets the properties based on the values.
	**/
	function setValues(parameters:LineDashedMaterialParameters):Void;
	/**
		Return a new material with the same parameters as this material.
	**/
	function clone():LineDashedMaterial;
	/**
		Copy the parameters from the passed material into this material.
	**/
	function copy(material:Material):LineDashedMaterial;
	/**
		Adds a listener to an event type.
	**/
	function addEventListener<T>(type:T, listener:EventListener<Event, T, LineDashedMaterial>):Void;
	/**
		Checks if listener is added to an event type.
	**/
	function hasEventListener<T>(type:T, listener:EventListener<Event, T, LineDashedMaterial>):Bool;
	/**
		Removes a listener from an event type.
	**/
	function removeEventListener<T>(type:T, listener:EventListener<Event, T, LineDashedMaterial>):Void;
	static var prototype : LineDashedMaterial;
}