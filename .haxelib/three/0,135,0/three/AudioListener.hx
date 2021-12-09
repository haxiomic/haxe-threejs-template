package three;

@:jsRequire("three", "AudioListener") extern class AudioListener extends Object3D<Event> {
	function new();
	var context : js.html.audio.AudioContext;
	var gain : js.html.audio.GainNode;
	var filter : Dynamic;
	var timeDelta : Float;
	function getInput():js.html.audio.GainNode;
	function removeFilter():AudioListener;
	function setFilter(value:Dynamic):AudioListener;
	function getFilter():Dynamic;
	function setMasterVolume(value:Float):AudioListener;
	function getMasterVolume():Float;
	/**
		Applies the rotation represented by the quaternion to the object.
	**/
	function applyQuaternion(quaternion:Quaternion):AudioListener;
	/**
		Rotate an object along an axis in object space. The axis is assumed to be normalized.
	**/
	function rotateOnAxis(axis:Vector3, angle:Float):AudioListener;
	/**
		Rotate an object along an axis in world space. The axis is assumed to be normalized. Method Assumes no rotated parent.
	**/
	function rotateOnWorldAxis(axis:Vector3, angle:Float):AudioListener;
	/**
		Rotates the object around x axis in local space.
	**/
	function rotateX(angle:Float):AudioListener;
	/**
		Rotates the object around y axis in local space.
	**/
	function rotateY(angle:Float):AudioListener;
	/**
		Rotates the object around z axis in local space.
	**/
	function rotateZ(angle:Float):AudioListener;
	/**
		Translate an object by distance along an axis in object space. The axis is assumed to be normalized.
	**/
	function translateOnAxis(axis:Vector3, distance:Float):AudioListener;
	/**
		Translates object along x axis by distance.
	**/
	function translateX(distance:Float):AudioListener;
	/**
		Translates object along y axis by distance.
	**/
	function translateY(distance:Float):AudioListener;
	/**
		Translates object along z axis by distance.
	**/
	function translateZ(distance:Float):AudioListener;
	/**
		Adds object as child of this object.
	**/
	function add(object:haxe.extern.Rest<Object3D<Event>>):AudioListener;
	/**
		Removes object as child of this object.
	**/
	function remove(object:haxe.extern.Rest<Object3D<Event>>):AudioListener;
	/**
		Removes this object from its current parent.
	**/
	function removeFromParent():AudioListener;
	/**
		Removes all child objects.
	**/
	function clear():AudioListener;
	/**
		Adds object as a child of this, while maintaining the object's world transform.
	**/
	function attach(object:Object3D<Event>):AudioListener;
	function clone(?recursive:Bool):AudioListener;
	function copy(source:AudioListener, ?recursive:Bool):AudioListener;
	/**
		Adds a listener to an event type.
	**/
	function addEventListener<T>(type:T, listener:EventListener<Event, T, AudioListener>):Void;
	/**
		Checks if listener is added to an event type.
	**/
	function hasEventListener<T>(type:T, listener:EventListener<Event, T, AudioListener>):Bool;
	/**
		Removes a listener from an event type.
	**/
	function removeEventListener<T>(type:T, listener:EventListener<Event, T, AudioListener>):Void;
	static var prototype : AudioListener;
}