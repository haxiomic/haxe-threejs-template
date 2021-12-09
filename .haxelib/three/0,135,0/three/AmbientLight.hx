package three;

/**
	This light's color gets applied to all the objects in the scene globally.
**/
@:jsRequire("three", "AmbientLight") extern class AmbientLight extends Light {
	/**
		This creates a Ambientlight with a color.
	**/
	function new(?color:ColorRepresentation, ?intensity:Float);
	final isAmbientLight : Bool;
	/**
		Applies the rotation represented by the quaternion to the object.
	**/
	function applyQuaternion(quaternion:Quaternion):AmbientLight;
	/**
		Rotate an object along an axis in object space. The axis is assumed to be normalized.
	**/
	function rotateOnAxis(axis:Vector3, angle:Float):AmbientLight;
	/**
		Rotate an object along an axis in world space. The axis is assumed to be normalized. Method Assumes no rotated parent.
	**/
	function rotateOnWorldAxis(axis:Vector3, angle:Float):AmbientLight;
	/**
		Rotates the object around x axis in local space.
	**/
	function rotateX(angle:Float):AmbientLight;
	/**
		Rotates the object around y axis in local space.
	**/
	function rotateY(angle:Float):AmbientLight;
	/**
		Rotates the object around z axis in local space.
	**/
	function rotateZ(angle:Float):AmbientLight;
	/**
		Translate an object by distance along an axis in object space. The axis is assumed to be normalized.
	**/
	function translateOnAxis(axis:Vector3, distance:Float):AmbientLight;
	/**
		Translates object along x axis by distance.
	**/
	function translateX(distance:Float):AmbientLight;
	/**
		Translates object along y axis by distance.
	**/
	function translateY(distance:Float):AmbientLight;
	/**
		Translates object along z axis by distance.
	**/
	function translateZ(distance:Float):AmbientLight;
	/**
		Adds object as child of this object.
	**/
	function add(object:haxe.extern.Rest<Object3D<Event>>):AmbientLight;
	/**
		Removes object as child of this object.
	**/
	function remove(object:haxe.extern.Rest<Object3D<Event>>):AmbientLight;
	/**
		Removes this object from its current parent.
	**/
	function removeFromParent():AmbientLight;
	/**
		Removes all child objects.
	**/
	function clear():AmbientLight;
	/**
		Adds object as a child of this, while maintaining the object's world transform.
	**/
	function attach(object:Object3D<Event>):AmbientLight;
	function clone(?recursive:Bool):AmbientLight;
	function copy(source:AmbientLight, ?recursive:Bool):AmbientLight;
	/**
		Adds a listener to an event type.
	**/
	function addEventListener<T>(type:T, listener:EventListener<Event, T, AmbientLight>):Void;
	/**
		Checks if listener is added to an event type.
	**/
	function hasEventListener<T>(type:T, listener:EventListener<Event, T, AmbientLight>):Bool;
	/**
		Removes a listener from an event type.
	**/
	function removeEventListener<T>(type:T, listener:EventListener<Event, T, AmbientLight>):Void;
	static var prototype : AmbientLight;
}