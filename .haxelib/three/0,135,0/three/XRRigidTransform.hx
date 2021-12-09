package three;

@:jsRequire("three", "XRRigidTransform") extern class XRRigidTransform {
	function new(matrix:ts.AnyOf2<js.lib.Float32Array, DOMPointInit>, ?direction:DOMPointInit);
	var position : js.html.DOMPointReadOnly;
	var orientation : js.html.DOMPointReadOnly;
	var matrix : js.lib.Float32Array;
	var inverse : XRRigidTransform;
	static var prototype : XRRigidTransform;
}