package three;

@:jsRequire("three", "LOD") extern class LOD extends Object3D<Event> {
	function new();
	var levels : Array<{
		var distance : Float;
		var object : Object3D<Event>;
	}>;
	var autoUpdate : Bool;
	final isLOD : Bool;
	function addLevel(object:Object3D<Event>, ?distance:Float):LOD;
	function getCurrentLevel():Float;
	function getObjectForDistance(distance:Float):Null<Object3D<Event>>;
	function raycast(raycaster:Raycaster, intersects:Array<Intersection<Object3D<Event>>>):Void;
	function update(camera:Camera):Void;
	function toJSON(meta:Dynamic):Dynamic;
	var objects : Array<Dynamic>;
	/**
		Applies the rotation represented by the quaternion to the object.
	**/
	function applyQuaternion(quaternion:Quaternion):LOD;
	/**
		Rotate an object along an axis in object space. The axis is assumed to be normalized.
	**/
	function rotateOnAxis(axis:Vector3, angle:Float):LOD;
	/**
		Rotate an object along an axis in world space. The axis is assumed to be normalized. Method Assumes no rotated parent.
	**/
	function rotateOnWorldAxis(axis:Vector3, angle:Float):LOD;
	/**
		Rotates the object around x axis in local space.
	**/
	function rotateX(angle:Float):LOD;
	/**
		Rotates the object around y axis in local space.
	**/
	function rotateY(angle:Float):LOD;
	/**
		Rotates the object around z axis in local space.
	**/
	function rotateZ(angle:Float):LOD;
	/**
		Translate an object by distance along an axis in object space. The axis is assumed to be normalized.
	**/
	function translateOnAxis(axis:Vector3, distance:Float):LOD;
	/**
		Translates object along x axis by distance.
	**/
	function translateX(distance:Float):LOD;
	/**
		Translates object along y axis by distance.
	**/
	function translateY(distance:Float):LOD;
	/**
		Translates object along z axis by distance.
	**/
	function translateZ(distance:Float):LOD;
	/**
		Adds object as child of this object.
	**/
	function add(object:haxe.extern.Rest<Object3D<Event>>):LOD;
	/**
		Removes object as child of this object.
	**/
	function remove(object:haxe.extern.Rest<Object3D<Event>>):LOD;
	/**
		Removes this object from its current parent.
	**/
	function removeFromParent():LOD;
	/**
		Removes all child objects.
	**/
	function clear():LOD;
	/**
		Adds object as a child of this, while maintaining the object's world transform.
	**/
	function attach(object:Object3D<Event>):LOD;
	function clone(?recursive:Bool):LOD;
	function copy(source:LOD, ?recursive:Bool):LOD;
	/**
		Adds a listener to an event type.
	**/
	function addEventListener<T>(type:T, listener:EventListener<Event, T, LOD>):Void;
	/**
		Checks if listener is added to an event type.
	**/
	function hasEventListener<T>(type:T, listener:EventListener<Event, T, LOD>):Bool;
	/**
		Removes a listener from an event type.
	**/
	function removeEventListener<T>(type:T, listener:EventListener<Event, T, LOD>):Void;
	static var prototype : LOD;
}