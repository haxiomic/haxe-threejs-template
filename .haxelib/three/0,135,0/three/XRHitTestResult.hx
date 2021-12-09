package three;

typedef XRHitTestResult = {
	function getPose(baseSpace:js.html.EventTarget):Null<XRPose>;
	@:optional
	function createAnchor(pose:XRRigidTransform):js.lib.Promise<XRAnchor>;
};