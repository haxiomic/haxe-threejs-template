package three;

@:jsRequire("three", "MeshDistanceMaterial") extern class MeshDistanceMaterial extends Material {
	function new(?parameters:MeshDistanceMaterialParameters);
	var map : Null<Texture>;
	var alphaMap : Null<Texture>;
	var displacementMap : Null<Texture>;
	var displacementScale : Float;
	var displacementBias : Float;
	var farDistance : Float;
	var nearDistance : Float;
	var referencePosition : Vector3;
	/**
		Sets the properties based on the values.
	**/
	function setValues(parameters:MeshDistanceMaterialParameters):Void;
	/**
		Return a new material with the same parameters as this material.
	**/
	function clone():MeshDistanceMaterial;
	/**
		Copy the parameters from the passed material into this material.
	**/
	function copy(material:Material):MeshDistanceMaterial;
	/**
		Adds a listener to an event type.
	**/
	function addEventListener<T>(type:T, listener:EventListener<Event, T, MeshDistanceMaterial>):Void;
	/**
		Checks if listener is added to an event type.
	**/
	function hasEventListener<T>(type:T, listener:EventListener<Event, T, MeshDistanceMaterial>):Bool;
	/**
		Removes a listener from an event type.
	**/
	function removeEventListener<T>(type:T, listener:EventListener<Event, T, MeshDistanceMaterial>):Void;
	static var prototype : MeshDistanceMaterial;
}