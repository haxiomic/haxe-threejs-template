package three;

@:jsRequire("three", "ShaderMaterial") extern class ShaderMaterial extends Material {
	function new(?parameters:ShaderMaterialParameters);
	var uniforms : { };
	var vertexShader : String;
	var fragmentShader : String;
	var linewidth : Float;
	var wireframe : Bool;
	var wireframeLinewidth : Float;
	var lights : Bool;
	var clipping : Bool;
	var derivatives : Dynamic;
	var extensions : {
		var derivatives : Bool;
		var fragDepth : Bool;
		var drawBuffers : Bool;
		var shaderTextureLOD : Bool;
	};
	var defaultAttributeValues : Dynamic;
	var index0AttributeName : Null<String>;
	var uniformsNeedUpdate : Bool;
	var glslVersion : Null<GLSLVersion>;
	var isShaderMaterial : Bool;
	/**
		Sets the properties based on the values.
	**/
	function setValues(parameters:ShaderMaterialParameters):Void;
	/**
		Convert the material to three.js JSON format.
	**/
	function toJSON(meta:Dynamic):Dynamic;
	/**
		Return a new material with the same parameters as this material.
	**/
	function clone():ShaderMaterial;
	/**
		Copy the parameters from the passed material into this material.
	**/
	function copy(material:Material):ShaderMaterial;
	/**
		Adds a listener to an event type.
	**/
	function addEventListener<T>(type:T, listener:EventListener<Event, T, ShaderMaterial>):Void;
	/**
		Checks if listener is added to an event type.
	**/
	function hasEventListener<T>(type:T, listener:EventListener<Event, T, ShaderMaterial>):Bool;
	/**
		Removes a listener from an event type.
	**/
	function removeEventListener<T>(type:T, listener:EventListener<Event, T, ShaderMaterial>):Void;
	static var prototype : ShaderMaterial;
}