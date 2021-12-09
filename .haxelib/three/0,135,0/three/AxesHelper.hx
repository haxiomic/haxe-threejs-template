package three;

@:jsRequire("three", "AxesHelper") extern class AxesHelper extends LineSegments<BufferGeometry, ts.AnyOf2<Material, Array<Material>>> {
	function new(?size:Float);
	function setColors(xAxisColor:Color, yAxisColor:Color, zAxisColor:Color):AxesHelper;
	function dispose():Void;
	function computeLineDistances():AxesHelper;
	/**
		Applies the rotation represented by the quaternion to the object.
	**/
	function applyQuaternion(quaternion:Quaternion):AxesHelper;
	/**
		Rotate an object along an axis in object space. The axis is assumed to be normalized.
	**/
	function rotateOnAxis(axis:Vector3, angle:Float):AxesHelper;
	/**
		Rotate an object along an axis in world space. The axis is assumed to be normalized. Method Assumes no rotated parent.
	**/
	function rotateOnWorldAxis(axis:Vector3, angle:Float):AxesHelper;
	/**
		Rotates the object around x axis in local space.
	**/
	function rotateX(angle:Float):AxesHelper;
	/**
		Rotates the object around y axis in local space.
	**/
	function rotateY(angle:Float):AxesHelper;
	/**
		Rotates the object around z axis in local space.
	**/
	function rotateZ(angle:Float):AxesHelper;
	/**
		Translate an object by distance along an axis in object space. The axis is assumed to be normalized.
	**/
	function translateOnAxis(axis:Vector3, distance:Float):AxesHelper;
	/**
		Translates object along x axis by distance.
	**/
	function translateX(distance:Float):AxesHelper;
	/**
		Translates object along y axis by distance.
	**/
	function translateY(distance:Float):AxesHelper;
	/**
		Translates object along z axis by distance.
	**/
	function translateZ(distance:Float):AxesHelper;
	/**
		Adds object as child of this object.
	**/
	function add(object:haxe.extern.Rest<Object3D<Event>>):AxesHelper;
	/**
		Removes object as child of this object.
	**/
	function remove(object:haxe.extern.Rest<Object3D<Event>>):AxesHelper;
	/**
		Removes this object from its current parent.
	**/
	function removeFromParent():AxesHelper;
	/**
		Removes all child objects.
	**/
	function clear():AxesHelper;
	/**
		Adds object as a child of this, while maintaining the object's world transform.
	**/
	function attach(object:Object3D<Event>):AxesHelper;
	function clone(?recursive:Bool):AxesHelper;
	function copy(source:AxesHelper, ?recursive:Bool):AxesHelper;
	/**
		Adds a listener to an event type.
	**/
	function addEventListener<T>(type:T, listener:EventListener<Event, T, AxesHelper>):Void;
	/**
		Checks if listener is added to an event type.
	**/
	function hasEventListener<T>(type:T, listener:EventListener<Event, T, AxesHelper>):Bool;
	/**
		Removes a listener from an event type.
	**/
	function removeEventListener<T>(type:T, listener:EventListener<Event, T, AxesHelper>):Void;
	static var prototype : AxesHelper;
}