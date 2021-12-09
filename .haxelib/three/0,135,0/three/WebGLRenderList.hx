package three;

@:jsRequire("three", "WebGLRenderList") extern class WebGLRenderList {
	function new(properties:WebGLProperties);
	var opaque : Array<RenderItem>;
	var transparent : Array<RenderItem>;
	var transmissive : Array<RenderItem>;
	function init():Void;
	function push(object:Object3D<Event>, geometry:Null<BufferGeometry>, material:Material, groupOrder:Float, z:Float, group:Null<Group>):Void;
	function unshift(object:Object3D<Event>, geometry:Null<BufferGeometry>, material:Material, groupOrder:Float, z:Float, group:Null<Group>):Void;
	function sort(opaqueSort:(a:Dynamic, b:Dynamic) -> Float, transparentSort:(a:Dynamic, b:Dynamic) -> Float):Void;
	function finish():Void;
	static var prototype : WebGLRenderList;
}