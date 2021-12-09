package three;

@:jsRequire("three", "SpotLightHelper") extern class SpotLightHelper extends Object3D<Event> {
	function new(light:Light, ?color:ColorRepresentation);
	var light : Light;
	var color : Null<ColorRepresentation>;
	var cone : LineSegments<BufferGeometry, ts.AnyOf2<Material, Array<Material>>>;
	function dispose():Void;
	function update():Void;
	/**
		Applies the rotation represented by the quaternion to the object.
	**/
	function applyQuaternion(quaternion:Quaternion):SpotLightHelper;
	/**
		Rotate an object along an axis in object space. The axis is assumed to be normalized.
	**/
	function rotateOnAxis(axis:Vector3, angle:Float):SpotLightHelper;
	/**
		Rotate an object along an axis in world space. The axis is assumed to be normalized. Method Assumes no rotated parent.
	**/
	function rotateOnWorldAxis(axis:Vector3, angle:Float):SpotLightHelper;
	/**
		Rotates the object around x axis in local space.
	**/
	function rotateX(angle:Float):SpotLightHelper;
	/**
		Rotates the object around y axis in local space.
	**/
	function rotateY(angle:Float):SpotLightHelper;
	/**
		Rotates the object around z axis in local space.
	**/
	function rotateZ(angle:Float):SpotLightHelper;
	/**
		Translate an object by distance along an axis in object space. The axis is assumed to be normalized.
	**/
	function translateOnAxis(axis:Vector3, distance:Float):SpotLightHelper;
	/**
		Translates object along x axis by distance.
	**/
	function translateX(distance:Float):SpotLightHelper;
	/**
		Translates object along y axis by distance.
	**/
	function translateY(distance:Float):SpotLightHelper;
	/**
		Translates object along z axis by distance.
	**/
	function translateZ(distance:Float):SpotLightHelper;
	/**
		Adds object as child of this object.
	**/
	function add(object:haxe.extern.Rest<Object3D<Event>>):SpotLightHelper;
	/**
		Removes object as child of this object.
	**/
	function remove(object:haxe.extern.Rest<Object3D<Event>>):SpotLightHelper;
	/**
		Removes this object from its current parent.
	**/
	function removeFromParent():SpotLightHelper;
	/**
		Removes all child objects.
	**/
	function clear():SpotLightHelper;
	/**
		Adds object as a child of this, while maintaining the object's world transform.
	**/
	function attach(object:Object3D<Event>):SpotLightHelper;
	function clone(?recursive:Bool):SpotLightHelper;
	function copy(source:SpotLightHelper, ?recursive:Bool):SpotLightHelper;
	/**
		Adds a listener to an event type.
	**/
	function addEventListener<T>(type:T, listener:EventListener<Event, T, SpotLightHelper>):Void;
	/**
		Checks if listener is added to an event type.
	**/
	function hasEventListener<T>(type:T, listener:EventListener<Event, T, SpotLightHelper>):Bool;
	/**
		Removes a listener from an event type.
	**/
	function removeEventListener<T>(type:T, listener:EventListener<Event, T, SpotLightHelper>):Void;
	static var prototype : SpotLightHelper;
}