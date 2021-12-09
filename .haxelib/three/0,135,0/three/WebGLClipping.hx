package three;

@:jsRequire("three", "WebGLClipping") extern class WebGLClipping {
	function new(properties:WebGLProperties);
	var uniform : {
		var value : Dynamic;
		var needsUpdate : Bool;
	};
	var numPlanes : Float;
	var numIntersection : Float;
	function init(planes:Array<Dynamic>, enableLocalClipping:Bool, camera:Camera):Bool;
	function beginShadows():Void;
	function endShadows():Void;
	function setState(material:Material, camera:Camera, useCache:Bool):Void;
	static var prototype : WebGLClipping;
}