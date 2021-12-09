package three;

/**
	Event object.
**/
typedef Event = {
	@:optional
	var target : Dynamic;
	var type : String;
};