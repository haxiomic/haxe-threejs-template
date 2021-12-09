package three;

@:jsRequire("three", "ArrowHelper") extern class ArrowHelper extends Object3D<Event> {
	function new(?dir:Vector3, ?origin:Vector3, ?length:Float, ?color:ColorRepresentation, ?headLength:Float, ?headWidth:Float);
	/**
		Contains the line part of the arrowHelper.
	**/
	var line : Line<BufferGeometry, ts.AnyOf2<Material, Array<Material>>>;
	/**
		Contains the cone part of the arrowHelper.
	**/
	var cone : Mesh<BufferGeometry, ts.AnyOf2<Material, Array<Material>>>;
	function setDirection(dir:Vector3):Void;
	function setLength(length:Float, ?headLength:Float, ?headWidth:Float):Void;
	function setColor(color:ColorRepresentation):Void;
	/**
		Applies the rotation represented by the quaternion to the object.
	**/
	function applyQuaternion(quaternion:Quaternion):ArrowHelper;
	/**
		Rotate an object along an axis in object space. The axis is assumed to be normalized.
	**/
	function rotateOnAxis(axis:Vector3, angle:Float):ArrowHelper;
	/**
		Rotate an object along an axis in world space. The axis is assumed to be normalized. Method Assumes no rotated parent.
	**/
	function rotateOnWorldAxis(axis:Vector3, angle:Float):ArrowHelper;
	/**
		Rotates the object around x axis in local space.
	**/
	function rotateX(angle:Float):ArrowHelper;
	/**
		Rotates the object around y axis in local space.
	**/
	function rotateY(angle:Float):ArrowHelper;
	/**
		Rotates the object around z axis in local space.
	**/
	function rotateZ(angle:Float):ArrowHelper;
	/**
		Translate an object by distance along an axis in object space. The axis is assumed to be normalized.
	**/
	function translateOnAxis(axis:Vector3, distance:Float):ArrowHelper;
	/**
		Translates object along x axis by distance.
	**/
	function translateX(distance:Float):ArrowHelper;
	/**
		Translates object along y axis by distance.
	**/
	function translateY(distance:Float):ArrowHelper;
	/**
		Translates object along z axis by distance.
	**/
	function translateZ(distance:Float):ArrowHelper;
	/**
		Adds object as child of this object.
	**/
	function add(object:haxe.extern.Rest<Object3D<Event>>):ArrowHelper;
	/**
		Removes object as child of this object.
	**/
	function remove(object:haxe.extern.Rest<Object3D<Event>>):ArrowHelper;
	/**
		Removes this object from its current parent.
	**/
	function removeFromParent():ArrowHelper;
	/**
		Removes all child objects.
	**/
	function clear():ArrowHelper;
	/**
		Adds object as a child of this, while maintaining the object's world transform.
	**/
	function attach(object:Object3D<Event>):ArrowHelper;
	function clone(?recursive:Bool):ArrowHelper;
	function copy(source:ArrowHelper, ?recursive:Bool):ArrowHelper;
	/**
		Adds a listener to an event type.
	**/
	function addEventListener<T>(type:T, listener:EventListener<Event, T, ArrowHelper>):Void;
	/**
		Checks if listener is added to an event type.
	**/
	function hasEventListener<T>(type:T, listener:EventListener<Event, T, ArrowHelper>):Bool;
	/**
		Removes a listener from an event type.
	**/
	function removeEventListener<T>(type:T, listener:EventListener<Event, T, ArrowHelper>):Void;
	static var prototype : ArrowHelper;
}