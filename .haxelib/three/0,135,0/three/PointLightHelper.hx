package three;

@:jsRequire("three", "PointLightHelper") extern class PointLightHelper extends Object3D<Event> {
	function new(light:PointLight, ?sphereSize:Float, ?color:ColorRepresentation);
	var light : PointLight;
	var color : Null<ColorRepresentation>;
	function dispose():Void;
	function update():Void;
	/**
		Applies the rotation represented by the quaternion to the object.
	**/
	function applyQuaternion(quaternion:Quaternion):PointLightHelper;
	/**
		Rotate an object along an axis in object space. The axis is assumed to be normalized.
	**/
	function rotateOnAxis(axis:Vector3, angle:Float):PointLightHelper;
	/**
		Rotate an object along an axis in world space. The axis is assumed to be normalized. Method Assumes no rotated parent.
	**/
	function rotateOnWorldAxis(axis:Vector3, angle:Float):PointLightHelper;
	/**
		Rotates the object around x axis in local space.
	**/
	function rotateX(angle:Float):PointLightHelper;
	/**
		Rotates the object around y axis in local space.
	**/
	function rotateY(angle:Float):PointLightHelper;
	/**
		Rotates the object around z axis in local space.
	**/
	function rotateZ(angle:Float):PointLightHelper;
	/**
		Translate an object by distance along an axis in object space. The axis is assumed to be normalized.
	**/
	function translateOnAxis(axis:Vector3, distance:Float):PointLightHelper;
	/**
		Translates object along x axis by distance.
	**/
	function translateX(distance:Float):PointLightHelper;
	/**
		Translates object along y axis by distance.
	**/
	function translateY(distance:Float):PointLightHelper;
	/**
		Translates object along z axis by distance.
	**/
	function translateZ(distance:Float):PointLightHelper;
	/**
		Adds object as child of this object.
	**/
	function add(object:haxe.extern.Rest<Object3D<Event>>):PointLightHelper;
	/**
		Removes object as child of this object.
	**/
	function remove(object:haxe.extern.Rest<Object3D<Event>>):PointLightHelper;
	/**
		Removes this object from its current parent.
	**/
	function removeFromParent():PointLightHelper;
	/**
		Removes all child objects.
	**/
	function clear():PointLightHelper;
	/**
		Adds object as a child of this, while maintaining the object's world transform.
	**/
	function attach(object:Object3D<Event>):PointLightHelper;
	function clone(?recursive:Bool):PointLightHelper;
	function copy(source:PointLightHelper, ?recursive:Bool):PointLightHelper;
	/**
		Adds a listener to an event type.
	**/
	function addEventListener<T>(type:T, listener:EventListener<Event, T, PointLightHelper>):Void;
	/**
		Checks if listener is added to an event type.
	**/
	function hasEventListener<T>(type:T, listener:EventListener<Event, T, PointLightHelper>):Bool;
	/**
		Removes a listener from an event type.
	**/
	function removeEventListener<T>(type:T, listener:EventListener<Event, T, PointLightHelper>):Void;
	static var prototype : PointLightHelper;
}