package three;

@:jsRequire("three", "DirectionalLightHelper") extern class DirectionalLightHelper extends Object3D<Event> {
	function new(light:DirectionalLight, ?size:Float, ?color:ColorRepresentation);
	var light : DirectionalLight;
	var lightPlane : Line<BufferGeometry, ts.AnyOf2<Material, Array<Material>>>;
	var targetLine : Line<BufferGeometry, ts.AnyOf2<Material, Array<Material>>>;
	var color : Null<ColorRepresentation>;
	function dispose():Void;
	function update():Void;
	/**
		Applies the rotation represented by the quaternion to the object.
	**/
	function applyQuaternion(quaternion:Quaternion):DirectionalLightHelper;
	/**
		Rotate an object along an axis in object space. The axis is assumed to be normalized.
	**/
	function rotateOnAxis(axis:Vector3, angle:Float):DirectionalLightHelper;
	/**
		Rotate an object along an axis in world space. The axis is assumed to be normalized. Method Assumes no rotated parent.
	**/
	function rotateOnWorldAxis(axis:Vector3, angle:Float):DirectionalLightHelper;
	/**
		Rotates the object around x axis in local space.
	**/
	function rotateX(angle:Float):DirectionalLightHelper;
	/**
		Rotates the object around y axis in local space.
	**/
	function rotateY(angle:Float):DirectionalLightHelper;
	/**
		Rotates the object around z axis in local space.
	**/
	function rotateZ(angle:Float):DirectionalLightHelper;
	/**
		Translate an object by distance along an axis in object space. The axis is assumed to be normalized.
	**/
	function translateOnAxis(axis:Vector3, distance:Float):DirectionalLightHelper;
	/**
		Translates object along x axis by distance.
	**/
	function translateX(distance:Float):DirectionalLightHelper;
	/**
		Translates object along y axis by distance.
	**/
	function translateY(distance:Float):DirectionalLightHelper;
	/**
		Translates object along z axis by distance.
	**/
	function translateZ(distance:Float):DirectionalLightHelper;
	/**
		Adds object as child of this object.
	**/
	function add(object:haxe.extern.Rest<Object3D<Event>>):DirectionalLightHelper;
	/**
		Removes object as child of this object.
	**/
	function remove(object:haxe.extern.Rest<Object3D<Event>>):DirectionalLightHelper;
	/**
		Removes this object from its current parent.
	**/
	function removeFromParent():DirectionalLightHelper;
	/**
		Removes all child objects.
	**/
	function clear():DirectionalLightHelper;
	/**
		Adds object as a child of this, while maintaining the object's world transform.
	**/
	function attach(object:Object3D<Event>):DirectionalLightHelper;
	function clone(?recursive:Bool):DirectionalLightHelper;
	function copy(source:DirectionalLightHelper, ?recursive:Bool):DirectionalLightHelper;
	/**
		Adds a listener to an event type.
	**/
	function addEventListener<T>(type:T, listener:EventListener<Event, T, DirectionalLightHelper>):Void;
	/**
		Checks if listener is added to an event type.
	**/
	function hasEventListener<T>(type:T, listener:EventListener<Event, T, DirectionalLightHelper>):Bool;
	/**
		Removes a listener from an event type.
	**/
	function removeEventListener<T>(type:T, listener:EventListener<Event, T, DirectionalLightHelper>):Void;
	static var prototype : DirectionalLightHelper;
}