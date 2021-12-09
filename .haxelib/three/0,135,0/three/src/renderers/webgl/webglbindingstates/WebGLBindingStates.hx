package three.src.renderers.webgl.webglbindingstates;

@:jsRequire("three/src/renderers/webgl/WebGLBindingStates", "WebGLBindingStates") extern class WebGLBindingStates {
	function new(gl:js.html.webgl.RenderingContext, extensions:three.WebGLExtensions, attributes:three.src.renderers.webgl.webglattributes.WebGLAttributes, capabilities:three.WebGLCapabilities);
	function setup(object:three.Object3D<three.Event>, material:three.Material, program:three.WebGLProgram, geometry:three.BufferGeometry, index:three.BufferAttribute):Void;
	function reset():Void;
	function resetDefaultState():Void;
	function dispose():Void;
	function releaseStatesOfGeometry():Void;
	function releaseStatesOfProgram():Void;
	function initAttributes():Void;
	function enableAttribute(attribute:Float):Void;
	function disableUnusedAttributes():Void;
	static var prototype : WebGLBindingStates;
}