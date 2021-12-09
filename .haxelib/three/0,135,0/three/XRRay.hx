package three;

@:jsRequire("three", "XRRay") extern class XRRay {
	function new(transformOrOrigin:ts.AnyOf2<XRRigidTransform, DOMPointInit>, ?direction:XRRayDirectionInit);
	final origin : js.html.DOMPointReadOnly;
	final direction : XRRayDirectionInit;
	var matrix : js.lib.Float32Array;
	static var prototype : XRRay;
}