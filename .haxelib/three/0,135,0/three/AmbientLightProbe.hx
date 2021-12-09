package three;

@:jsRequire("three", "AmbientLightProbe") extern class AmbientLightProbe extends LightProbe {
	function new(?color:ColorRepresentation, ?intensity:Float);
	final isAmbientLightProbe : Bool;
	/**
		Applies the rotation represented by the quaternion to the object.
	**/
	function applyQuaternion(quaternion:Quaternion):AmbientLightProbe;
	/**
		Rotate an object along an axis in object space. The axis is assumed to be normalized.
	**/
	function rotateOnAxis(axis:Vector3, angle:Float):AmbientLightProbe;
	/**
		Rotate an object along an axis in world space. The axis is assumed to be normalized. Method Assumes no rotated parent.
	**/
	function rotateOnWorldAxis(axis:Vector3, angle:Float):AmbientLightProbe;
	/**
		Rotates the object around x axis in local space.
	**/
	function rotateX(angle:Float):AmbientLightProbe;
	/**
		Rotates the object around y axis in local space.
	**/
	function rotateY(angle:Float):AmbientLightProbe;
	/**
		Rotates the object around z axis in local space.
	**/
	function rotateZ(angle:Float):AmbientLightProbe;
	/**
		Translate an object by distance along an axis in object space. The axis is assumed to be normalized.
	**/
	function translateOnAxis(axis:Vector3, distance:Float):AmbientLightProbe;
	/**
		Translates object along x axis by distance.
	**/
	function translateX(distance:Float):AmbientLightProbe;
	/**
		Translates object along y axis by distance.
	**/
	function translateY(distance:Float):AmbientLightProbe;
	/**
		Translates object along z axis by distance.
	**/
	function translateZ(distance:Float):AmbientLightProbe;
	/**
		Adds object as child of this object.
	**/
	function add(object:haxe.extern.Rest<Object3D<Event>>):AmbientLightProbe;
	/**
		Removes object as child of this object.
	**/
	function remove(object:haxe.extern.Rest<Object3D<Event>>):AmbientLightProbe;
	/**
		Removes this object from its current parent.
	**/
	function removeFromParent():AmbientLightProbe;
	/**
		Removes all child objects.
	**/
	function clear():AmbientLightProbe;
	/**
		Adds object as a child of this, while maintaining the object's world transform.
	**/
	function attach(object:Object3D<Event>):AmbientLightProbe;
	function clone(?recursive:Bool):AmbientLightProbe;
	function copy(source:AmbientLightProbe, ?recursive:Bool):AmbientLightProbe;
	/**
		Adds a listener to an event type.
	**/
	function addEventListener<T>(type:T, listener:EventListener<Event, T, AmbientLightProbe>):Void;
	/**
		Checks if listener is added to an event type.
	**/
	function hasEventListener<T>(type:T, listener:EventListener<Event, T, AmbientLightProbe>):Bool;
	/**
		Removes a listener from an event type.
	**/
	function removeEventListener<T>(type:T, listener:EventListener<Event, T, AmbientLightProbe>):Void;
	static var prototype : AmbientLightProbe;
}