package three;

/**
	Scenes allow you to set up what and where is to be rendered by three.js. This is where you place objects, lights and cameras.
**/
@:jsRequire("three", "Scene") extern class Scene extends Object3D<Event> {
	function new();
	/**
		A fog instance defining the type of fog that affects everything rendered in the scene. Default is null.
	**/
	var fog : Null<FogBase>;
	/**
		If not null, it will force everything in the scene to be rendered with that material. Default is null.
	**/
	var overrideMaterial : Null<Material>;
	var autoUpdate : Bool;
	var background : Null<ts.AnyOf2<Color, Texture>>;
	var environment : Null<Texture>;
	final isScene : Bool;
	function toJSON(?meta:Dynamic):Dynamic;
	/**
		Applies the rotation represented by the quaternion to the object.
	**/
	function applyQuaternion(quaternion:Quaternion):Scene;
	/**
		Rotate an object along an axis in object space. The axis is assumed to be normalized.
	**/
	function rotateOnAxis(axis:Vector3, angle:Float):Scene;
	/**
		Rotate an object along an axis in world space. The axis is assumed to be normalized. Method Assumes no rotated parent.
	**/
	function rotateOnWorldAxis(axis:Vector3, angle:Float):Scene;
	/**
		Rotates the object around x axis in local space.
	**/
	function rotateX(angle:Float):Scene;
	/**
		Rotates the object around y axis in local space.
	**/
	function rotateY(angle:Float):Scene;
	/**
		Rotates the object around z axis in local space.
	**/
	function rotateZ(angle:Float):Scene;
	/**
		Translate an object by distance along an axis in object space. The axis is assumed to be normalized.
	**/
	function translateOnAxis(axis:Vector3, distance:Float):Scene;
	/**
		Translates object along x axis by distance.
	**/
	function translateX(distance:Float):Scene;
	/**
		Translates object along y axis by distance.
	**/
	function translateY(distance:Float):Scene;
	/**
		Translates object along z axis by distance.
	**/
	function translateZ(distance:Float):Scene;
	/**
		Adds object as child of this object.
	**/
	function add(object:haxe.extern.Rest<Object3D<Event>>):Scene;
	/**
		Removes object as child of this object.
	**/
	function remove(object:haxe.extern.Rest<Object3D<Event>>):Scene;
	/**
		Removes this object from its current parent.
	**/
	function removeFromParent():Scene;
	/**
		Removes all child objects.
	**/
	function clear():Scene;
	/**
		Adds object as a child of this, while maintaining the object's world transform.
	**/
	function attach(object:Object3D<Event>):Scene;
	function clone(?recursive:Bool):Scene;
	function copy(source:Scene, ?recursive:Bool):Scene;
	/**
		Adds a listener to an event type.
	**/
	function addEventListener<T>(type:T, listener:EventListener<Event, T, Scene>):Void;
	/**
		Checks if listener is added to an event type.
	**/
	function hasEventListener<T>(type:T, listener:EventListener<Event, T, Scene>):Bool;
	/**
		Removes a listener from an event type.
	**/
	function removeEventListener<T>(type:T, listener:EventListener<Event, T, Scene>):Void;
	static var prototype : Scene;
}