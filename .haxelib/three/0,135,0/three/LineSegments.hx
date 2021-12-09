package three;

@:jsRequire("three", "LineSegments") extern class LineSegments<TGeometry, TMaterial> extends Line<TGeometry, TMaterial> {
	function new(?geometry:TGeometry, ?material:TMaterial);
	final isLineSegments : Bool;
	function computeLineDistances():LineSegments<TGeometry, TMaterial>;
	/**
		Applies the rotation represented by the quaternion to the object.
	**/
	function applyQuaternion(quaternion:Quaternion):LineSegments<TGeometry, TMaterial>;
	/**
		Rotate an object along an axis in object space. The axis is assumed to be normalized.
	**/
	function rotateOnAxis(axis:Vector3, angle:Float):LineSegments<TGeometry, TMaterial>;
	/**
		Rotate an object along an axis in world space. The axis is assumed to be normalized. Method Assumes no rotated parent.
	**/
	function rotateOnWorldAxis(axis:Vector3, angle:Float):LineSegments<TGeometry, TMaterial>;
	/**
		Rotates the object around x axis in local space.
	**/
	function rotateX(angle:Float):LineSegments<TGeometry, TMaterial>;
	/**
		Rotates the object around y axis in local space.
	**/
	function rotateY(angle:Float):LineSegments<TGeometry, TMaterial>;
	/**
		Rotates the object around z axis in local space.
	**/
	function rotateZ(angle:Float):LineSegments<TGeometry, TMaterial>;
	/**
		Translate an object by distance along an axis in object space. The axis is assumed to be normalized.
	**/
	function translateOnAxis(axis:Vector3, distance:Float):LineSegments<TGeometry, TMaterial>;
	/**
		Translates object along x axis by distance.
	**/
	function translateX(distance:Float):LineSegments<TGeometry, TMaterial>;
	/**
		Translates object along y axis by distance.
	**/
	function translateY(distance:Float):LineSegments<TGeometry, TMaterial>;
	/**
		Translates object along z axis by distance.
	**/
	function translateZ(distance:Float):LineSegments<TGeometry, TMaterial>;
	/**
		Adds object as child of this object.
	**/
	function add(object:haxe.extern.Rest<Object3D<Event>>):LineSegments<TGeometry, TMaterial>;
	/**
		Removes object as child of this object.
	**/
	function remove(object:haxe.extern.Rest<Object3D<Event>>):LineSegments<TGeometry, TMaterial>;
	/**
		Removes this object from its current parent.
	**/
	function removeFromParent():LineSegments<TGeometry, TMaterial>;
	/**
		Removes all child objects.
	**/
	function clear():LineSegments<TGeometry, TMaterial>;
	/**
		Adds object as a child of this, while maintaining the object's world transform.
	**/
	function attach(object:Object3D<Event>):LineSegments<TGeometry, TMaterial>;
	function clone(?recursive:Bool):LineSegments<TGeometry, TMaterial>;
	function copy(source:LineSegments<TGeometry, TMaterial>, ?recursive:Bool):LineSegments<TGeometry, TMaterial>;
	/**
		Adds a listener to an event type.
	**/
	function addEventListener<T>(type:T, listener:EventListener<Event, T, LineSegments<TGeometry, TMaterial>>):Void;
	/**
		Checks if listener is added to an event type.
	**/
	function hasEventListener<T>(type:T, listener:EventListener<Event, T, LineSegments<TGeometry, TMaterial>>):Bool;
	/**
		Removes a listener from an event type.
	**/
	function removeEventListener<T>(type:T, listener:EventListener<Event, T, LineSegments<TGeometry, TMaterial>>):Void;
	static var prototype : LineSegments<Dynamic, Dynamic>;
}