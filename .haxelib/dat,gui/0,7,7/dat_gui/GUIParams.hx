package dat_gui;

typedef GUIParams = {
	/**
		Handles GUI's element placement for you.
	**/
	@:optional
	var autoPlace : Bool;
	/**
		If true, starts closed.
	**/
	@:optional
	var closed : Bool;
	/**
		If true, close/open button shows on top of the GUI.
	**/
	@:optional
	var closeOnTop : Bool;
	/**
		If true, GUI is closed by the "h" keypress.
	**/
	@:optional
	var hideable : Bool;
	/**
		JSON object representing the saved state of this GUI.
	**/
	@:optional
	var load : Dynamic;
	/**
		The name of this GUI.
	**/
	@:optional
	var name : String;
	/**
		The identifier for a set of saved values.
	**/
	@:optional
	var preset : String;
	/**
		The width of GUI element.
	**/
	@:optional
	var width : Float;
};