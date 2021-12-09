package three;

typedef XRTransientInputHitTestOptionsInit = {
	var profile : String;
	@:optional
	var offsetRay : XRRay;
	@:optional
	var entityTypes : Array<XRHitTestTrackableType>;
};