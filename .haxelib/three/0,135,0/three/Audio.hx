package three;

@:jsRequire("three", "Audio") extern class Audio<NodeType> extends Object3D<Event> {
	function new(listener:AudioListener);
	var listener : AudioListener;
	var context : js.html.audio.AudioContext;
	var gain : js.html.audio.GainNode;
	var autoplay : Bool;
	var buffer : Null<js.html.audio.AudioBuffer>;
	var detune : Float;
	var loop : Bool;
	var loopStart : Float;
	var loopEnd : Float;
	var offset : Float;
	var duration : Null<Float>;
	var playbackRate : Float;
	var isPlaying : Bool;
	var hasPlaybackControl : Bool;
	var sourceType : String;
	var source : Null<js.html.audio.AudioBufferSourceNode>;
	var filters : Array<js.html.audio.AudioNode>;
	function getOutput():NodeType;
	function setNodeSource(audioNode:js.html.audio.AudioBufferSourceNode):Audio<NodeType>;
	function setMediaElementSource(mediaElement:js.html.MediaElement):Audio<NodeType>;
	function setMediaStreamSource(mediaStream:js.html.MediaStream):Audio<NodeType>;
	function setBuffer(audioBuffer:js.html.audio.AudioBuffer):Audio<NodeType>;
	function play(?delay:Float):Audio<NodeType>;
	function onEnded():Void;
	function pause():Audio<NodeType>;
	function stop():Audio<NodeType>;
	function connect():Audio<NodeType>;
	function disconnect():Audio<NodeType>;
	function setDetune(value:Float):Audio<NodeType>;
	function getDetune():Float;
	function getFilters():Array<js.html.audio.AudioNode>;
	function setFilters(value:Array<js.html.audio.AudioNode>):Audio<NodeType>;
	function getFilter():js.html.audio.AudioNode;
	function setFilter(filter:js.html.audio.AudioNode):Audio<NodeType>;
	function setPlaybackRate(value:Float):Audio<NodeType>;
	function getPlaybackRate():Float;
	function getLoop():Bool;
	function setLoop(value:Bool):Audio<NodeType>;
	function setLoopStart(value:Float):Audio<NodeType>;
	function setLoopEnd(value:Float):Audio<NodeType>;
	function getVolume():Float;
	function setVolume(value:Float):Audio<NodeType>;
	function load(file:String):Audio<js.html.audio.GainNode>;
	/**
		Applies the rotation represented by the quaternion to the object.
	**/
	function applyQuaternion(quaternion:Quaternion):Audio<NodeType>;
	/**
		Rotate an object along an axis in object space. The axis is assumed to be normalized.
	**/
	function rotateOnAxis(axis:Vector3, angle:Float):Audio<NodeType>;
	/**
		Rotate an object along an axis in world space. The axis is assumed to be normalized. Method Assumes no rotated parent.
	**/
	function rotateOnWorldAxis(axis:Vector3, angle:Float):Audio<NodeType>;
	/**
		Rotates the object around x axis in local space.
	**/
	function rotateX(angle:Float):Audio<NodeType>;
	/**
		Rotates the object around y axis in local space.
	**/
	function rotateY(angle:Float):Audio<NodeType>;
	/**
		Rotates the object around z axis in local space.
	**/
	function rotateZ(angle:Float):Audio<NodeType>;
	/**
		Translate an object by distance along an axis in object space. The axis is assumed to be normalized.
	**/
	function translateOnAxis(axis:Vector3, distance:Float):Audio<NodeType>;
	/**
		Translates object along x axis by distance.
	**/
	function translateX(distance:Float):Audio<NodeType>;
	/**
		Translates object along y axis by distance.
	**/
	function translateY(distance:Float):Audio<NodeType>;
	/**
		Translates object along z axis by distance.
	**/
	function translateZ(distance:Float):Audio<NodeType>;
	/**
		Adds object as child of this object.
	**/
	function add(object:haxe.extern.Rest<Object3D<Event>>):Audio<NodeType>;
	/**
		Removes object as child of this object.
	**/
	function remove(object:haxe.extern.Rest<Object3D<Event>>):Audio<NodeType>;
	/**
		Removes this object from its current parent.
	**/
	function removeFromParent():Audio<NodeType>;
	/**
		Removes all child objects.
	**/
	function clear():Audio<NodeType>;
	/**
		Adds object as a child of this, while maintaining the object's world transform.
	**/
	function attach(object:Object3D<Event>):Audio<NodeType>;
	function clone(?recursive:Bool):Audio<NodeType>;
	function copy(source:Audio<NodeType>, ?recursive:Bool):Audio<NodeType>;
	/**
		Adds a listener to an event type.
	**/
	function addEventListener<T>(type:T, listener:EventListener<Event, T, Audio<NodeType>>):Void;
	/**
		Checks if listener is added to an event type.
	**/
	function hasEventListener<T>(type:T, listener:EventListener<Event, T, Audio<NodeType>>):Bool;
	/**
		Removes a listener from an event type.
	**/
	function removeEventListener<T>(type:T, listener:EventListener<Event, T, Audio<NodeType>>):Void;
	static var prototype : Audio<Dynamic>;
}