package app.event;

enum abstract PointerType(String) to String from String {
	var MOUSE = "mouse";
	var PEN = "pen";
	var TOUCH = "touch";
}