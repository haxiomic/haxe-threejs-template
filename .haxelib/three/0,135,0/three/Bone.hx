package three;

@:jsRequire("three", "Bone") extern class Bone extends Object3D<Event> {
	function new();
	final isBone : Bool;
	/**
		Applies the rotation represented by the quaternion to the object.
	**/
	function applyQuaternion(quaternion:Quaternion):Bone;
	/**
		Rotate an object along an axis in object space. The axis is assumed to be normalized.
	**/
	function rotateOnAxis(axis:Vector3, angle:Float):Bone;
	/**
		Rotate an object along an axis in world space. The axis is assumed to be normalized. Method Assumes no rotated parent.
	**/
	function rotateOnWorldAxis(axis:Vector3, angle:Float):Bone;
	/**
		Rotates the object around x axis in local space.
	**/
	function rotateX(angle:Float):Bone;
	/**
		Rotates the object around y axis in local space.
	**/
	function rotateY(angle:Float):Bone;
	/**
		Rotates the object around z axis in local space.
	**/
	function rotateZ(angle:Float):Bone;
	/**
		Translate an object by distance along an axis in object space. The axis is assumed to be normalized.
	**/
	function translateOnAxis(axis:Vector3, distance:Float):Bone;
	/**
		Translates object along x axis by distance.
	**/
	function translateX(distance:Float):Bone;
	/**
		Translates object along y axis by distance.
	**/
	function translateY(distance:Float):Bone;
	/**
		Translates object along z axis by distance.
	**/
	function translateZ(distance:Float):Bone;
	/**
		Adds object as child of this object.
	**/
	function add(object:haxe.extern.Rest<Object3D<Event>>):Bone;
	/**
		Removes object as child of this object.
	**/
	function remove(object:haxe.extern.Rest<Object3D<Event>>):Bone;
	/**
		Removes this object from its current parent.
	**/
	function removeFromParent():Bone;
	/**
		Removes all child objects.
	**/
	function clear():Bone;
	/**
		Adds object as a child of this, while maintaining the object's world transform.
	**/
	function attach(object:Object3D<Event>):Bone;
	function clone(?recursive:Bool):Bone;
	function copy(source:Bone, ?recursive:Bool):Bone;
	/**
		Adds a listener to an event type.
	**/
	function addEventListener<T>(type:T, listener:EventListener<Event, T, Bone>):Void;
	/**
		Checks if listener is added to an event type.
	**/
	function hasEventListener<T>(type:T, listener:EventListener<Event, T, Bone>):Bool;
	/**
		Removes a listener from an event type.
	**/
	function removeEventListener<T>(type:T, listener:EventListener<Event, T, Bone>):Void;
	static var prototype : Bone;
}