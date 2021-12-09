package three;

@:jsRequire("three", "Skeleton") extern class Skeleton {
	function new(bones:Array<Bone>, ?boneInverses:Array<Matrix4>);
	var uuid : String;
	var bones : Array<Bone>;
	var boneInverses : Array<Matrix4>;
	var boneMatrices : js.lib.Float32Array;
	var boneTexture : Null<DataTexture>;
	var boneTextureSize : Float;
	var frame : Float;
	function init():Void;
	function calculateInverses():Void;
	function computeBoneTexture():Skeleton;
	function pose():Void;
	function update():Void;
	function clone():Skeleton;
	function getBoneByName(name:String):Null<Bone>;
	function dispose():Void;
	var useVertexTexture : Bool;
	static var prototype : Skeleton;
}