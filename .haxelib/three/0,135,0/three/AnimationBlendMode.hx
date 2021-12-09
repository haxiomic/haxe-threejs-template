package three;

@:enum @:jsRequire("three") extern abstract AnimationBlendMode(Int) from Int to Int {
	final NormalAnimationBlendMode : AnimationBlendMode;
	final AdditiveAnimationBlendMode : AnimationBlendMode;
}