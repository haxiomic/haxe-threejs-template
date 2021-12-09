package three;

/**
	Base class for scene graph objects
**/
@:jsRequire("three", "Object3D") extern class Object3D<E> extends EventDispatcher<E> {
	function new();
	/**
		Unique number of this object instance.
	**/
	var id : Float;
	var uuid : String;
	/**
		Optional name of the object (doesn't need to be unique).
	**/
	var name : String;
	var type : String;
	/**
		Object's parent in the scene graph.
	**/
	var parent : Null<Object3D<Event>>;
	/**
		Array with object's children.
	**/
	var children : Array<Object3D<Event>>;
	/**
		Up direction.
	**/
	var up : Vector3;
	/**
		Object's local position.
	**/
	final position : Vector3;
	/**
		Object's local rotation (Euler angles), in radians.
	**/
	final rotation : Euler;
	/**
		Object's local rotation as a Quaternion.
	**/
	final quaternion : Quaternion;
	/**
		Object's local scale.
	**/
	final scale : Vector3;
	final modelViewMatrix : Matrix4;
	final normalMatrix : Matrix3;
	/**
		Local transform.
	**/
	var matrix : Matrix4;
	/**
		The global transform of the object. If the Object3d has no parent, then it's identical to the local transform.
	**/
	var matrixWorld : Matrix4;
	/**
		When this is set, it calculates the matrix of position, (rotation or quaternion) and scale every frame and also
		recalculates the matrixWorld property.
	**/
	var matrixAutoUpdate : Bool;
	/**
		When this is set, it calculates the matrixWorld in that frame and resets this property to false.
	**/
	var matrixWorldNeedsUpdate : Bool;
	var layers : Layers;
	/**
		Object gets rendered if true.
	**/
	var visible : Bool;
	/**
		Gets rendered into shadow map.
	**/
	var castShadow : Bool;
	/**
		Material gets baked in shadow receiving.
	**/
	var receiveShadow : Bool;
	/**
		When this is set, it checks every frame if the object is in the frustum of the camera before rendering the object.
		If set to false the object gets rendered every frame even if it is not in the frustum of the camera.
	**/
	var frustumCulled : Bool;
	/**
		Overrides the default rendering order of scene graph objects, from lowest to highest renderOrder.
		Opaque and transparent objects remain sorted independently though.
		When this property is set for an instance of Group, all descendants objects will be sorted and rendered together.
	**/
	var renderOrder : Float;
	/**
		Array with animation clips.
	**/
	var animations : Array<AnimationClip>;
	/**
		An object that can be used to store custom data about the Object3d. It should not hold references to functions as these will not be cloned.
	**/
	var userData : { };
	/**
		Custom depth material to be used when rendering to the depth map. Can only be used in context of meshes.
		When shadow-casting with a DirectionalLight or SpotLight, if you are (a) modifying vertex positions in
		the vertex shader, (b) using a displacement map, (c) using an alpha map with alphaTest, or (d) using a
		transparent texture with alphaTest, you must specify a customDepthMaterial for proper shadows.
	**/
	var customDepthMaterial : Material;
	/**
		Same as customDepthMaterial, but used with PointLight.
	**/
	var customDistanceMaterial : Material;
	/**
		Used to check whether this or derived classes are Object3Ds. Default is true.
		You should not change this, as it is used internally for optimisation.
	**/
	final isObject3D : Bool;
	/**
		Calls before rendering object
	**/
	dynamic function onBeforeRender(renderer:WebGLRenderer, scene:Scene, camera:Camera, geometry:BufferGeometry, material:Material, group:Group):Void;
	/**
		Calls after rendering object
	**/
	dynamic function onAfterRender(renderer:WebGLRenderer, scene:Scene, camera:Camera, geometry:BufferGeometry, material:Material, group:Group):Void;
	/**
		Applies the matrix transform to the object and updates the object's position, rotation and scale.
	**/
	function applyMatrix4(matrix:Matrix4):Void;
	/**
		Applies the rotation represented by the quaternion to the object.
	**/
	function applyQuaternion(quaternion:Quaternion):Object3D<E>;
	/**
		axis -- A normalized vector in object space.
		angle -- angle in radians
	**/
	function setRotationFromAxisAngle(axis:Vector3, angle:Float):Void;
	/**
		Calls setRotationFromEuler(euler) on the .quaternion.
	**/
	function setRotationFromEuler(euler:Euler):Void;
	/**
		Calls setFromRotationMatrix(m) on the .quaternion.
		
		Note that this assumes that the upper 3x3 of m is a pure rotation matrix (i.e, unscaled).
	**/
	function setRotationFromMatrix(m:Matrix4):Void;
	/**
		Copy the given quaternion into .quaternion.
	**/
	function setRotationFromQuaternion(q:Quaternion):Void;
	/**
		Rotate an object along an axis in object space. The axis is assumed to be normalized.
	**/
	function rotateOnAxis(axis:Vector3, angle:Float):Object3D<E>;
	/**
		Rotate an object along an axis in world space. The axis is assumed to be normalized. Method Assumes no rotated parent.
	**/
	function rotateOnWorldAxis(axis:Vector3, angle:Float):Object3D<E>;
	/**
		Rotates the object around x axis in local space.
	**/
	function rotateX(angle:Float):Object3D<E>;
	/**
		Rotates the object around y axis in local space.
	**/
	function rotateY(angle:Float):Object3D<E>;
	/**
		Rotates the object around z axis in local space.
	**/
	function rotateZ(angle:Float):Object3D<E>;
	/**
		Translate an object by distance along an axis in object space. The axis is assumed to be normalized.
	**/
	function translateOnAxis(axis:Vector3, distance:Float):Object3D<E>;
	/**
		Translates object along x axis by distance.
	**/
	function translateX(distance:Float):Object3D<E>;
	/**
		Translates object along y axis by distance.
	**/
	function translateY(distance:Float):Object3D<E>;
	/**
		Translates object along z axis by distance.
	**/
	function translateZ(distance:Float):Object3D<E>;
	/**
		Updates the vector from local space to world space.
	**/
	function localToWorld(vector:Vector3):Vector3;
	/**
		Updates the vector from world space to local space.
	**/
	function worldToLocal(vector:Vector3):Vector3;
	/**
		Optionally, the x, y and z components of the world space position.
		Rotates the object to face a point in world space.
		This method does not support objects having non-uniformly-scaled parent(s).
	**/
	function lookAt(vector:ts.AnyOf2<Float, Vector3>, ?y:Float, ?z:Float):Void;
	/**
		Adds object as child of this object.
	**/
	function add(object:haxe.extern.Rest<Object3D<Event>>):Object3D<E>;
	/**
		Removes object as child of this object.
	**/
	function remove(object:haxe.extern.Rest<Object3D<Event>>):Object3D<E>;
	/**
		Removes this object from its current parent.
	**/
	function removeFromParent():Object3D<E>;
	/**
		Removes all child objects.
	**/
	function clear():Object3D<E>;
	/**
		Adds object as a child of this, while maintaining the object's world transform.
	**/
	function attach(object:Object3D<Event>):Object3D<E>;
	/**
		Searches through the object's children and returns the first with a matching id.
	**/
	function getObjectById(id:Float):Null<Object3D<Event>>;
	/**
		Searches through the object's children and returns the first with a matching name.
	**/
	function getObjectByName(name:String):Null<Object3D<Event>>;
	function getObjectByProperty(name:String, value:String):Null<Object3D<Event>>;
	function getWorldPosition(target:Vector3):Vector3;
	function getWorldQuaternion(target:Quaternion):Quaternion;
	function getWorldScale(target:Vector3):Vector3;
	function getWorldDirection(target:Vector3):Vector3;
	function raycast(raycaster:Raycaster, intersects:Array<Intersection<Object3D<Event>>>):Void;
	function traverse(callback:(object:Object3D<Event>) -> Dynamic):Void;
	function traverseVisible(callback:(object:Object3D<Event>) -> Dynamic):Void;
	function traverseAncestors(callback:(object:Object3D<Event>) -> Dynamic):Void;
	/**
		Updates local transform.
	**/
	function updateMatrix():Void;
	/**
		Updates global transform of the object and its children.
	**/
	function updateMatrixWorld(?force:Bool):Void;
	/**
		Updates the global transform of the object.
	**/
	function updateWorldMatrix(updateParents:Bool, updateChildren:Bool):Void;
	function toJSON(?meta:{ var geometries : Dynamic; var materials : Dynamic; var textures : Dynamic; var images : Dynamic; }):Dynamic;
	function clone(?recursive:Bool):Object3D<E>;
	function copy(source:Object3D<E>, ?recursive:Bool):Object3D<E>;
	/**
		Adds a listener to an event type.
	**/
	function addEventListener<T>(type:T, listener:EventListener<E, T, Object3D<E>>):Void;
	/**
		Checks if listener is added to an event type.
	**/
	function hasEventListener<T>(type:T, listener:EventListener<E, T, Object3D<E>>):Bool;
	/**
		Removes a listener from an event type.
	**/
	function removeEventListener<T>(type:T, listener:EventListener<E, T, Object3D<E>>):Void;
	static var prototype : Object3D<Dynamic>;
	static var DefaultUp : Vector3;
	static var DefaultMatrixAutoUpdate : Bool;
}