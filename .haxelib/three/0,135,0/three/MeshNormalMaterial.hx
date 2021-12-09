package three;

@:jsRequire("three", "MeshNormalMaterial") extern class MeshNormalMaterial extends Material {
	function new(?parameters:MeshNormalMaterialParameters);
	var bumpMap : Null<Texture>;
	var bumpScale : Float;
	var normalMap : Null<Texture>;
	var normalMapType : NormalMapTypes;
	var normalScale : Vector2;
	var displacementMap : Null<Texture>;
	var displacementScale : Float;
	var displacementBias : Float;
	var wireframe : Bool;
	var wireframeLinewidth : Float;
	/**
		Define whether the material is rendered with flat shading. Default is false.
	**/
	var flatShading : Bool;
	/**
		Sets the properties based on the values.
	**/
	function setValues(parameters:MeshNormalMaterialParameters):Void;
	/**
		Return a new material with the same parameters as this material.
	**/
	function clone():MeshNormalMaterial;
	/**
		Copy the parameters from the passed material into this material.
	**/
	function copy(material:Material):MeshNormalMaterial;
	/**
		Adds a listener to an event type.
	**/
	function addEventListener<T>(type:T, listener:EventListener<Event, T, MeshNormalMaterial>):Void;
	/**
		Checks if listener is added to an event type.
	**/
	function hasEventListener<T>(type:T, listener:EventListener<Event, T, MeshNormalMaterial>):Bool;
	/**
		Removes a listener from an event type.
	**/
	function removeEventListener<T>(type:T, listener:EventListener<Event, T, MeshNormalMaterial>):Void;
	static var prototype : MeshNormalMaterial;
}