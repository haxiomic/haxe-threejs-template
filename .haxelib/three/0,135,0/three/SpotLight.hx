package three;

/**
	A point light that can cast shadow in one direction.
**/
@:jsRequire("three", "SpotLight") extern class SpotLight extends Light {
	function new(?color:ColorRepresentation, ?intensity:Float, ?distance:Float, ?angle:Float, ?penumbra:Float, ?decay:Float);
	/**
		Spotlight focus points at target.position.
	**/
	var target : Object3D<Event>;
	/**
		If non-zero, light will attenuate linearly from maximum intensity at light position down to zero at distance.
	**/
	var distance : Float;
	/**
		Maximum extent of the spotlight, in radians, from its direction.
	**/
	var angle : Float;
	var decay : Float;
	var power : Float;
	var penumbra : Float;
	final isSpotLight : Bool;
	/**
		Applies the rotation represented by the quaternion to the object.
	**/
	function applyQuaternion(quaternion:Quaternion):SpotLight;
	/**
		Rotate an object along an axis in object space. The axis is assumed to be normalized.
	**/
	function rotateOnAxis(axis:Vector3, angle:Float):SpotLight;
	/**
		Rotate an object along an axis in world space. The axis is assumed to be normalized. Method Assumes no rotated parent.
	**/
	function rotateOnWorldAxis(axis:Vector3, angle:Float):SpotLight;
	/**
		Rotates the object around x axis in local space.
	**/
	function rotateX(angle:Float):SpotLight;
	/**
		Rotates the object around y axis in local space.
	**/
	function rotateY(angle:Float):SpotLight;
	/**
		Rotates the object around z axis in local space.
	**/
	function rotateZ(angle:Float):SpotLight;
	/**
		Translate an object by distance along an axis in object space. The axis is assumed to be normalized.
	**/
	function translateOnAxis(axis:Vector3, distance:Float):SpotLight;
	/**
		Translates object along x axis by distance.
	**/
	function translateX(distance:Float):SpotLight;
	/**
		Translates object along y axis by distance.
	**/
	function translateY(distance:Float):SpotLight;
	/**
		Translates object along z axis by distance.
	**/
	function translateZ(distance:Float):SpotLight;
	/**
		Adds object as child of this object.
	**/
	function add(object:haxe.extern.Rest<Object3D<Event>>):SpotLight;
	/**
		Removes object as child of this object.
	**/
	function remove(object:haxe.extern.Rest<Object3D<Event>>):SpotLight;
	/**
		Removes this object from its current parent.
	**/
	function removeFromParent():SpotLight;
	/**
		Removes all child objects.
	**/
	function clear():SpotLight;
	/**
		Adds object as a child of this, while maintaining the object's world transform.
	**/
	function attach(object:Object3D<Event>):SpotLight;
	function clone(?recursive:Bool):SpotLight;
	function copy(source:SpotLight, ?recursive:Bool):SpotLight;
	/**
		Adds a listener to an event type.
	**/
	function addEventListener<T>(type:T, listener:EventListener<Event, T, SpotLight>):Void;
	/**
		Checks if listener is added to an event type.
	**/
	function hasEventListener<T>(type:T, listener:EventListener<Event, T, SpotLight>):Bool;
	/**
		Removes a listener from an event type.
	**/
	function removeEventListener<T>(type:T, listener:EventListener<Event, T, SpotLight>):Void;
	static var prototype : SpotLight;
}