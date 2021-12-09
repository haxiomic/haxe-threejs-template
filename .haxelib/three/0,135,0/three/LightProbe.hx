package three;

@:jsRequire("three", "LightProbe") extern class LightProbe extends Light {
	function new(?sh:SphericalHarmonics3, ?intensity:Float);
	final isLightProbe : Bool;
	var sh : SphericalHarmonics3;
	function fromJSON(json:Dynamic):LightProbe;
	/**
		Applies the rotation represented by the quaternion to the object.
	**/
	function applyQuaternion(quaternion:Quaternion):LightProbe;
	/**
		Rotate an object along an axis in object space. The axis is assumed to be normalized.
	**/
	function rotateOnAxis(axis:Vector3, angle:Float):LightProbe;
	/**
		Rotate an object along an axis in world space. The axis is assumed to be normalized. Method Assumes no rotated parent.
	**/
	function rotateOnWorldAxis(axis:Vector3, angle:Float):LightProbe;
	/**
		Rotates the object around x axis in local space.
	**/
	function rotateX(angle:Float):LightProbe;
	/**
		Rotates the object around y axis in local space.
	**/
	function rotateY(angle:Float):LightProbe;
	/**
		Rotates the object around z axis in local space.
	**/
	function rotateZ(angle:Float):LightProbe;
	/**
		Translate an object by distance along an axis in object space. The axis is assumed to be normalized.
	**/
	function translateOnAxis(axis:Vector3, distance:Float):LightProbe;
	/**
		Translates object along x axis by distance.
	**/
	function translateX(distance:Float):LightProbe;
	/**
		Translates object along y axis by distance.
	**/
	function translateY(distance:Float):LightProbe;
	/**
		Translates object along z axis by distance.
	**/
	function translateZ(distance:Float):LightProbe;
	/**
		Adds object as child of this object.
	**/
	function add(object:haxe.extern.Rest<Object3D<Event>>):LightProbe;
	/**
		Removes object as child of this object.
	**/
	function remove(object:haxe.extern.Rest<Object3D<Event>>):LightProbe;
	/**
		Removes this object from its current parent.
	**/
	function removeFromParent():LightProbe;
	/**
		Removes all child objects.
	**/
	function clear():LightProbe;
	/**
		Adds object as a child of this, while maintaining the object's world transform.
	**/
	function attach(object:Object3D<Event>):LightProbe;
	function clone(?recursive:Bool):LightProbe;
	function copy(source:LightProbe, ?recursive:Bool):LightProbe;
	/**
		Adds a listener to an event type.
	**/
	function addEventListener<T>(type:T, listener:EventListener<Event, T, LightProbe>):Void;
	/**
		Checks if listener is added to an event type.
	**/
	function hasEventListener<T>(type:T, listener:EventListener<Event, T, LightProbe>):Bool;
	/**
		Removes a listener from an event type.
	**/
	function removeEventListener<T>(type:T, listener:EventListener<Event, T, LightProbe>):Void;
	static var prototype : LightProbe;
}