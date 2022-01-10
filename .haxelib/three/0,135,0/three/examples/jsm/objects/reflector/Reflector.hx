package three.examples.jsm.objects.reflector;

@:jsRequire("three/examples/jsm/objects/Reflector", "Reflector") extern class Reflector extends three.Mesh<three.BufferGeometry, ts.AnyOf2<three.Material, Array<three.Material>>> {
	function new(?geometry:three.BufferGeometry, ?options:ReflectorOptions);
	function getRenderTarget():three.WebGLRenderTarget;
	/**
		Applies the rotation represented by the quaternion to the object.
	**/
	function applyQuaternion(quaternion:three.Quaternion):Reflector;
	/**
		Rotate an object along an axis in object space. The axis is assumed to be normalized.
	**/
	function rotateOnAxis(axis:three.Vector3, angle:Float):Reflector;
	/**
		Rotate an object along an axis in world space. The axis is assumed to be normalized. Method Assumes no rotated parent.
	**/
	function rotateOnWorldAxis(axis:three.Vector3, angle:Float):Reflector;
	/**
		Rotates the object around x axis in local space.
	**/
	function rotateX(angle:Float):Reflector;
	/**
		Rotates the object around y axis in local space.
	**/
	function rotateY(angle:Float):Reflector;
	/**
		Rotates the object around z axis in local space.
	**/
	function rotateZ(angle:Float):Reflector;
	/**
		Translate an object by distance along an axis in object space. The axis is assumed to be normalized.
	**/
	function translateOnAxis(axis:three.Vector3, distance:Float):Reflector;
	/**
		Translates object along x axis by distance.
	**/
	function translateX(distance:Float):Reflector;
	/**
		Translates object along y axis by distance.
	**/
	function translateY(distance:Float):Reflector;
	/**
		Translates object along z axis by distance.
	**/
	function translateZ(distance:Float):Reflector;
	/**
		Adds object as child of this object.
	**/
	function add(object:haxe.extern.Rest<three.Object3D<three.Event>>):Reflector;
	/**
		Removes object as child of this object.
	**/
	function remove(object:haxe.extern.Rest<three.Object3D<three.Event>>):Reflector;
	/**
		Removes this object from its current parent.
	**/
	function removeFromParent():Reflector;
	/**
		Removes all child objects.
	**/
	function clear():Reflector;
	/**
		Adds object as a child of this, while maintaining the object's world transform.
	**/
	function attach(object:three.Object3D<three.Event>):Reflector;
	function clone(?recursive:Bool):Reflector;
	function copy(source:Reflector, ?recursive:Bool):Reflector;
	/**
		Adds a listener to an event type.
	**/
	function addEventListener<T>(type:T, listener:three.EventListener<three.Event, T, Reflector>):Void;
	/**
		Checks if listener is added to an event type.
	**/
	function hasEventListener<T>(type:T, listener:three.EventListener<three.Event, T, Reflector>):Bool;
	/**
		Removes a listener from an event type.
	**/
	function removeEventListener<T>(type:T, listener:three.EventListener<three.Event, T, Reflector>):Void;
	static var prototype : Reflector;
}