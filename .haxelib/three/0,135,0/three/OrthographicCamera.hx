package three;

/**
	Camera with orthographic projection
	
	see {@link https://github.com/mrdoob/three.js/blob/master/src/cameras/OrthographicCamera.js|src/cameras/OrthographicCamera.js}
**/
@:jsRequire("three", "OrthographicCamera") extern class OrthographicCamera extends Camera {
	function new(?left:Float, ?right:Float, ?top:Float, ?bottom:Float, ?near:Float, ?far:Float);
	final isOrthographicCamera : Bool;
	var zoom : Float;
	var view : Null<{
		var enabled : Bool;
		var fullWidth : Float;
		var fullHeight : Float;
		var offsetX : Float;
		var offsetY : Float;
		var width : Float;
		var height : Float;
	}>;
	/**
		Camera frustum left plane.
	**/
	var left : Float;
	/**
		Camera frustum right plane.
	**/
	var right : Float;
	/**
		Camera frustum top plane.
	**/
	var top : Float;
	/**
		Camera frustum bottom plane.
	**/
	var bottom : Float;
	/**
		Camera frustum near plane.
	**/
	var near : Float;
	/**
		Camera frustum far plane.
	**/
	var far : Float;
	/**
		Updates the camera projection matrix. Must be called after change of parameters.
	**/
	function updateProjectionMatrix():Void;
	function setViewOffset(fullWidth:Float, fullHeight:Float, offsetX:Float, offsetY:Float, width:Float, height:Float):Void;
	function clearViewOffset():Void;
	function toJSON(?meta:Dynamic):Dynamic;
	/**
		Applies the rotation represented by the quaternion to the object.
	**/
	function applyQuaternion(quaternion:Quaternion):OrthographicCamera;
	/**
		Rotate an object along an axis in object space. The axis is assumed to be normalized.
	**/
	function rotateOnAxis(axis:Vector3, angle:Float):OrthographicCamera;
	/**
		Rotate an object along an axis in world space. The axis is assumed to be normalized. Method Assumes no rotated parent.
	**/
	function rotateOnWorldAxis(axis:Vector3, angle:Float):OrthographicCamera;
	/**
		Rotates the object around x axis in local space.
	**/
	function rotateX(angle:Float):OrthographicCamera;
	/**
		Rotates the object around y axis in local space.
	**/
	function rotateY(angle:Float):OrthographicCamera;
	/**
		Rotates the object around z axis in local space.
	**/
	function rotateZ(angle:Float):OrthographicCamera;
	/**
		Translate an object by distance along an axis in object space. The axis is assumed to be normalized.
	**/
	function translateOnAxis(axis:Vector3, distance:Float):OrthographicCamera;
	/**
		Translates object along x axis by distance.
	**/
	function translateX(distance:Float):OrthographicCamera;
	/**
		Translates object along y axis by distance.
	**/
	function translateY(distance:Float):OrthographicCamera;
	/**
		Translates object along z axis by distance.
	**/
	function translateZ(distance:Float):OrthographicCamera;
	/**
		Adds object as child of this object.
	**/
	function add(object:haxe.extern.Rest<Object3D<Event>>):OrthographicCamera;
	/**
		Removes object as child of this object.
	**/
	function remove(object:haxe.extern.Rest<Object3D<Event>>):OrthographicCamera;
	/**
		Removes this object from its current parent.
	**/
	function removeFromParent():OrthographicCamera;
	/**
		Removes all child objects.
	**/
	function clear():OrthographicCamera;
	/**
		Adds object as a child of this, while maintaining the object's world transform.
	**/
	function attach(object:Object3D<Event>):OrthographicCamera;
	function clone(?recursive:Bool):OrthographicCamera;
	function copy(source:OrthographicCamera, ?recursive:Bool):OrthographicCamera;
	/**
		Adds a listener to an event type.
	**/
	function addEventListener<T>(type:T, listener:EventListener<Event, T, OrthographicCamera>):Void;
	/**
		Checks if listener is added to an event type.
	**/
	function hasEventListener<T>(type:T, listener:EventListener<Event, T, OrthographicCamera>):Bool;
	/**
		Removes a listener from an event type.
	**/
	function removeEventListener<T>(type:T, listener:EventListener<Event, T, OrthographicCamera>):Void;
	static var prototype : OrthographicCamera;
}