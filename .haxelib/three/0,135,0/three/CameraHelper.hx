package three;

@:jsRequire("three", "CameraHelper") extern class CameraHelper extends LineSegments<BufferGeometry, ts.AnyOf2<Material, Array<Material>>> {
	function new(camera:Camera);
	var camera : Camera;
	var pointMap : { };
	function update():Void;
	function dispose():Void;
	function computeLineDistances():CameraHelper;
	/**
		Applies the rotation represented by the quaternion to the object.
	**/
	function applyQuaternion(quaternion:Quaternion):CameraHelper;
	/**
		Rotate an object along an axis in object space. The axis is assumed to be normalized.
	**/
	function rotateOnAxis(axis:Vector3, angle:Float):CameraHelper;
	/**
		Rotate an object along an axis in world space. The axis is assumed to be normalized. Method Assumes no rotated parent.
	**/
	function rotateOnWorldAxis(axis:Vector3, angle:Float):CameraHelper;
	/**
		Rotates the object around x axis in local space.
	**/
	function rotateX(angle:Float):CameraHelper;
	/**
		Rotates the object around y axis in local space.
	**/
	function rotateY(angle:Float):CameraHelper;
	/**
		Rotates the object around z axis in local space.
	**/
	function rotateZ(angle:Float):CameraHelper;
	/**
		Translate an object by distance along an axis in object space. The axis is assumed to be normalized.
	**/
	function translateOnAxis(axis:Vector3, distance:Float):CameraHelper;
	/**
		Translates object along x axis by distance.
	**/
	function translateX(distance:Float):CameraHelper;
	/**
		Translates object along y axis by distance.
	**/
	function translateY(distance:Float):CameraHelper;
	/**
		Translates object along z axis by distance.
	**/
	function translateZ(distance:Float):CameraHelper;
	/**
		Adds object as child of this object.
	**/
	function add(object:haxe.extern.Rest<Object3D<Event>>):CameraHelper;
	/**
		Removes object as child of this object.
	**/
	function remove(object:haxe.extern.Rest<Object3D<Event>>):CameraHelper;
	/**
		Removes this object from its current parent.
	**/
	function removeFromParent():CameraHelper;
	/**
		Removes all child objects.
	**/
	function clear():CameraHelper;
	/**
		Adds object as a child of this, while maintaining the object's world transform.
	**/
	function attach(object:Object3D<Event>):CameraHelper;
	function clone(?recursive:Bool):CameraHelper;
	function copy(source:CameraHelper, ?recursive:Bool):CameraHelper;
	/**
		Adds a listener to an event type.
	**/
	function addEventListener<T>(type:T, listener:EventListener<Event, T, CameraHelper>):Void;
	/**
		Checks if listener is added to an event type.
	**/
	function hasEventListener<T>(type:T, listener:EventListener<Event, T, CameraHelper>):Bool;
	/**
		Removes a listener from an event type.
	**/
	function removeEventListener<T>(type:T, listener:EventListener<Event, T, CameraHelper>):Void;
	static var prototype : CameraHelper;
}