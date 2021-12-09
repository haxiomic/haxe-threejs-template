package three;

@:jsRequire("three", "MeshBasicMaterial") extern class MeshBasicMaterial extends Material {
	function new(?parameters:MeshBasicMaterialParameters);
	var color : Color;
	var map : Null<Texture>;
	var lightMap : Null<Texture>;
	var lightMapIntensity : Float;
	var aoMap : Null<Texture>;
	var aoMapIntensity : Float;
	var specularMap : Null<Texture>;
	var alphaMap : Null<Texture>;
	var envMap : Null<Texture>;
	var combine : Combine;
	var reflectivity : Float;
	var refractionRatio : Float;
	var wireframe : Bool;
	var wireframeLinewidth : Float;
	var wireframeLinecap : String;
	var wireframeLinejoin : String;
	/**
		Sets the properties based on the values.
	**/
	function setValues(parameters:MeshBasicMaterialParameters):Void;
	/**
		Return a new material with the same parameters as this material.
	**/
	function clone():MeshBasicMaterial;
	/**
		Copy the parameters from the passed material into this material.
	**/
	function copy(material:Material):MeshBasicMaterial;
	/**
		Adds a listener to an event type.
	**/
	function addEventListener<T>(type:T, listener:EventListener<Event, T, MeshBasicMaterial>):Void;
	/**
		Checks if listener is added to an event type.
	**/
	function hasEventListener<T>(type:T, listener:EventListener<Event, T, MeshBasicMaterial>):Bool;
	/**
		Removes a listener from an event type.
	**/
	function removeEventListener<T>(type:T, listener:EventListener<Event, T, MeshBasicMaterial>):Void;
	static var prototype : MeshBasicMaterial;
}