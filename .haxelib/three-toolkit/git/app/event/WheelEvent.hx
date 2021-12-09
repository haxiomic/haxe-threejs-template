package app.event;

/**
	See https://developer.mozilla.org/en-US/docs/Web/API/WheelEvent
**/
@:publicFields
@:structInit
@:unreflective
#if cpp @:keep #end
class WheelEvent {

	/**
		The horizontal scroll amount in **points**, if scrolling a page this corresponds to the horizontal scroll distance that would be applied
	**/
	final deltaX: Float;

	/**
		The vertical scroll amount in **points**, if scrolling a page this corresponds to the vertical scroll distance that would be applied
	**/
	final deltaY: Float;

	/**
		Z-axis scroll amount (and 0 when unsupported)
	**/
	final deltaZ: Float;

	/**
		Horizontal position in units of **points** where 0 corresponds to the left of the view
	**/
	final x: Float;

	/**
		Vertical position in units of **points** where 0 corresponds to the top of the view
	**/
	final y: Float;

	// The motivation for supplying special-key state with the wheel event (when it can also be obtained from keyboard events) is to catch state when the document is not focused
	// for example, you mouse wheel on a page without the document focused keyboard events will not fire but special-key state will still be available in this event

	final altKey: Bool;
	final ctrlKey: Bool;
	final metaKey: Bool;
	final shiftKey: Bool;

	/**
		Reference to original native event object – type varies between platform
	**/
	final nativeEvent: #if js js.html.WheelEvent #else Dynamic #end;

}