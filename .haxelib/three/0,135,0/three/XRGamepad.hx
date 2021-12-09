package three;

typedef XRGamepad = {
	final id : String;
	final index : Float;
	final connected : Bool;
	final timestamp : Float;
	final mapping : js.html.GamepadMappingType;
	final axes : js.lib.Float32Array;
	final buttons : Array<js.html.GamepadButton>;
};