package three;

@:jsRequire("three", "InstancedMesh") extern class InstancedMesh<TGeometry, TMaterial> extends Mesh<TGeometry, TMaterial> {
	function new(geometry:Null<TGeometry>, material:Null<TMaterial>, count:Float);
	var count : Float;
	var instanceColor : Null<InstancedBufferAttribute>;
	var instanceMatrix : InstancedBufferAttribute;
	final isInstancedMesh : Bool;
	function getColorAt(index:Float, color:Color):Void;
	function getMatrixAt(index:Float, matrix:Matrix4):Void;
	function setColorAt(index:Float, color:Color):Void;
	function setMatrixAt(index:Float, matrix:Matrix4):Void;
	function dispose():Void;
	/**
		Applies the rotation represented by the quaternion to the object.
	**/
	function applyQuaternion(quaternion:Quaternion):InstancedMesh<TGeometry, TMaterial>;
	/**
		Rotate an object along an axis in object space. The axis is assumed to be normalized.
	**/
	function rotateOnAxis(axis:Vector3, angle:Float):InstancedMesh<TGeometry, TMaterial>;
	/**
		Rotate an object along an axis in world space. The axis is assumed to be normalized. Method Assumes no rotated parent.
	**/
	function rotateOnWorldAxis(axis:Vector3, angle:Float):InstancedMesh<TGeometry, TMaterial>;
	/**
		Rotates the object around x axis in local space.
	**/
	function rotateX(angle:Float):InstancedMesh<TGeometry, TMaterial>;
	/**
		Rotates the object around y axis in local space.
	**/
	function rotateY(angle:Float):InstancedMesh<TGeometry, TMaterial>;
	/**
		Rotates the object around z axis in local space.
	**/
	function rotateZ(angle:Float):InstancedMesh<TGeometry, TMaterial>;
	/**
		Translate an object by distance along an axis in object space. The axis is assumed to be normalized.
	**/
	function translateOnAxis(axis:Vector3, distance:Float):InstancedMesh<TGeometry, TMaterial>;
	/**
		Translates object along x axis by distance.
	**/
	function translateX(distance:Float):InstancedMesh<TGeometry, TMaterial>;
	/**
		Translates object along y axis by distance.
	**/
	function translateY(distance:Float):InstancedMesh<TGeometry, TMaterial>;
	/**
		Translates object along z axis by distance.
	**/
	function translateZ(distance:Float):InstancedMesh<TGeometry, TMaterial>;
	/**
		Adds object as child of this object.
	**/
	function add(object:haxe.extern.Rest<Object3D<Event>>):InstancedMesh<TGeometry, TMaterial>;
	/**
		Removes object as child of this object.
	**/
	function remove(object:haxe.extern.Rest<Object3D<Event>>):InstancedMesh<TGeometry, TMaterial>;
	/**
		Removes this object from its current parent.
	**/
	function removeFromParent():InstancedMesh<TGeometry, TMaterial>;
	/**
		Removes all child objects.
	**/
	function clear():InstancedMesh<TGeometry, TMaterial>;
	/**
		Adds object as a child of this, while maintaining the object's world transform.
	**/
	function attach(object:Object3D<Event>):InstancedMesh<TGeometry, TMaterial>;
	function clone(?recursive:Bool):InstancedMesh<TGeometry, TMaterial>;
	function copy(source:InstancedMesh<TGeometry, TMaterial>, ?recursive:Bool):InstancedMesh<TGeometry, TMaterial>;
	/**
		Adds a listener to an event type.
	**/
	function addEventListener<T>(type:T, listener:EventListener<Event, T, InstancedMesh<TGeometry, TMaterial>>):Void;
	/**
		Checks if listener is added to an event type.
	**/
	function hasEventListener<T>(type:T, listener:EventListener<Event, T, InstancedMesh<TGeometry, TMaterial>>):Bool;
	/**
		Removes a listener from an event type.
	**/
	function removeEventListener<T>(type:T, listener:EventListener<Event, T, InstancedMesh<TGeometry, TMaterial>>):Void;
	static var prototype : InstancedMesh<Dynamic, Dynamic>;
}