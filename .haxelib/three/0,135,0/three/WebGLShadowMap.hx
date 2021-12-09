package three;

@:jsRequire("three", "WebGLShadowMap") extern class WebGLShadowMap {
	function new(_renderer:WebGLRenderer, _objects:WebGLObjects, _capabilities:WebGLCapabilities);
	var enabled : Bool;
	var autoUpdate : Bool;
	var needsUpdate : Bool;
	var type : ShadowMapType;
	function render(shadowsArray:Array<Light>, scene:Scene, camera:Camera):Void;
	var cullFace : Dynamic;
	static var prototype : WebGLShadowMap;
}