package three;

@:jsRequire("three", "RectAreaLight") extern class RectAreaLight extends Light {
	function new(?color:ColorRepresentation, ?intensity:Float, ?width:Float, ?height:Float);
	var width : Float;
	var height : Float;
	var power : Float;
	final isRectAreaLight : Bool;
	/**
		Applies the rotation represented by the quaternion to the object.
	**/
	function applyQuaternion(quaternion:Quaternion):RectAreaLight;
	/**
		Rotate an object along an axis in object space. The axis is assumed to be normalized.
	**/
	function rotateOnAxis(axis:Vector3, angle:Float):RectAreaLight;
	/**
		Rotate an object along an axis in world space. The axis is assumed to be normalized. Method Assumes no rotated parent.
	**/
	function rotateOnWorldAxis(axis:Vector3, angle:Float):RectAreaLight;
	/**
		Rotates the object around x axis in local space.
	**/
	function rotateX(angle:Float):RectAreaLight;
	/**
		Rotates the object around y axis in local space.
	**/
	function rotateY(angle:Float):RectAreaLight;
	/**
		Rotates the object around z axis in local space.
	**/
	function rotateZ(angle:Float):RectAreaLight;
	/**
		Translate an object by distance along an axis in object space. The axis is assumed to be normalized.
	**/
	function translateOnAxis(axis:Vector3, distance:Float):RectAreaLight;
	/**
		Translates object along x axis by distance.
	**/
	function translateX(distance:Float):RectAreaLight;
	/**
		Translates object along y axis by distance.
	**/
	function translateY(distance:Float):RectAreaLight;
	/**
		Translates object along z axis by distance.
	**/
	function translateZ(distance:Float):RectAreaLight;
	/**
		Adds object as child of this object.
	**/
	function add(object:haxe.extern.Rest<Object3D<Event>>):RectAreaLight;
	/**
		Removes object as child of this object.
	**/
	function remove(object:haxe.extern.Rest<Object3D<Event>>):RectAreaLight;
	/**
		Removes this object from its current parent.
	**/
	function removeFromParent():RectAreaLight;
	/**
		Removes all child objects.
	**/
	function clear():RectAreaLight;
	/**
		Adds object as a child of this, while maintaining the object's world transform.
	**/
	function attach(object:Object3D<Event>):RectAreaLight;
	function clone(?recursive:Bool):RectAreaLight;
	function copy(source:RectAreaLight, ?recursive:Bool):RectAreaLight;
	/**
		Adds a listener to an event type.
	**/
	function addEventListener<T>(type:T, listener:EventListener<Event, T, RectAreaLight>):Void;
	/**
		Checks if listener is added to an event type.
	**/
	function hasEventListener<T>(type:T, listener:EventListener<Event, T, RectAreaLight>):Bool;
	/**
		Removes a listener from an event type.
	**/
	function removeEventListener<T>(type:T, listener:EventListener<Event, T, RectAreaLight>):Void;
	static var prototype : RectAreaLight;
}