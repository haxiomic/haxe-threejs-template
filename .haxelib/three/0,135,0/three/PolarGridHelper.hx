package three;

@:jsRequire("three", "PolarGridHelper") extern class PolarGridHelper extends LineSegments<BufferGeometry, ts.AnyOf2<Material, Array<Material>>> {
	function new(?radius:Float, ?radials:Float, ?circles:Float, ?divisions:Float, ?color1:ColorRepresentation, ?color2:ColorRepresentation);
	function computeLineDistances():PolarGridHelper;
	/**
		Applies the rotation represented by the quaternion to the object.
	**/
	function applyQuaternion(quaternion:Quaternion):PolarGridHelper;
	/**
		Rotate an object along an axis in object space. The axis is assumed to be normalized.
	**/
	function rotateOnAxis(axis:Vector3, angle:Float):PolarGridHelper;
	/**
		Rotate an object along an axis in world space. The axis is assumed to be normalized. Method Assumes no rotated parent.
	**/
	function rotateOnWorldAxis(axis:Vector3, angle:Float):PolarGridHelper;
	/**
		Rotates the object around x axis in local space.
	**/
	function rotateX(angle:Float):PolarGridHelper;
	/**
		Rotates the object around y axis in local space.
	**/
	function rotateY(angle:Float):PolarGridHelper;
	/**
		Rotates the object around z axis in local space.
	**/
	function rotateZ(angle:Float):PolarGridHelper;
	/**
		Translate an object by distance along an axis in object space. The axis is assumed to be normalized.
	**/
	function translateOnAxis(axis:Vector3, distance:Float):PolarGridHelper;
	/**
		Translates object along x axis by distance.
	**/
	function translateX(distance:Float):PolarGridHelper;
	/**
		Translates object along y axis by distance.
	**/
	function translateY(distance:Float):PolarGridHelper;
	/**
		Translates object along z axis by distance.
	**/
	function translateZ(distance:Float):PolarGridHelper;
	/**
		Adds object as child of this object.
	**/
	function add(object:haxe.extern.Rest<Object3D<Event>>):PolarGridHelper;
	/**
		Removes object as child of this object.
	**/
	function remove(object:haxe.extern.Rest<Object3D<Event>>):PolarGridHelper;
	/**
		Removes this object from its current parent.
	**/
	function removeFromParent():PolarGridHelper;
	/**
		Removes all child objects.
	**/
	function clear():PolarGridHelper;
	/**
		Adds object as a child of this, while maintaining the object's world transform.
	**/
	function attach(object:Object3D<Event>):PolarGridHelper;
	function clone(?recursive:Bool):PolarGridHelper;
	function copy(source:PolarGridHelper, ?recursive:Bool):PolarGridHelper;
	/**
		Adds a listener to an event type.
	**/
	function addEventListener<T>(type:T, listener:EventListener<Event, T, PolarGridHelper>):Void;
	/**
		Checks if listener is added to an event type.
	**/
	function hasEventListener<T>(type:T, listener:EventListener<Event, T, PolarGridHelper>):Bool;
	/**
		Removes a listener from an event type.
	**/
	function removeEventListener<T>(type:T, listener:EventListener<Event, T, PolarGridHelper>):Void;
	static var prototype : PolarGridHelper;
}