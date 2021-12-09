package three;

typedef XRPlane = {
	var orientation : String;
	var planeSpace : js.html.EventTarget;
	var polygon : Array<js.html.DOMPointReadOnly>;
	var lastChangedTime : Float;
};