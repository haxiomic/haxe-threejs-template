package three;

@:jsRequire("three", "SkinnedMesh") extern class SkinnedMesh<TGeometry, TMaterial> extends Mesh<TGeometry, TMaterial> {
	function new(?geometry:TGeometry, ?material:TMaterial, ?useVertexTexture:Bool);
	var bindMode : String;
	var bindMatrix : Matrix4;
	var bindMatrixInverse : Matrix4;
	var skeleton : Skeleton;
	final isSkinnedMesh : Bool;
	function bind(skeleton:Skeleton, ?bindMatrix:Matrix4):Void;
	function pose():Void;
	function normalizeSkinWeights():Void;
	function boneTransform(index:Float, target:Vector3):Vector3;
	/**
		Applies the rotation represented by the quaternion to the object.
	**/
	function applyQuaternion(quaternion:Quaternion):SkinnedMesh<TGeometry, TMaterial>;
	/**
		Rotate an object along an axis in object space. The axis is assumed to be normalized.
	**/
	function rotateOnAxis(axis:Vector3, angle:Float):SkinnedMesh<TGeometry, TMaterial>;
	/**
		Rotate an object along an axis in world space. The axis is assumed to be normalized. Method Assumes no rotated parent.
	**/
	function rotateOnWorldAxis(axis:Vector3, angle:Float):SkinnedMesh<TGeometry, TMaterial>;
	/**
		Rotates the object around x axis in local space.
	**/
	function rotateX(angle:Float):SkinnedMesh<TGeometry, TMaterial>;
	/**
		Rotates the object around y axis in local space.
	**/
	function rotateY(angle:Float):SkinnedMesh<TGeometry, TMaterial>;
	/**
		Rotates the object around z axis in local space.
	**/
	function rotateZ(angle:Float):SkinnedMesh<TGeometry, TMaterial>;
	/**
		Translate an object by distance along an axis in object space. The axis is assumed to be normalized.
	**/
	function translateOnAxis(axis:Vector3, distance:Float):SkinnedMesh<TGeometry, TMaterial>;
	/**
		Translates object along x axis by distance.
	**/
	function translateX(distance:Float):SkinnedMesh<TGeometry, TMaterial>;
	/**
		Translates object along y axis by distance.
	**/
	function translateY(distance:Float):SkinnedMesh<TGeometry, TMaterial>;
	/**
		Translates object along z axis by distance.
	**/
	function translateZ(distance:Float):SkinnedMesh<TGeometry, TMaterial>;
	/**
		Adds object as child of this object.
	**/
	function add(object:haxe.extern.Rest<Object3D<Event>>):SkinnedMesh<TGeometry, TMaterial>;
	/**
		Removes object as child of this object.
	**/
	function remove(object:haxe.extern.Rest<Object3D<Event>>):SkinnedMesh<TGeometry, TMaterial>;
	/**
		Removes this object from its current parent.
	**/
	function removeFromParent():SkinnedMesh<TGeometry, TMaterial>;
	/**
		Removes all child objects.
	**/
	function clear():SkinnedMesh<TGeometry, TMaterial>;
	/**
		Adds object as a child of this, while maintaining the object's world transform.
	**/
	function attach(object:Object3D<Event>):SkinnedMesh<TGeometry, TMaterial>;
	function clone(?recursive:Bool):SkinnedMesh<TGeometry, TMaterial>;
	function copy(source:SkinnedMesh<TGeometry, TMaterial>, ?recursive:Bool):SkinnedMesh<TGeometry, TMaterial>;
	/**
		Adds a listener to an event type.
	**/
	function addEventListener<T>(type:T, listener:EventListener<Event, T, SkinnedMesh<TGeometry, TMaterial>>):Void;
	/**
		Checks if listener is added to an event type.
	**/
	function hasEventListener<T>(type:T, listener:EventListener<Event, T, SkinnedMesh<TGeometry, TMaterial>>):Bool;
	/**
		Removes a listener from an event type.
	**/
	function removeEventListener<T>(type:T, listener:EventListener<Event, T, SkinnedMesh<TGeometry, TMaterial>>):Void;
	static var prototype : SkinnedMesh<Dynamic, Dynamic>;
}