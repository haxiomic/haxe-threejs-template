package three;

typedef XRView = {
	final eye : XRHandedness;
	final projectionMatrix : js.lib.Float32Array;
	final viewMatrix : js.lib.Float32Array;
	final transform : XRRigidTransform;
};