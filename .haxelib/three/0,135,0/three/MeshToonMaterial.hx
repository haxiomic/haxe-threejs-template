package three;

@:jsRequire("three", "MeshToonMaterial") extern class MeshToonMaterial extends Material {
	function new(?parameters:MeshToonMaterialParameters);
	var color : Color;
	var gradientMap : Null<Texture>;
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
	var alphaMap : Null<Texture>;
	var wireframe : Bool;
	var wireframeLinewidth : Float;
	var wireframeLinecap : String;
	var wireframeLinejoin : String;
	/**
		Sets the properties based on the values.
	**/
	function setValues(parameters:MeshToonMaterialParameters):Void;
	/**
		Return a new material with the same parameters as this material.
	**/
	function clone():MeshToonMaterial;
	/**
		Copy the parameters from the passed material into this material.
	**/
	function copy(material:Material):MeshToonMaterial;
	/**
		Adds a listener to an event type.
	**/
	function addEventListener<T>(type:T, listener:EventListener<Event, T, MeshToonMaterial>):Void;
	/**
		Checks if listener is added to an event type.
	**/
	function hasEventListener<T>(type:T, listener:EventListener<Event, T, MeshToonMaterial>):Bool;
	/**
		Removes a listener from an event type.
	**/
	function removeEventListener<T>(type:T, listener:EventListener<Event, T, MeshToonMaterial>):Void;
	static var prototype : MeshToonMaterial;
}