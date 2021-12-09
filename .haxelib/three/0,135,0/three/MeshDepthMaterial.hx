package three;

@:jsRequire("three", "MeshDepthMaterial") extern class MeshDepthMaterial extends Material {
	function new(?parameters:MeshDepthMaterialParameters);
	var map : Null<Texture>;
	var alphaMap : Null<Texture>;
	var depthPacking : DepthPackingStrategies;
	var displacementMap : Null<Texture>;
	var displacementScale : Float;
	var displacementBias : Float;
	var wireframe : Bool;
	var wireframeLinewidth : Float;
	/**
		Sets the properties based on the values.
	**/
	function setValues(parameters:MeshDepthMaterialParameters):Void;
	/**
		Return a new material with the same parameters as this material.
	**/
	function clone():MeshDepthMaterial;
	/**
		Copy the parameters from the passed material into this material.
	**/
	function copy(material:Material):MeshDepthMaterial;
	/**
		Adds a listener to an event type.
	**/
	function addEventListener<T>(type:T, listener:EventListener<Event, T, MeshDepthMaterial>):Void;
	/**
		Checks if listener is added to an event type.
	**/
	function hasEventListener<T>(type:T, listener:EventListener<Event, T, MeshDepthMaterial>):Bool;
	/**
		Removes a listener from an event type.
	**/
	function removeEventListener<T>(type:T, listener:EventListener<Event, T, MeshDepthMaterial>):Void;
	static var prototype : MeshDepthMaterial;
}