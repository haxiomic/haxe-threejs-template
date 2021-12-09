package three;

@:jsRequire("three", "HemisphereLightHelper") extern class HemisphereLightHelper extends Object3D<Event> {
	function new(light:HemisphereLight, size:Float, ?color:ColorRepresentation);
	var light : HemisphereLight;
	var material : MeshBasicMaterial;
	var color : Null<ColorRepresentation>;
	function dispose():Void;
	function update():Void;
	/**
		Applies the rotation represented by the quaternion to the object.
	**/
	function applyQuaternion(quaternion:Quaternion):HemisphereLightHelper;
	/**
		Rotate an object along an axis in object space. The axis is assumed to be normalized.
	**/
	function rotateOnAxis(axis:Vector3, angle:Float):HemisphereLightHelper;
	/**
		Rotate an object along an axis in world space. The axis is assumed to be normalized. Method Assumes no rotated parent.
	**/
	function rotateOnWorldAxis(axis:Vector3, angle:Float):HemisphereLightHelper;
	/**
		Rotates the object around x axis in local space.
	**/
	function rotateX(angle:Float):HemisphereLightHelper;
	/**
		Rotates the object around y axis in local space.
	**/
	function rotateY(angle:Float):HemisphereLightHelper;
	/**
		Rotates the object around z axis in local space.
	**/
	function rotateZ(angle:Float):HemisphereLightHelper;
	/**
		Translate an object by distance along an axis in object space. The axis is assumed to be normalized.
	**/
	function translateOnAxis(axis:Vector3, distance:Float):HemisphereLightHelper;
	/**
		Translates object along x axis by distance.
	**/
	function translateX(distance:Float):HemisphereLightHelper;
	/**
		Translates object along y axis by distance.
	**/
	function translateY(distance:Float):HemisphereLightHelper;
	/**
		Translates object along z axis by distance.
	**/
	function translateZ(distance:Float):HemisphereLightHelper;
	/**
		Adds object as child of this object.
	**/
	function add(object:haxe.extern.Rest<Object3D<Event>>):HemisphereLightHelper;
	/**
		Removes object as child of this object.
	**/
	function remove(object:haxe.extern.Rest<Object3D<Event>>):HemisphereLightHelper;
	/**
		Removes this object from its current parent.
	**/
	function removeFromParent():HemisphereLightHelper;
	/**
		Removes all child objects.
	**/
	function clear():HemisphereLightHelper;
	/**
		Adds object as a child of this, while maintaining the object's world transform.
	**/
	function attach(object:Object3D<Event>):HemisphereLightHelper;
	function clone(?recursive:Bool):HemisphereLightHelper;
	function copy(source:HemisphereLightHelper, ?recursive:Bool):HemisphereLightHelper;
	/**
		Adds a listener to an event type.
	**/
	function addEventListener<T>(type:T, listener:EventListener<Event, T, HemisphereLightHelper>):Void;
	/**
		Checks if listener is added to an event type.
	**/
	function hasEventListener<T>(type:T, listener:EventListener<Event, T, HemisphereLightHelper>):Bool;
	/**
		Removes a listener from an event type.
	**/
	function removeEventListener<T>(type:T, listener:EventListener<Event, T, HemisphereLightHelper>):Void;
	static var prototype : HemisphereLightHelper;
}