package three;

@:jsRequire("three", "Line") extern class Line<TGeometry, TMaterial> extends Object3D<Event> {
	function new(?geometry:TGeometry, ?material:TMaterial);
	var geometry : TGeometry;
	var material : TMaterial;
	final isLine : Bool;
	@:optional
	var morphTargetInfluences : Array<Float>;
	@:optional
	var morphTargetDictionary : { };
	function computeLineDistances():Line<TGeometry, TMaterial>;
	function raycast(raycaster:Raycaster, intersects:Array<Intersection<Object3D<Event>>>):Void;
	function updateMorphTargets():Void;
	/**
		Applies the rotation represented by the quaternion to the object.
	**/
	function applyQuaternion(quaternion:Quaternion):Line<TGeometry, TMaterial>;
	/**
		Rotate an object along an axis in object space. The axis is assumed to be normalized.
	**/
	function rotateOnAxis(axis:Vector3, angle:Float):Line<TGeometry, TMaterial>;
	/**
		Rotate an object along an axis in world space. The axis is assumed to be normalized. Method Assumes no rotated parent.
	**/
	function rotateOnWorldAxis(axis:Vector3, angle:Float):Line<TGeometry, TMaterial>;
	/**
		Rotates the object around x axis in local space.
	**/
	function rotateX(angle:Float):Line<TGeometry, TMaterial>;
	/**
		Rotates the object around y axis in local space.
	**/
	function rotateY(angle:Float):Line<TGeometry, TMaterial>;
	/**
		Rotates the object around z axis in local space.
	**/
	function rotateZ(angle:Float):Line<TGeometry, TMaterial>;
	/**
		Translate an object by distance along an axis in object space. The axis is assumed to be normalized.
	**/
	function translateOnAxis(axis:Vector3, distance:Float):Line<TGeometry, TMaterial>;
	/**
		Translates object along x axis by distance.
	**/
	function translateX(distance:Float):Line<TGeometry, TMaterial>;
	/**
		Translates object along y axis by distance.
	**/
	function translateY(distance:Float):Line<TGeometry, TMaterial>;
	/**
		Translates object along z axis by distance.
	**/
	function translateZ(distance:Float):Line<TGeometry, TMaterial>;
	/**
		Adds object as child of this object.
	**/
	function add(object:haxe.extern.Rest<Object3D<Event>>):Line<TGeometry, TMaterial>;
	/**
		Removes object as child of this object.
	**/
	function remove(object:haxe.extern.Rest<Object3D<Event>>):Line<TGeometry, TMaterial>;
	/**
		Removes this object from its current parent.
	**/
	function removeFromParent():Line<TGeometry, TMaterial>;
	/**
		Removes all child objects.
	**/
	function clear():Line<TGeometry, TMaterial>;
	/**
		Adds object as a child of this, while maintaining the object's world transform.
	**/
	function attach(object:Object3D<Event>):Line<TGeometry, TMaterial>;
	function clone(?recursive:Bool):Line<TGeometry, TMaterial>;
	function copy(source:Line<TGeometry, TMaterial>, ?recursive:Bool):Line<TGeometry, TMaterial>;
	/**
		Adds a listener to an event type.
	**/
	function addEventListener<T>(type:T, listener:EventListener<Event, T, Line<TGeometry, TMaterial>>):Void;
	/**
		Checks if listener is added to an event type.
	**/
	function hasEventListener<T>(type:T, listener:EventListener<Event, T, Line<TGeometry, TMaterial>>):Bool;
	/**
		Removes a listener from an event type.
	**/
	function removeEventListener<T>(type:T, listener:EventListener<Event, T, Line<TGeometry, TMaterial>>):Void;
	static var prototype : Line<Dynamic, Dynamic>;
}