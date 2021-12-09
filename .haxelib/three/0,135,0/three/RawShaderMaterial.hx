package three;

@:jsRequire("three", "RawShaderMaterial") extern class RawShaderMaterial extends ShaderMaterial {
	function new(?parameters:ShaderMaterialParameters);
	/**
		Return a new material with the same parameters as this material.
	**/
	function clone():RawShaderMaterial;
	/**
		Copy the parameters from the passed material into this material.
	**/
	function copy(material:Material):RawShaderMaterial;
	/**
		Adds a listener to an event type.
	**/
	function addEventListener<T>(type:T, listener:EventListener<Event, T, RawShaderMaterial>):Void;
	/**
		Checks if listener is added to an event type.
	**/
	function hasEventListener<T>(type:T, listener:EventListener<Event, T, RawShaderMaterial>):Bool;
	/**
		Removes a listener from an event type.
	**/
	function removeEventListener<T>(type:T, listener:EventListener<Event, T, RawShaderMaterial>):Void;
	static var prototype : RawShaderMaterial;
}