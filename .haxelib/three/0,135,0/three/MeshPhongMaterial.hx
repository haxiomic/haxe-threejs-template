package three;

@:jsRequire("three", "MeshPhongMaterial") extern class MeshPhongMaterial extends Material {
	function new(?parameters:MeshPhongMaterialParameters);
	var color : Color;
	var specular : Color;
	var shininess : Float;
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
		Define whether the material is rendered with flat shading. Default is false.
	**/
	var flatShading : Bool;
	var metal : Bool;
	/**
		Sets the properties based on the values.
	**/
	function setValues(parameters:MeshPhongMaterialParameters):Void;
	/**
		Return a new material with the same parameters as this material.
	**/
	function clone():MeshPhongMaterial;
	/**
		Copy the parameters from the passed material into this material.
	**/
	function copy(material:Material):MeshPhongMaterial;
	/**
		Adds a listener to an event type.
	**/
	function addEventListener<T>(type:T, listener:EventListener<Event, T, MeshPhongMaterial>):Void;
	/**
		Checks if listener is added to an event type.
	**/
	function hasEventListener<T>(type:T, listener:EventListener<Event, T, MeshPhongMaterial>):Bool;
	/**
		Removes a listener from an event type.
	**/
	function removeEventListener<T>(type:T, listener:EventListener<Event, T, MeshPhongMaterial>):Void;
	static var prototype : MeshPhongMaterial;
}