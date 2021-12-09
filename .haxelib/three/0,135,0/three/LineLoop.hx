package three;

@:jsRequire("three", "LineLoop") extern class LineLoop<TGeometry, TMaterial> extends Line<TGeometry, TMaterial> {
	function new(?geometry:TGeometry, ?material:TMaterial);
	final isLineLoop : Bool;
	function computeLineDistances():LineLoop<TGeometry, TMaterial>;
	/**
		Applies the rotation represented by the quaternion to the object.
	**/
	function applyQuaternion(quaternion:Quaternion):LineLoop<TGeometry, TMaterial>;
	/**
		Rotate an object along an axis in object space. The axis is assumed to be normalized.
	**/
	function rotateOnAxis(axis:Vector3, angle:Float):LineLoop<TGeometry, TMaterial>;
	/**
		Rotate an object along an axis in world space. The axis is assumed to be normalized. Method Assumes no rotated parent.
	**/
	function rotateOnWorldAxis(axis:Vector3, angle:Float):LineLoop<TGeometry, TMaterial>;
	/**
		Rotates the object around x axis in local space.
	**/
	function rotateX(angle:Float):LineLoop<TGeometry, TMaterial>;
	/**
		Rotates the object around y axis in local space.
	**/
	function rotateY(angle:Float):LineLoop<TGeometry, TMaterial>;
	/**
		Rotates the object around z axis in local space.
	**/
	function rotateZ(angle:Float):LineLoop<TGeometry, TMaterial>;
	/**
		Translate an object by distance along an axis in object space. The axis is assumed to be normalized.
	**/
	function translateOnAxis(axis:Vector3, distance:Float):LineLoop<TGeometry, TMaterial>;
	/**
		Translates object along x axis by distance.
	**/
	function translateX(distance:Float):LineLoop<TGeometry, TMaterial>;
	/**
		Translates object along y axis by distance.
	**/
	function translateY(distance:Float):LineLoop<TGeometry, TMaterial>;
	/**
		Translates object along z axis by distance.
	**/
	function translateZ(distance:Float):LineLoop<TGeometry, TMaterial>;
	/**
		Adds object as child of this object.
	**/
	function add(object:haxe.extern.Rest<Object3D<Event>>):LineLoop<TGeometry, TMaterial>;
	/**
		Removes object as child of this object.
	**/
	function remove(object:haxe.extern.Rest<Object3D<Event>>):LineLoop<TGeometry, TMaterial>;
	/**
		Removes this object from its current parent.
	**/
	function removeFromParent():LineLoop<TGeometry, TMaterial>;
	/**
		Removes all child objects.
	**/
	function clear():LineLoop<TGeometry, TMaterial>;
	/**
		Adds object as a child of this, while maintaining the object's world transform.
	**/
	function attach(object:Object3D<Event>):LineLoop<TGeometry, TMaterial>;
	function clone(?recursive:Bool):LineLoop<TGeometry, TMaterial>;
	function copy(source:LineLoop<TGeometry, TMaterial>, ?recursive:Bool):LineLoop<TGeometry, TMaterial>;
	/**
		Adds a listener to an event type.
	**/
	function addEventListener<T>(type:T, listener:EventListener<Event, T, LineLoop<TGeometry, TMaterial>>):Void;
	/**
		Checks if listener is added to an event type.
	**/
	function hasEventListener<T>(type:T, listener:EventListener<Event, T, LineLoop<TGeometry, TMaterial>>):Bool;
	/**
		Removes a listener from an event type.
	**/
	function removeEventListener<T>(type:T, listener:EventListener<Event, T, LineLoop<TGeometry, TMaterial>>):Void;
	static var prototype : LineLoop<Dynamic, Dynamic>;
}