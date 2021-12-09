package three;

@:jsRequire("three", "SpriteMaterial") extern class SpriteMaterial extends Material {
	function new(?parameters:SpriteMaterialParameters);
	var color : Color;
	var map : Null<Texture>;
	var alphaMap : Null<Texture>;
	var rotation : Float;
	var sizeAttenuation : Bool;
	final isSpriteMaterial : Bool;
	/**
		Sets the properties based on the values.
	**/
	function setValues(parameters:SpriteMaterialParameters):Void;
	/**
		Copy the parameters from the passed material into this material.
	**/
	function copy(source:SpriteMaterial):SpriteMaterial;
	/**
		Return a new material with the same parameters as this material.
	**/
	function clone():SpriteMaterial;
	/**
		Adds a listener to an event type.
	**/
	function addEventListener<T>(type:T, listener:EventListener<Event, T, SpriteMaterial>):Void;
	/**
		Checks if listener is added to an event type.
	**/
	function hasEventListener<T>(type:T, listener:EventListener<Event, T, SpriteMaterial>):Bool;
	/**
		Removes a listener from an event type.
	**/
	function removeEventListener<T>(type:T, listener:EventListener<Event, T, SpriteMaterial>):Void;
	static var prototype : SpriteMaterial;
}