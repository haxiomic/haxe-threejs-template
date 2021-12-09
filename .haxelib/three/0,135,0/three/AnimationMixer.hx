package three;

@:jsRequire("three", "AnimationMixer") extern class AnimationMixer extends EventDispatcher<Event> {
	function new(root:ts.AnyOf2<AnimationObjectGroup, Object3D<Event>>);
	var time : Float;
	var timeScale : Float;
	function clipAction(clip:AnimationClip, ?root:ts.AnyOf2<AnimationObjectGroup, Object3D<Event>>, ?blendMode:AnimationBlendMode):AnimationAction;
	function existingAction(clip:AnimationClip, ?root:ts.AnyOf2<AnimationObjectGroup, Object3D<Event>>):Null<AnimationAction>;
	function stopAllAction():AnimationMixer;
	function update(deltaTime:Float):AnimationMixer;
	function setTime(timeInSeconds:Float):AnimationMixer;
	function getRoot():ts.AnyOf2<AnimationObjectGroup, Object3D<Event>>;
	function uncacheClip(clip:AnimationClip):Void;
	function uncacheRoot(root:ts.AnyOf2<AnimationObjectGroup, Object3D<Event>>):Void;
	function uncacheAction(clip:AnimationClip, ?root:ts.AnyOf2<AnimationObjectGroup, Object3D<Event>>):Void;
	/**
		Adds a listener to an event type.
	**/
	function addEventListener<T>(type:T, listener:EventListener<Event, T, AnimationMixer>):Void;
	/**
		Checks if listener is added to an event type.
	**/
	function hasEventListener<T>(type:T, listener:EventListener<Event, T, AnimationMixer>):Bool;
	/**
		Removes a listener from an event type.
	**/
	function removeEventListener<T>(type:T, listener:EventListener<Event, T, AnimationMixer>):Void;
	static var prototype : AnimationMixer;
}