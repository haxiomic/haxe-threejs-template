package three;

typedef FogBase = {
	var name : String;
	var color : Color;
	function clone():FogBase;
	function toJSON():Dynamic;
};