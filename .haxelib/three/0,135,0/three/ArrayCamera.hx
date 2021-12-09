package three;

@:jsRequire("three", "ArrayCamera") extern class ArrayCamera extends PerspectiveCamera {
	function new(?cameras:Array<PerspectiveCamera>);
	var cameras : Array<PerspectiveCamera>;
	final isArrayCamera : Bool;
	/**
		Applies the rotation represented by the quaternion to the object.
	**/
	function applyQuaternion(quaternion:Quaternion):ArrayCamera;
	/**
		Rotate an object along an axis in object space. The axis is assumed to be normalized.
	**/
	function rotateOnAxis(axis:Vector3, angle:Float):ArrayCamera;
	/**
		Rotate an object along an axis in world space. The axis is assumed to be normalized. Method Assumes no rotated parent.
	**/
	function rotateOnWorldAxis(axis:Vector3, angle:Float):ArrayCamera;
	/**
		Rotates the object around x axis in local space.
	**/
	function rotateX(angle:Float):ArrayCamera;
	/**
		Rotates the object around y axis in local space.
	**/
	function rotateY(angle:Float):ArrayCamera;
	/**
		Rotates the object around z axis in local space.
	**/
	function rotateZ(angle:Float):ArrayCamera;
	/**
		Translate an object by distance along an axis in object space. The axis is assumed to be normalized.
	**/
	function translateOnAxis(axis:Vector3, distance:Float):ArrayCamera;
	/**
		Translates object along x axis by distance.
	**/
	function translateX(distance:Float):ArrayCamera;
	/**
		Translates object along y axis by distance.
	**/
	function translateY(distance:Float):ArrayCamera;
	/**
		Translates object along z axis by distance.
	**/
	function translateZ(distance:Float):ArrayCamera;
	/**
		Adds object as child of this object.
	**/
	function add(object:haxe.extern.Rest<Object3D<Event>>):ArrayCamera;
	/**
		Removes object as child of this object.
	**/
	function remove(object:haxe.extern.Rest<Object3D<Event>>):ArrayCamera;
	/**
		Removes this object from its current parent.
	**/
	function removeFromParent():ArrayCamera;
	/**
		Removes all child objects.
	**/
	function clear():ArrayCamera;
	/**
		Adds object as a child of this, while maintaining the object's world transform.
	**/
	function attach(object:Object3D<Event>):ArrayCamera;
	function clone(?recursive:Bool):ArrayCamera;
	function copy(source:ArrayCamera, ?recursive:Bool):ArrayCamera;
	/**
		Adds a listener to an event type.
	**/
	function addEventListener<T>(type:T, listener:EventListener<Event, T, ArrayCamera>):Void;
	/**
		Checks if listener is added to an event type.
	**/
	function hasEventListener<T>(type:T, listener:EventListener<Event, T, ArrayCamera>):Bool;
	/**
		Removes a listener from an event type.
	**/
	function removeEventListener<T>(type:T, listener:EventListener<Event, T, ArrayCamera>):Void;
	static var prototype : ArrayCamera;
}