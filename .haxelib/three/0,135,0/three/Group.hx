package three;

@:jsRequire("three", "Group") extern class Group extends Object3D<Event> {
	function new();
	final isGroup : Bool;
	/**
		Applies the rotation represented by the quaternion to the object.
	**/
	function applyQuaternion(quaternion:Quaternion):Group;
	/**
		Rotate an object along an axis in object space. The axis is assumed to be normalized.
	**/
	function rotateOnAxis(axis:Vector3, angle:Float):Group;
	/**
		Rotate an object along an axis in world space. The axis is assumed to be normalized. Method Assumes no rotated parent.
	**/
	function rotateOnWorldAxis(axis:Vector3, angle:Float):Group;
	/**
		Rotates the object around x axis in local space.
	**/
	function rotateX(angle:Float):Group;
	/**
		Rotates the object around y axis in local space.
	**/
	function rotateY(angle:Float):Group;
	/**
		Rotates the object around z axis in local space.
	**/
	function rotateZ(angle:Float):Group;
	/**
		Translate an object by distance along an axis in object space. The axis is assumed to be normalized.
	**/
	function translateOnAxis(axis:Vector3, distance:Float):Group;
	/**
		Translates object along x axis by distance.
	**/
	function translateX(distance:Float):Group;
	/**
		Translates object along y axis by distance.
	**/
	function translateY(distance:Float):Group;
	/**
		Translates object along z axis by distance.
	**/
	function translateZ(distance:Float):Group;
	/**
		Adds object as child of this object.
	**/
	function add(object:haxe.extern.Rest<Object3D<Event>>):Group;
	/**
		Removes object as child of this object.
	**/
	function remove(object:haxe.extern.Rest<Object3D<Event>>):Group;
	/**
		Removes this object from its current parent.
	**/
	function removeFromParent():Group;
	/**
		Removes all child objects.
	**/
	function clear():Group;
	/**
		Adds object as a child of this, while maintaining the object's world transform.
	**/
	function attach(object:Object3D<Event>):Group;
	function clone(?recursive:Bool):Group;
	function copy(source:Group, ?recursive:Bool):Group;
	/**
		Adds a listener to an event type.
	**/
	function addEventListener<T>(type:T, listener:EventListener<Event, T, Group>):Void;
	/**
		Checks if listener is added to an event type.
	**/
	function hasEventListener<T>(type:T, listener:EventListener<Event, T, Group>):Bool;
	/**
		Removes a listener from an event type.
	**/
	function removeEventListener<T>(type:T, listener:EventListener<Event, T, Group>):Void;
	static var prototype : Group;
}