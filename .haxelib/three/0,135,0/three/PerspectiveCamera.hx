package three;

/**
	Camera with perspective projection.
**/
@:jsRequire("three", "PerspectiveCamera") extern class PerspectiveCamera extends Camera {
	function new(?fov:Float, ?aspect:Float, ?near:Float, ?far:Float);
	final isPerspectiveCamera : Bool;
	var zoom : Float;
	/**
		Camera frustum vertical field of view, from bottom to top of view, in degrees.
	**/
	var fov : Float;
	/**
		Camera frustum aspect ratio, window width divided by window height.
	**/
	var aspect : Float;
	/**
		Camera frustum near plane.
	**/
	var near : Float;
	/**
		Camera frustum far plane.
	**/
	var far : Float;
	var focus : Float;
	var view : Null<{
		var enabled : Bool;
		var fullWidth : Float;
		var fullHeight : Float;
		var offsetX : Float;
		var offsetY : Float;
		var width : Float;
		var height : Float;
	}>;
	var filmGauge : Float;
	var filmOffset : Float;
	function setFocalLength(focalLength:Float):Void;
	function getFocalLength():Float;
	function getEffectiveFOV():Float;
	function getFilmWidth():Float;
	function getFilmHeight():Float;
	/**
		Sets an offset in a larger frustum. This is useful for multi-window or multi-monitor/multi-machine setups.
		For example, if you have 3x2 monitors and each monitor is 1920x1080 and the monitors are in grid like this:
		
		+---+---+---+
		| A | B | C |
		+---+---+---+
		| D | E | F |
		+---+---+---+
		
		then for each monitor you would call it like this:
		
		const w = 1920;
		const h = 1080;
		const fullWidth = w * 3;
		const fullHeight = h * 2;
		
		// A
		camera.setViewOffset( fullWidth, fullHeight, w * 0, h * 0, w, h );
		// B
		camera.setViewOffset( fullWidth, fullHeight, w * 1, h * 0, w, h );
		// C
		camera.setViewOffset( fullWidth, fullHeight, w * 2, h * 0, w, h );
		// D
		camera.setViewOffset( fullWidth, fullHeight, w * 0, h * 1, w, h );
		// E
		camera.setViewOffset( fullWidth, fullHeight, w * 1, h * 1, w, h );
		// F
		camera.setViewOffset( fullWidth, fullHeight, w * 2, h * 1, w, h ); Note there is no reason monitors have to be the same size or in a grid.
	**/
	function setViewOffset(fullWidth:Float, fullHeight:Float, x:Float, y:Float, width:Float, height:Float):Void;
	function clearViewOffset():Void;
	/**
		Updates the camera projection matrix. Must be called after change of parameters.
	**/
	function updateProjectionMatrix():Void;
	function toJSON(?meta:Dynamic):Dynamic;
	function setLens(focalLength:Float, ?frameHeight:Float):Void;
	/**
		Applies the rotation represented by the quaternion to the object.
	**/
	function applyQuaternion(quaternion:Quaternion):PerspectiveCamera;
	/**
		Rotate an object along an axis in object space. The axis is assumed to be normalized.
	**/
	function rotateOnAxis(axis:Vector3, angle:Float):PerspectiveCamera;
	/**
		Rotate an object along an axis in world space. The axis is assumed to be normalized. Method Assumes no rotated parent.
	**/
	function rotateOnWorldAxis(axis:Vector3, angle:Float):PerspectiveCamera;
	/**
		Rotates the object around x axis in local space.
	**/
	function rotateX(angle:Float):PerspectiveCamera;
	/**
		Rotates the object around y axis in local space.
	**/
	function rotateY(angle:Float):PerspectiveCamera;
	/**
		Rotates the object around z axis in local space.
	**/
	function rotateZ(angle:Float):PerspectiveCamera;
	/**
		Translate an object by distance along an axis in object space. The axis is assumed to be normalized.
	**/
	function translateOnAxis(axis:Vector3, distance:Float):PerspectiveCamera;
	/**
		Translates object along x axis by distance.
	**/
	function translateX(distance:Float):PerspectiveCamera;
	/**
		Translates object along y axis by distance.
	**/
	function translateY(distance:Float):PerspectiveCamera;
	/**
		Translates object along z axis by distance.
	**/
	function translateZ(distance:Float):PerspectiveCamera;
	/**
		Adds object as child of this object.
	**/
	function add(object:haxe.extern.Rest<Object3D<Event>>):PerspectiveCamera;
	/**
		Removes object as child of this object.
	**/
	function remove(object:haxe.extern.Rest<Object3D<Event>>):PerspectiveCamera;
	/**
		Removes this object from its current parent.
	**/
	function removeFromParent():PerspectiveCamera;
	/**
		Removes all child objects.
	**/
	function clear():PerspectiveCamera;
	/**
		Adds object as a child of this, while maintaining the object's world transform.
	**/
	function attach(object:Object3D<Event>):PerspectiveCamera;
	function clone(?recursive:Bool):PerspectiveCamera;
	function copy(source:PerspectiveCamera, ?recursive:Bool):PerspectiveCamera;
	/**
		Adds a listener to an event type.
	**/
	function addEventListener<T>(type:T, listener:EventListener<Event, T, PerspectiveCamera>):Void;
	/**
		Checks if listener is added to an event type.
	**/
	function hasEventListener<T>(type:T, listener:EventListener<Event, T, PerspectiveCamera>):Bool;
	/**
		Removes a listener from an event type.
	**/
	function removeEventListener<T>(type:T, listener:EventListener<Event, T, PerspectiveCamera>):Void;
	static var prototype : PerspectiveCamera;
}