package three;

typedef XRHitTestOptionsInit = {
	var space : js.html.EventTarget;
	@:optional
	var offsetRay : XRRay;
	@:optional
	var entityTypes : Array<XRHitTestTrackableType>;
};