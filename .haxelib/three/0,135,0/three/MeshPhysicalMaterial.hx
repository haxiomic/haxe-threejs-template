package three;

@:jsRequire("three", "MeshPhysicalMaterial") extern class MeshPhysicalMaterial extends MeshStandardMaterial {
	function new(?parameters:MeshPhysicalMaterialParameters);
	var clearcoat : Float;
	var clearcoatMap : Null<Texture>;
	var clearcoatRoughness : Float;
	var clearcoatRoughnessMap : Null<Texture>;
	var clearcoatNormalScale : Vector2;
	var clearcoatNormalMap : Null<Texture>;
	var reflectivity : Float;
	var ior : Float;
	var sheen : Float;
	var sheenColor : Color;
	var sheenColorMap : Null<Texture>;
	var sheenRoughness : Float;
	var sheenRoughnessMap : Null<Texture>;
	var transmission : Float;
	var transmissionMap : Null<Texture>;
	var thickness : Float;
	var thicknessMap : Null<Texture>;
	var attenuationDistance : Float;
	var attenuationColor : Color;
	var specularIntensity : Float;
	var specularColor : Color;
	var specularIntensityMap : Null<Texture>;
	var specularColorMap : Null<Texture>;
	/**
		Return a new material with the same parameters as this material.
	**/
	function clone():MeshPhysicalMaterial;
	/**
		Copy the parameters from the passed material into this material.
	**/
	function copy(material:Material):MeshPhysicalMaterial;
	/**
		Adds a listener to an event type.
	**/
	function addEventListener<T>(type:T, listener:EventListener<Event, T, MeshPhysicalMaterial>):Void;
	/**
		Checks if listener is added to an event type.
	**/
	function hasEventListener<T>(type:T, listener:EventListener<Event, T, MeshPhysicalMaterial>):Bool;
	/**
		Removes a listener from an event type.
	**/
	function removeEventListener<T>(type:T, listener:EventListener<Event, T, MeshPhysicalMaterial>):Void;
	static var prototype : MeshPhysicalMaterial;
}