package three;

@:jsRequire("three", "MeshStandardMaterial") extern class MeshStandardMaterial extends Material {
	function new(?parameters:MeshStandardMaterialParameters);
	var color : Color;
	var roughness : Float;
	var metalness : Float;
	var map : Null<Texture>;
	var lightMap : Null<Texture>;
	var lightMapIntensity : Float;
	var aoMap : Null<Texture>;
	var aoMapIntensity : Float;
	var emissive : Color;
	var emissiveIntensity : Float;
	var emissiveMap : Null<Texture>;
	var bumpMap : Null<Texture>;
	var bumpScale : Float;
	var normalMap : Null<Texture>;
	var normalMapType : NormalMapTypes;
	var normalScale : Vector2;
	var displacementMap : Null<Texture>;
	var displacementScale : Float;
	var displacementBias : Float;
	var roughnessMap : Null<Texture>;
	var metalnessMap : Null<Texture>;
	var alphaMap : Null<Texture>;
	var envMap : Null<Texture>;
	var envMapIntensity : Float;
	var refractionRatio : Float;
	var wireframe : Bool;
	var wireframeLinewidth : Float;
	var wireframeLinecap : String;
	var wireframeLinejoin : String;
	/**
		Define whether the material is rendered with flat shading. Default is false.
	**/
	var flatShading : Bool;
	var isMeshStandardMaterial : Bool;
	/**
		Sets the properties based on the values.
	**/
	function setValues(parameters:MeshStandardMaterialParameters):Void;
	/**
		Return a new material with the same parameters as this material.
	**/
	function clone():MeshStandardMaterial;
	/**
		Copy the parameters from the passed material into this material.
	**/
	function copy(material:Material):MeshStandardMaterial;
	/**
		Adds a listener to an event type.
	**/
	function addEventListener<T>(type:T, listener:EventListener<Event, T, MeshStandardMaterial>):Void;
	/**
		Checks if listener is added to an event type.
	**/
	function hasEventListener<T>(type:T, listener:EventListener<Event, T, MeshStandardMaterial>):Bool;
	/**
		Removes a listener from an event type.
	**/
	function removeEventListener<T>(type:T, listener:EventListener<Event, T, MeshStandardMaterial>):Void;
	static var prototype : MeshStandardMaterial;
}