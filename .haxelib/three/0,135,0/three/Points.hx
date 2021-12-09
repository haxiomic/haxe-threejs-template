package three;

/**
	A class for displaying points. The points are rendered by the WebGLRenderer using gl.POINTS.
**/
@:jsRequire("three", "Points") extern class Points<TGeometry, TMaterial> extends Object3D<Event> {
	function new(?geometry:TGeometry, ?material:TMaterial);
	@:optional
	var morphTargetInfluences : Array<Float>;
	@:optional
	var morphTargetDictionary : { };
	final isPoints : Bool;
	/**
		An instance of BufferGeometry, where each vertex designates the position of a particle in the system.
	**/
	var geometry : TGeometry;
	/**
		An instance of Material, defining the object's appearance. Default is a PointsMaterial with randomised colour.
	**/
	var material : TMaterial;
	function raycast(raycaster:Raycaster, intersects:Array<Intersection<Object3D<Event>>>):Void;
	function updateMorphTargets():Void;
	/**
		Applies the rotation represented by the quaternion to the object.
	**/
	function applyQuaternion(quaternion:Quaternion):Points<TGeometry, TMaterial>;
	/**
		Rotate an object along an axis in object space. The axis is assumed to be normalized.
	**/
	function rotateOnAxis(axis:Vector3, angle:Float):Points<TGeometry, TMaterial>;
	/**
		Rotate an object along an axis in world space. The axis is assumed to be normalized. Method Assumes no rotated parent.
	**/
	function rotateOnWorldAxis(axis:Vector3, angle:Float):Points<TGeometry, TMaterial>;
	/**
		Rotates the object around x axis in local space.
	**/
	function rotateX(angle:Float):Points<TGeometry, TMaterial>;
	/**
		Rotates the object around y axis in local space.
	**/
	function rotateY(angle:Float):Points<TGeometry, TMaterial>;
	/**
		Rotates the object around z axis in local space.
	**/
	function rotateZ(angle:Float):Points<TGeometry, TMaterial>;
	/**
		Translate an object by distance along an axis in object space. The axis is assumed to be normalized.
	**/
	function translateOnAxis(axis:Vector3, distance:Float):Points<TGeometry, TMaterial>;
	/**
		Translates object along x axis by distance.
	**/
	function translateX(distance:Float):Points<TGeometry, TMaterial>;
	/**
		Translates object along y axis by distance.
	**/
	function translateY(distance:Float):Points<TGeometry, TMaterial>;
	/**
		Translates object along z axis by distance.
	**/
	function translateZ(distance:Float):Points<TGeometry, TMaterial>;
	/**
		Adds object as child of this object.
	**/
	function add(object:haxe.extern.Rest<Object3D<Event>>):Points<TGeometry, TMaterial>;
	/**
		Removes object as child of this object.
	**/
	function remove(object:haxe.extern.Rest<Object3D<Event>>):Points<TGeometry, TMaterial>;
	/**
		Removes this object from its current parent.
	**/
	function removeFromParent():Points<TGeometry, TMaterial>;
	/**
		Removes all child objects.
	**/
	function clear():Points<TGeometry, TMaterial>;
	/**
		Adds object as a child of this, while maintaining the object's world transform.
	**/
	function attach(object:Object3D<Event>):Points<TGeometry, TMaterial>;
	function clone(?recursive:Bool):Points<TGeometry, TMaterial>;
	function copy(source:Points<TGeometry, TMaterial>, ?recursive:Bool):Points<TGeometry, TMaterial>;
	/**
		Adds a listener to an event type.
	**/
	function addEventListener<T>(type:T, listener:EventListener<Event, T, Points<TGeometry, TMaterial>>):Void;
	/**
		Checks if listener is added to an event type.
	**/
	function hasEventListener<T>(type:T, listener:EventListener<Event, T, Points<TGeometry, TMaterial>>):Bool;
	/**
		Removes a listener from an event type.
	**/
	function removeEventListener<T>(type:T, listener:EventListener<Event, T, Points<TGeometry, TMaterial>>):Void;
	static var prototype : Points<Dynamic, Dynamic>;
}