package three;

@:jsRequire("three", "WebXRController") extern class WebXRController {
	function new();
	function getTargetRaySpace():Group;
	function getGripSpace():Group;
	function dispatchEvent(event:{ var type : XRControllerEventType; @:optional var data : XRInputSource; }):WebXRController;
	function disconnect(inputSource:XRInputSource):WebXRController;
	function update(inputSource:XRInputSource, frame:XRFrame, referenceSpace:XRReferenceSpace):WebXRController;
	static var prototype : WebXRController;
}