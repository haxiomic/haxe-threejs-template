package three;

/**
	Abstract base class for lights.
**/
@:jsRequire("three", "Light") extern class Light extends Object3D<Event> {
	function new(?hex:ts.AnyOf2<String, Float>, ?intensity:Float);
	var color : Color;
	var intensity : Float;
	final isLight : Bool;
	var shadow : LightShadow;
	var shadowCameraFov : Dynamic;
	var shadowCameraLeft : Dynamic;
	var shadowCameraRight : Dynamic;
	var shadowCameraTop : Dynamic;
	var shadowCameraBottom : Dynamic;
	var shadowCameraNear : Dynamic;
	var shadowCameraFar : Dynamic;
	var shadowBias : Dynamic;
	var shadowMapWidth : Dynamic;
	var shadowMapHeight : Dynamic;
	function dispose():Void;
	/**
		Applies the rotation represented by the quaternion to the object.
	**/
	function applyQuaternion(quaternion:Quaternion):Light;
	/**
		Rotate an object along an axis in object space. The axis is assumed to be normalized.
	**/
	function rotateOnAxis(axis:Vector3, angle:Float):Light;
	/**
		Rotate an object along an axis in world space. The axis is assumed to be normalized. Method Assumes no rotated parent.
	**/
	function rotateOnWorldAxis(axis:Vector3, angle:Float):Light;
	/**
		Rotates the object around x axis in local space.
	**/
	function rotateX(angle:Float):Light;
	/**
		Rotates the object around y axis in local space.
	**/
	function rotateY(angle:Float):Light;
	/**
		Rotates the object around z axis in local space.
	**/
	function rotateZ(angle:Float):Light;
	/**
		Translate an object by distance along an axis in object space. The axis is assumed to be normalized.
	**/
	function translateOnAxis(axis:Vector3, distance:Float):Light;
	/**
		Translates object along x axis by distance.
	**/
	function translateX(distance:Float):Light;
	/**
		Translates object along y axis by distance.
	**/
	function translateY(distance:Float):Light;
	/**
		Translates object along z axis by distance.
	**/
	function translateZ(distance:Float):Light;
	/**
		Adds object as child of this object.
	**/
	function add(object:haxe.extern.Rest<Object3D<Event>>):Light;
	/**
		Removes object as child of this object.
	**/
	function remove(object:haxe.extern.Rest<Object3D<Event>>):Light;
	/**
		Removes this object from its current parent.
	**/
	function removeFromParent():Light;
	/**
		Removes all child objects.
	**/
	function clear():Light;
	/**
		Adds object as a child of this, while maintaining the object's world transform.
	**/
	function attach(object:Object3D<Event>):Light;
	function clone(?recursive:Bool):Light;
	function copy(source:Light, ?recursive:Bool):Light;
	/**
		Adds a listener to an event type.
	**/
	function addEventListener<T>(type:T, listener:EventListener<Event, T, Light>):Void;
	/**
		Checks if listener is added to an event type.
	**/
	function hasEventListener<T>(type:T, listener:EventListener<Event, T, Light>):Bool;
	/**
		Removes a listener from an event type.
	**/
	function removeEventListener<T>(type:T, listener:EventListener<Event, T, Light>):Void;
	static var prototype : Light;
}