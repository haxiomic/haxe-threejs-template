package three;

/**
	see {@link https://github.com/mrdoob/three.js/blob/master/examples/jsm/utils/BufferGeometryUtils.js|examples/jsm/utils/BufferGeometryUtils.js}
**/
@:jsRequire("three", "BufferGeometryUtils") @valueModuleOnly extern class BufferGeometryUtils {
	static function mergeBufferGeometries(geometries:Array<BufferGeometry>):BufferGeometry;
	static function computeTangents(geometry:BufferGeometry):Dynamic;
	static function mergeBufferAttributes(attributes:Array<BufferAttribute>):BufferAttribute;
}