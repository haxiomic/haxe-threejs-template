package three;

@:jsRequire("three", "WebGLGeometries") extern class WebGLGeometries {
	function new(gl:js.html.webgl.RenderingContext, attributes:three.src.renderers.webgl.webglattributes.WebGLAttributes, info:WebGLInfo);
	function get(object:Object3D<Event>, geometry:BufferGeometry):BufferGeometry;
	function update(geometry:BufferGeometry):Void;
	function getWireframeAttribute(geometry:BufferGeometry):BufferAttribute;
	static var prototype : WebGLGeometries;
}