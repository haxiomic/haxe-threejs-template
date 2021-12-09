package three;

@:jsRequire("three", "Mesh") extern class Mesh<TGeometry, TMaterial> extends Object3D<Event> {
	function new(?geometry:TGeometry, ?material:TMaterial);
	var geometry : TGeometry;
	var material : TMaterial;
	@:optional
	var morphTargetInfluences : Array<Float>;
	@:optional
	var morphTargetDictionary : { };
	final isMesh : Bool;
	function updateMorphTargets():Void;
	function raycast(raycaster:Raycaster, intersects:Array<Intersection<Object3D<Event>>>):Void;
	/**
		Applies the rotation represented by the quaternion to the object.
	**/
	function applyQuaternion(quaternion:Quaternion):Mesh<TGeometry, TMaterial>;
	/**
		Rotate an object along an axis in object space. The axis is assumed to be normalized.
	**/
	function rotateOnAxis(axis:Vector3, angle:Float):Mesh<TGeometry, TMaterial>;
	/**
		Rotate an object along an axis in world space. The axis is assumed to be normalized. Method Assumes no rotated parent.
	**/
	function rotateOnWorldAxis(axis:Vector3, angle:Float):Mesh<TGeometry, TMaterial>;
	/**
		Rotates the object around x axis in local space.
	**/
	function rotateX(angle:Float):Mesh<TGeometry, TMaterial>;
	/**
		Rotates the object around y axis in local space.
	**/
	function rotateY(angle:Float):Mesh<TGeometry, TMaterial>;
	/**
		Rotates the object around z axis in local space.
	**/
	function rotateZ(angle:Float):Mesh<TGeometry, TMaterial>;
	/**
		Translate an object by distance along an axis in object space. The axis is assumed to be normalized.
	**/
	function translateOnAxis(axis:Vector3, distance:Float):Mesh<TGeometry, TMaterial>;
	/**
		Translates object along x axis by distance.
	**/
	function translateX(distance:Float):Mesh<TGeometry, TMaterial>;
	/**
		Translates object along y axis by distance.
	**/
	function translateY(distance:Float):Mesh<TGeometry, TMaterial>;
	/**
		Translates object along z axis by distance.
	**/
	function translateZ(distance:Float):Mesh<TGeometry, TMaterial>;
	/**
		Adds object as child of this object.
	**/
	function add(object:haxe.extern.Rest<Object3D<Event>>):Mesh<TGeometry, TMaterial>;
	/**
		Removes object as child of this object.
	**/
	function remove(object:haxe.extern.Rest<Object3D<Event>>):Mesh<TGeometry, TMaterial>;
	/**
		Removes this object from its current parent.
	**/
	function removeFromParent():Mesh<TGeometry, TMaterial>;
	/**
		Removes all child objects.
	**/
	function clear():Mesh<TGeometry, TMaterial>;
	/**
		Adds object as a child of this, while maintaining the object's world transform.
	**/
	function attach(object:Object3D<Event>):Mesh<TGeometry, TMaterial>;
	function clone(?recursive:Bool):Mesh<TGeometry, TMaterial>;
	function copy(source:Mesh<TGeometry, TMaterial>, ?recursive:Bool):Mesh<TGeometry, TMaterial>;
	/**
		Adds a listener to an event type.
	**/
	function addEventListener<T>(type:T, listener:EventListener<Event, T, Mesh<TGeometry, TMaterial>>):Void;
	/**
		Checks if listener is added to an event type.
	**/
	function hasEventListener<T>(type:T, listener:EventListener<Event, T, Mesh<TGeometry, TMaterial>>):Bool;
	/**
		Removes a listener from an event type.
	**/
	function removeEventListener<T>(type:T, listener:EventListener<Event, T, Mesh<TGeometry, TMaterial>>):Void;
	static var prototype : Mesh<Dynamic, Dynamic>;
}