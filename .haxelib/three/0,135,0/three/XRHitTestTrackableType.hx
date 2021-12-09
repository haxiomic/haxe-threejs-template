package three;

@:jsRequire("three", "XRHitTestTrackableType") @:enum extern abstract XRHitTestTrackableType(Int) from Int to Int {
	var point;
	var plane;
	var mesh;
}