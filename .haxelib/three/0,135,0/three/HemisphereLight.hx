package three;

@:jsRequire("three", "HemisphereLight") extern class HemisphereLight extends Light {
	function new(?skyColor:ColorRepresentation, ?groundColor:ColorRepresentation, ?intensity:Float);
	var groundColor : Color;
	final isHemisphereLight : Bool;
	/**
		Applies the rotation represented by the quaternion to the object.
	**/
	function applyQuaternion(quaternion:Quaternion):HemisphereLight;
	/**
		Rotate an object along an axis in object space. The axis is assumed to be normalized.
	**/
	function rotateOnAxis(axis:Vector3, angle:Float):HemisphereLight;
	/**
		Rotate an object along an axis in world space. The axis is assumed to be normalized. Method Assumes no rotated parent.
	**/
	function rotateOnWorldAxis(axis:Vector3, angle:Float):HemisphereLight;
	/**
		Rotates the object around x axis in local space.
	**/
	function rotateX(angle:Float):HemisphereLight;
	/**
		Rotates the object around y axis in local space.
	**/
	function rotateY(angle:Float):HemisphereLight;
	/**
		Rotates the object around z axis in local space.
	**/
	function rotateZ(angle:Float):HemisphereLight;
	/**
		Translate an object by distance along an axis in object space. The axis is assumed to be normalized.
	**/
	function translateOnAxis(axis:Vector3, distance:Float):HemisphereLight;
	/**
		Translates object along x axis by distance.
	**/
	function translateX(distance:Float):HemisphereLight;
	/**
		Translates object along y axis by distance.
	**/
	function translateY(distance:Float):HemisphereLight;
	/**
		Translates object along z axis by distance.
	**/
	function translateZ(distance:Float):HemisphereLight;
	/**
		Adds object as child of this object.
	**/
	function add(object:haxe.extern.Rest<Object3D<Event>>):HemisphereLight;
	/**
		Removes object as child of this object.
	**/
	function remove(object:haxe.extern.Rest<Object3D<Event>>):HemisphereLight;
	/**
		Removes this object from its current parent.
	**/
	function removeFromParent():HemisphereLight;
	/**
		Removes all child objects.
	**/
	function clear():HemisphereLight;
	/**
		Adds object as a child of this, while maintaining the object's world transform.
	**/
	function attach(object:Object3D<Event>):HemisphereLight;
	function clone(?recursive:Bool):HemisphereLight;
	function copy(source:HemisphereLight, ?recursive:Bool):HemisphereLight;
	/**
		Adds a listener to an event type.
	**/
	function addEventListener<T>(type:T, listener:EventListener<Event, T, HemisphereLight>):Void;
	/**
		Checks if listener is added to an event type.
	**/
	function hasEventListener<T>(type:T, listener:EventListener<Event, T, HemisphereLight>):Bool;
	/**
		Removes a listener from an event type.
	**/
	function removeEventListener<T>(type:T, listener:EventListener<Event, T, HemisphereLight>):Void;
	static var prototype : HemisphereLight;
}