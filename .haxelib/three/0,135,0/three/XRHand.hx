package three;

typedef XRHand = {
	final size : Float;
	function clear():Void;
	function delete(key:XRHandJoint):Bool;
	function forEach(callbackfn:(value:XRJointSpace, key:XRHandJoint, map:js.lib.Map<XRHandJoint, XRJointSpace>) -> Void, ?thisArg:Dynamic):Void;
	function get(key:XRHandJoint):Null<XRJointSpace>;
	function has(key:XRHandJoint):Bool;
	function set(key:XRHandJoint, value:XRJointSpace):XRHand;
	/**
		Returns an iterable of key, value pairs for every entry in the map.
	**/
	function entries():js.lib.IterableIterator<ts.Tuple2<XRHandJoint, XRJointSpace>>;
	/**
		Returns an iterable of keys in the map
	**/
	function keys():js.lib.IterableIterator<XRHandJoint>;
	/**
		Returns an iterable of values in the map
	**/
	function values():js.lib.IterableIterator<XRJointSpace>;
};