package three;

typedef XRFrame = {
	final session : XRSession;
	function getViewerPose(referenceSpace:XRReferenceSpace):Null<XRViewerPose>;
	function getPose(space:js.html.EventTarget, baseSpace:js.html.EventTarget):Null<XRPose>;
	function getHitTestResults(hitTestSource:XRHitTestSource):Array<XRHitTestResult>;
	function getHitTestResultsForTransientInput(hitTestSource:XRTransientInputHitTestSource):Array<XRTransientInputHitTestResult>;
	@:optional
	var trackedAnchors : XRAnchorSet;
	function createAnchor(pose:XRRigidTransform, space:js.html.EventTarget):js.lib.Promise<XRAnchor>;
	var worldInformation : {
		@:optional
		var detectedPlanes : XRPlaneSet;
	};
	function getJointPose(joint:XRJointSpace, baseSpace:js.html.EventTarget):XRJointPose;
};