package three;

@:jsRequire("three", "Raycaster") extern class Raycaster {
	/**
		This creates a new raycaster object.
	**/
	function new(?origin:Vector3, ?direction:Vector3, ?near:Float, ?far:Float);
	/**
		The Ray used for the raycasting.
	**/
	var ray : Ray;
	/**
		The near factor of the raycaster. This value indicates which objects can be discarded based on the
		distance. This value shouldn't be negative and should be smaller than the far property.
	**/
	var near : Float;
	/**
		The far factor of the raycaster. This value indicates which objects can be discarded based on the
		distance. This value shouldn't be negative and should be larger than the near property.
	**/
	var far : Float;
	/**
		The camera to use when raycasting against view-dependent objects such as billboarded objects like Sprites. This field
		can be set manually or is set when calling "setFromCamera".
	**/
	var camera : Camera;
	/**
		Used by Raycaster to selectively ignore 3D objects when performing intersection tests.
	**/
	var layers : Layers;
	var params : RaycasterParameters;
	/**
		Updates the ray with a new origin and direction.
	**/
	function set(origin:Vector3, direction:Vector3):Void;
	/**
		Updates the ray with a new origin and direction.
	**/
	function setFromCamera(coords:{ var x : Float; var y : Float; }, camera:Camera):Void;
	/**
		Checks all intersection between the ray and the object with or without the descendants. Intersections are returned sorted by distance, closest first.
	**/
	function intersectObject<TIntersected>(object:Object3D<Event>, ?recursive:Bool, ?optionalTarget:Array<Intersection<TIntersected>>):Array<Intersection<TIntersected>>;
	/**
		Checks all intersection between the ray and the objects with or without the descendants.
		Intersections are returned sorted by distance, closest first.
		Intersections are of the same form as those returned by .intersectObject.
	**/
	function intersectObjects<TIntersected>(objects:Array<Object3D<Event>>, ?recursive:Bool, ?optionalTarget:Array<Intersection<TIntersected>>):Array<Intersection<TIntersected>>;
	static var prototype : Raycaster;
}