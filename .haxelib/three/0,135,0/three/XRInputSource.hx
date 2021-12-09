package three;

typedef XRInputSource = {
	final handedness : XRHandedness;
	final targetRayMode : XRTargetRayMode;
	final targetRaySpace : js.html.EventTarget;
	@:optional
	final gripSpace : js.html.EventTarget;
	final profiles : Array<String>;
	final gamepad : XRGamepad;
	@:optional
	final hand : XRHand;
};