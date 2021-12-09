package three;

typedef XRInputSourceChangeEvent = {
	var session : XRSession;
	var removed : Array<XRInputSource>;
	var added : Array<XRInputSource>;
};