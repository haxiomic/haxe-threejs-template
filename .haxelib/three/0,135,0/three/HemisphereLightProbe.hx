package three;

@:jsRequire("three", "HemisphereLightProbe") extern class HemisphereLightProbe extends LightProbe {
	function new(?skyColor:ColorRepresentation, ?groundColor:ColorRepresentation, ?intensity:Float);
	final isHemisphereLightProbe : Bool;
	/**
		Applies the rotation represented by the quaternion to the object.
	**/
	function applyQuaternion(quaternion:Quaternion):HemisphereLightProbe;
	/**
		Rotate an object along an axis in object space. The axis is assumed to be normalized.
	**/
	function rotateOnAxis(axis:Vector3, angle:Float):HemisphereLightProbe;
	/**
		Rotate an object along an axis in world space. The axis is assumed to be normalized. Method Assumes no rotated parent.
	**/
	function rotateOnWorldAxis(axis:Vector3, angle:Float):HemisphereLightProbe;
	/**
		Rotates the object around x axis in local space.
	**/
	function rotateX(angle:Float):HemisphereLightProbe;
	/**
		Rotates the object around y axis in local space.
	**/
	function rotateY(angle:Float):HemisphereLightProbe;
	/**
		Rotates the object around z axis in local space.
	**/
	function rotateZ(angle:Float):HemisphereLightProbe;
	/**
		Translate an object by distance along an axis in object space. The axis is assumed to be normalized.
	**/
	function translateOnAxis(axis:Vector3, distance:Float):HemisphereLightProbe;
	/**
		Translates object along x axis by distance.
	**/
	function translateX(distance:Float):HemisphereLightProbe;
	/**
		Translates object along y axis by distance.
	**/
	function translateY(distance:Float):HemisphereLightProbe;
	/**
		Translates object along z axis by distance.
	**/
	function translateZ(distance:Float):HemisphereLightProbe;
	/**
		Adds object as child of this object.
	**/
	function add(object:haxe.extern.Rest<Object3D<Event>>):HemisphereLightProbe;
	/**
		Removes object as child of this object.
	**/
	function remove(object:haxe.extern.Rest<Object3D<Event>>):HemisphereLightProbe;
	/**
		Removes this object from its current parent.
	**/
	function removeFromParent():HemisphereLightProbe;
	/**
		Removes all child objects.
	**/
	function clear():HemisphereLightProbe;
	/**
		Adds object as a child of this, while maintaining the object's world transform.
	**/
	function attach(object:Object3D<Event>):HemisphereLightProbe;
	function clone(?recursive:Bool):HemisphereLightProbe;
	function copy(source:HemisphereLightProbe, ?recursive:Bool):HemisphereLightProbe;
	/**
		Adds a listener to an event type.
	**/
	function addEventListener<T>(type:T, listener:EventListener<Event, T, HemisphereLightProbe>):Void;
	/**
		Checks if listener is added to an event type.
	**/
	function hasEventListener<T>(type:T, listener:EventListener<Event, T, HemisphereLightProbe>):Bool;
	/**
		Removes a listener from an event type.
	**/
	function removeEventListener<T>(type:T, listener:EventListener<Event, T, HemisphereLightProbe>):Void;
	static var prototype : HemisphereLightProbe;
}