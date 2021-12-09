package three;

@:jsRequire("three", "MeshLambertMaterial") extern class MeshLambertMaterial extends Material {
	function new(?parameters:MeshLambertMaterialParameters);
	var color : Color;
	var emissive : Color;
	var emissiveIntensity : Float;
	var emissiveMap : Null<Texture>;
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
	function setValues(parameters:MeshLambertMaterialParameters):Void;
	/**
		Return a new material with the same parameters as this material.
	**/
	function clone():MeshLambertMaterial;
	/**
		Copy the parameters from the passed material into this material.
	**/
	function copy(material:Material):MeshLambertMaterial;
	/**
		Adds a listener to an event type.
	**/
	function addEventListener<T>(type:T, listener:EventListener<Event, T, MeshLambertMaterial>):Void;
	/**
		Checks if listener is added to an event type.
	**/
	function hasEventListener<T>(type:T, listener:EventListener<Event, T, MeshLambertMaterial>):Bool;
	/**
		Removes a listener from an event type.
	**/
	function removeEventListener<T>(type:T, listener:EventListener<Event, T, MeshLambertMaterial>):Void;
	static var prototype : MeshLambertMaterial;
}