package three;

@:jsRequire("three", "AnimationClip") extern class AnimationClip {
	function new(?name:String, ?duration:Float, ?tracks:Array<KeyframeTrack>, ?blendMode:AnimationBlendMode);
	var name : String;
	var tracks : Array<KeyframeTrack>;
	var blendMode : AnimationBlendMode;
	var duration : Float;
	var uuid : String;
	var results : Array<Dynamic>;
	function resetDuration():AnimationClip;
	function trim():AnimationClip;
	function validate():Bool;
	function optimize():AnimationClip;
	function clone():AnimationClip;
	function toJSON(clip:AnimationClip):Dynamic;
	static var prototype : AnimationClip;
	static function CreateFromMorphTargetSequence(name:String, morphTargetSequence:Array<MorphTarget>, fps:Float, noLoop:Bool):AnimationClip;
	static function findByName(clipArray:Array<AnimationClip>, name:String):AnimationClip;
	static function CreateClipsFromMorphTargetSequences(morphTargets:Array<MorphTarget>, fps:Float, noLoop:Bool):Array<AnimationClip>;
	static function parse(json:Dynamic):AnimationClip;
	static function parseAnimation(animation:Dynamic, bones:Array<Bone>):AnimationClip;
	@:native("toJSON")
	static function toJSON_(clip:AnimationClip):Dynamic;
}