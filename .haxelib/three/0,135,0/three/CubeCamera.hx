package three;

@:jsRequire("three", "CubeCamera") extern class CubeCamera extends Object3D<Event> {
	function new(near:Float, far:Float, renderTarget:WebGLCubeRenderTarget);
	var renderTarget : WebGLCubeRenderTarget;
	function update(renderer:WebGLRenderer, scene:Scene):Void;
	/**
		Applies the rotation represented by the quaternion to the object.
	**/
	function applyQuaternion(quaternion:Quaternion):CubeCamera;
	/**
		Rotate an object along an axis in object space. The axis is assumed to be normalized.
	**/
	function rotateOnAxis(axis:Vector3, angle:Float):CubeCamera;
	/**
		Rotate an object along an axis in world space. The axis is assumed to be normalized. Method Assumes no rotated parent.
	**/
	function rotateOnWorldAxis(axis:Vector3, angle:Float):CubeCamera;
	/**
		Rotates the object around x axis in local space.
	**/
	function rotateX(angle:Float):CubeCamera;
	/**
		Rotates the object around y axis in local space.
	**/
	function rotateY(angle:Float):CubeCamera;
	/**
		Rotates the object around z axis in local space.
	**/
	function rotateZ(angle:Float):CubeCamera;
	/**
		Translate an object by distance along an axis in object space. The axis is assumed to be normalized.
	**/
	function translateOnAxis(axis:Vector3, distance:Float):CubeCamera;
	/**
		Translates object along x axis by distance.
	**/
	function translateX(distance:Float):CubeCamera;
	/**
		Translates object along y axis by distance.
	**/
	function translateY(distance:Float):CubeCamera;
	/**
		Translates object along z axis by distance.
	**/
	function translateZ(distance:Float):CubeCamera;
	/**
		Adds object as child of this object.
	**/
	function add(object:haxe.extern.Rest<Object3D<Event>>):CubeCamera;
	/**
		Removes object as child of this object.
	**/
	function remove(object:haxe.extern.Rest<Object3D<Event>>):CubeCamera;
	/**
		Removes this object from its current parent.
	**/
	function removeFromParent():CubeCamera;
	/**
		Removes all child objects.
	**/
	function clear():CubeCamera;
	/**
		Adds object as a child of this, while maintaining the object's world transform.
	**/
	function attach(object:Object3D<Event>):CubeCamera;
	function clone(?recursive:Bool):CubeCamera;
	function copy(source:CubeCamera, ?recursive:Bool):CubeCamera;
	/**
		Adds a listener to an event type.
	**/
	function addEventListener<T>(type:T, listener:EventListener<Event, T, CubeCamera>):Void;
	/**
		Checks if listener is added to an event type.
	**/
	function hasEventListener<T>(type:T, listener:EventListener<Event, T, CubeCamera>):Bool;
	/**
		Removes a listener from an event type.
	**/
	function removeEventListener<T>(type:T, listener:EventListener<Event, T, CubeCamera>):Void;
	static var prototype : CubeCamera;
}