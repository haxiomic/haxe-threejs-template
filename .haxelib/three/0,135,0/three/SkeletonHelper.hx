package three;

@:jsRequire("three", "SkeletonHelper") extern class SkeletonHelper extends LineSegments<BufferGeometry, ts.AnyOf2<Material, Array<Material>>> {
	function new(object:Object3D<Event>);
	var bones : Array<Bone>;
	var root : Object3D<Event>;
	final isSkeletonHelper : Bool;
	function getBoneList(object:Object3D<Event>):Array<Bone>;
	function update():Void;
	function computeLineDistances():SkeletonHelper;
	/**
		Applies the rotation represented by the quaternion to the object.
	**/
	function applyQuaternion(quaternion:Quaternion):SkeletonHelper;
	/**
		Rotate an object along an axis in object space. The axis is assumed to be normalized.
	**/
	function rotateOnAxis(axis:Vector3, angle:Float):SkeletonHelper;
	/**
		Rotate an object along an axis in world space. The axis is assumed to be normalized. Method Assumes no rotated parent.
	**/
	function rotateOnWorldAxis(axis:Vector3, angle:Float):SkeletonHelper;
	/**
		Rotates the object around x axis in local space.
	**/
	function rotateX(angle:Float):SkeletonHelper;
	/**
		Rotates the object around y axis in local space.
	**/
	function rotateY(angle:Float):SkeletonHelper;
	/**
		Rotates the object around z axis in local space.
	**/
	function rotateZ(angle:Float):SkeletonHelper;
	/**
		Translate an object by distance along an axis in object space. The axis is assumed to be normalized.
	**/
	function translateOnAxis(axis:Vector3, distance:Float):SkeletonHelper;
	/**
		Translates object along x axis by distance.
	**/
	function translateX(distance:Float):SkeletonHelper;
	/**
		Translates object along y axis by distance.
	**/
	function translateY(distance:Float):SkeletonHelper;
	/**
		Translates object along z axis by distance.
	**/
	function translateZ(distance:Float):SkeletonHelper;
	/**
		Adds object as child of this object.
	**/
	function add(object:haxe.extern.Rest<Object3D<Event>>):SkeletonHelper;
	/**
		Removes object as child of this object.
	**/
	function remove(object:haxe.extern.Rest<Object3D<Event>>):SkeletonHelper;
	/**
		Removes this object from its current parent.
	**/
	function removeFromParent():SkeletonHelper;
	/**
		Removes all child objects.
	**/
	function clear():SkeletonHelper;
	/**
		Adds object as a child of this, while maintaining the object's world transform.
	**/
	function attach(object:Object3D<Event>):SkeletonHelper;
	function clone(?recursive:Bool):SkeletonHelper;
	function copy(source:SkeletonHelper, ?recursive:Bool):SkeletonHelper;
	/**
		Adds a listener to an event type.
	**/
	function addEventListener<T>(type:T, listener:EventListener<Event, T, SkeletonHelper>):Void;
	/**
		Checks if listener is added to an event type.
	**/
	function hasEventListener<T>(type:T, listener:EventListener<Event, T, SkeletonHelper>):Bool;
	/**
		Removes a listener from an event type.
	**/
	function removeEventListener<T>(type:T, listener:EventListener<Event, T, SkeletonHelper>):Void;
	static var prototype : SkeletonHelper;
}