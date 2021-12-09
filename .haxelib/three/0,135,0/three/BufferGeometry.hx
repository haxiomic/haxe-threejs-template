package three;

/**
	This is a superefficent class for geometries because it saves all data in buffers.
	It reduces memory costs and cpu cycles. But it is not as easy to work with because of all the necessary buffer calculations.
	It is mainly interesting when working with static objects.
	
	see {@link https://github.com/mrdoob/three.js/blob/master/src/core/BufferGeometry.js|src/core/BufferGeometry.js}
**/
@:jsRequire("three", "BufferGeometry") extern class BufferGeometry extends EventDispatcher<Event> {
	/**
		This creates a new BufferGeometry. It also sets several properties to an default value.
	**/
	function new();
	/**
		Unique number of this buffergeometry instance
	**/
	var id : Float;
	var uuid : String;
	var name : String;
	var type : String;
	var index : Null<BufferAttribute>;
	var attributes : { };
	var morphAttributes : { };
	var morphTargetsRelative : Bool;
	var groups : Array<{
		var start : Float;
		var count : Float;
		@:optional
		var materialIndex : Float;
	}>;
	var boundingBox : Null<Box3>;
	var boundingSphere : Null<Sphere>;
	var drawRange : {
		var start : Float;
		var count : Float;
	};
	var userData : { };
	final isBufferGeometry : Bool;
	function getIndex():Null<BufferAttribute>;
	function setIndex(index:Null<ts.AnyOf2<Array<Float>, BufferAttribute>>):BufferGeometry;
	function setAttribute(name:ts.AnyOf2<String, Dynamic>, attribute:ts.AnyOf2<BufferAttribute, InterleavedBufferAttribute>):BufferGeometry;
	function getAttribute(name:ts.AnyOf2<String, Dynamic>):ts.AnyOf2<BufferAttribute, InterleavedBufferAttribute>;
	function deleteAttribute(name:ts.AnyOf2<String, Dynamic>):BufferGeometry;
	function hasAttribute(name:ts.AnyOf2<String, Dynamic>):Bool;
	function addGroup(start:Float, count:Float, ?materialIndex:Float):Void;
	function clearGroups():Void;
	function setDrawRange(start:Float, count:Float):Void;
	/**
		Bakes matrix transform directly into vertex coordinates.
	**/
	function applyMatrix4(matrix:Matrix4):BufferGeometry;
	function applyQuaternion(q:Quaternion):BufferGeometry;
	function rotateX(angle:Float):BufferGeometry;
	function rotateY(angle:Float):BufferGeometry;
	function rotateZ(angle:Float):BufferGeometry;
	function translate(x:Float, y:Float, z:Float):BufferGeometry;
	function scale(x:Float, y:Float, z:Float):BufferGeometry;
	function lookAt(v:Vector3):Void;
	function center():BufferGeometry;
	function setFromPoints(points:ts.AnyOf2<Array<Vector3>, Array<Vector2>>):BufferGeometry;
	/**
		Computes bounding box of the geometry, updating Geometry.boundingBox attribute.
		Bounding boxes aren't computed by default. They need to be explicitly computed, otherwise they are null.
	**/
	function computeBoundingBox():Void;
	/**
		Computes bounding sphere of the geometry, updating Geometry.boundingSphere attribute.
		Bounding spheres aren't' computed by default. They need to be explicitly computed, otherwise they are null.
	**/
	function computeBoundingSphere():Void;
	/**
		Computes and adds tangent attribute to this geometry.
	**/
	function computeTangents():Void;
	/**
		Computes vertex normals by averaging face normals.
	**/
	function computeVertexNormals():Void;
	function merge(geometry:BufferGeometry, ?offset:Float):BufferGeometry;
	function normalizeNormals():Void;
	function toNonIndexed():BufferGeometry;
	function toJSON():Dynamic;
	function clone():BufferGeometry;
	function copy(source:BufferGeometry):BufferGeometry;
	/**
		Disposes the object from memory.
		You need to call this when you want the bufferGeometry removed while the application is running.
	**/
	function dispose():Void;
	var drawcalls : Dynamic;
	var offsets : Dynamic;
	function addIndex(index:Dynamic):Void;
	function addDrawCall(start:Dynamic, count:Dynamic, ?indexOffset:Dynamic):Void;
	function clearDrawCalls():Void;
	@:overload(function(name:Dynamic, array:Dynamic, itemSize:Dynamic):Dynamic { })
	function addAttribute(name:String, attribute:ts.AnyOf2<BufferAttribute, InterleavedBufferAttribute>):BufferGeometry;
	function removeAttribute(name:String):BufferGeometry;
	/**
		Adds a listener to an event type.
	**/
	function addEventListener<T>(type:T, listener:EventListener<Event, T, BufferGeometry>):Void;
	/**
		Checks if listener is added to an event type.
	**/
	function hasEventListener<T>(type:T, listener:EventListener<Event, T, BufferGeometry>):Bool;
	/**
		Removes a listener from an event type.
	**/
	function removeEventListener<T>(type:T, listener:EventListener<Event, T, BufferGeometry>):Void;
	static var prototype : BufferGeometry;
	static var MaxIndex : Float;
}