package three;

@:jsRequire("three", "PlaneHelper") extern class PlaneHelper extends LineSegments<BufferGeometry, ts.AnyOf2<Material, Array<Material>>> {
	function new(plane:Plane, ?size:Float, ?hex:Float);
	var plane : Plane;
	var size : Float;
	function computeLineDistances():PlaneHelper;
	/**
		Applies the rotation represented by the quaternion to the object.
	**/
	function applyQuaternion(quaternion:Quaternion):PlaneHelper;
	/**
		Rotate an object along an axis in object space. The axis is assumed to be normalized.
	**/
	function rotateOnAxis(axis:Vector3, angle:Float):PlaneHelper;
	/**
		Rotate an object along an axis in world space. The axis is assumed to be normalized. Method Assumes no rotated parent.
	**/
	function rotateOnWorldAxis(axis:Vector3, angle:Float):PlaneHelper;
	/**
		Rotates the object around x axis in local space.
	**/
	function rotateX(angle:Float):PlaneHelper;
	/**
		Rotates the object around y axis in local space.
	**/
	function rotateY(angle:Float):PlaneHelper;
	/**
		Rotates the object around z axis in local space.
	**/
	function rotateZ(angle:Float):PlaneHelper;
	/**
		Translate an object by distance along an axis in object space. The axis is assumed to be normalized.
	**/
	function translateOnAxis(axis:Vector3, distance:Float):PlaneHelper;
	/**
		Translates object along x axis by distance.
	**/
	function translateX(distance:Float):PlaneHelper;
	/**
		Translates object along y axis by distance.
	**/
	function translateY(distance:Float):PlaneHelper;
	/**
		Translates object along z axis by distance.
	**/
	function translateZ(distance:Float):PlaneHelper;
	/**
		Adds object as child of this object.
	**/
	function add(object:haxe.extern.Rest<Object3D<Event>>):PlaneHelper;
	/**
		Removes object as child of this object.
	**/
	function remove(object:haxe.extern.Rest<Object3D<Event>>):PlaneHelper;
	/**
		Removes this object from its current parent.
	**/
	function removeFromParent():PlaneHelper;
	/**
		Removes all child objects.
	**/
	function clear():PlaneHelper;
	/**
		Adds object as a child of this, while maintaining the object's world transform.
	**/
	function attach(object:Object3D<Event>):PlaneHelper;
	function clone(?recursive:Bool):PlaneHelper;
	function copy(source:PlaneHelper, ?recursive:Bool):PlaneHelper;
	/**
		Adds a listener to an event type.
	**/
	function addEventListener<T>(type:T, listener:EventListener<Event, T, PlaneHelper>):Void;
	/**
		Checks if listener is added to an event type.
	**/
	function hasEventListener<T>(type:T, listener:EventListener<Event, T, PlaneHelper>):Bool;
	/**
		Removes a listener from an event type.
	**/
	function removeEventListener<T>(type:T, listener:EventListener<Event, T, PlaneHelper>):Void;
	static var prototype : PlaneHelper;
}