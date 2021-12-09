package app.event;

/**
	See https://w3c.github.io/uievents/#dom-keyboardevent-dom_key_location_standard
**/
enum abstract KeyLocation(Int) to Int from Int {
	var STANDARD = 0;
	var LEFT = 1;
	var RIGHT = 2;
	var NUMPAD = 3;
}