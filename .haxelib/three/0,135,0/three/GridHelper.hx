package three;

@:jsRequire("three", "GridHelper") extern class GridHelper extends LineSegments<BufferGeometry, ts.AnyOf2<Material, Array<Material>>> {
	function new(?size:Float, ?divisions:Float, ?color1:ColorRepresentation, ?color2:ColorRepresentation);
	function setColors(?color1:ColorRepresentation, ?color2:ColorRepresentation):Void;
	function computeLineDistances():GridHelper;
	/**
		Applies the rotation represented by the quaternion to the object.
	**/
	function applyQuaternion(quaternion:Quaternion):GridHelper;
	/**
		Rotate an object along an axis in object space. The axis is assumed to be normalized.
	**/
	function rotateOnAxis(axis:Vector3, angle:Float):GridHelper;
	/**
		Rotate an object along an axis in world space. The axis is assumed to be normalized. Method Assumes no rotated parent.
	**/
	function rotateOnWorldAxis(axis:Vector3, angle:Float):GridHelper;
	/**
		Rotates the object around x axis in local space.
	**/
	function rotateX(angle:Float):GridHelper;
	/**
		Rotates the object around y axis in local space.
	**/
	function rotateY(angle:Float):GridHelper;
	/**
		Rotates the object around z axis in local space.
	**/
	function rotateZ(angle:Float):GridHelper;
	/**
		Translate an object by distance along an axis in object space. The axis is assumed to be normalized.
	**/
	function translateOnAxis(axis:Vector3, distance:Float):GridHelper;
	/**
		Translates object along x axis by distance.
	**/
	function translateX(distance:Float):GridHelper;
	/**
		Translates object along y axis by distance.
	**/
	function translateY(distance:Float):GridHelper;
	/**
		Translates object along z axis by distance.
	**/
	function translateZ(distance:Float):GridHelper;
	/**
		Adds object as child of this object.
	**/
	function add(object:haxe.extern.Rest<Object3D<Event>>):GridHelper;
	/**
		Removes object as child of this object.
	**/
	function remove(object:haxe.extern.Rest<Object3D<Event>>):GridHelper;
	/**
		Removes this object from its current parent.
	**/
	function removeFromParent():GridHelper;
	/**
		Removes all child objects.
	**/
	function clear():GridHelper;
	/**
		Adds object as a child of this, while maintaining the object's world transform.
	**/
	function attach(object:Object3D<Event>):GridHelper;
	function clone(?recursive:Bool):GridHelper;
	function copy(source:GridHelper, ?recursive:Bool):GridHelper;
	/**
		Adds a listener to an event type.
	**/
	function addEventListener<T>(type:T, listener:EventListener<Event, T, GridHelper>):Void;
	/**
		Checks if listener is added to an event type.
	**/
	function hasEventListener<T>(type:T, listener:EventListener<Event, T, GridHelper>):Bool;
	/**
		Removes a listener from an event type.
	**/
	function removeEventListener<T>(type:T, listener:EventListener<Event, T, GridHelper>):Void;
	static var prototype : GridHelper;
}