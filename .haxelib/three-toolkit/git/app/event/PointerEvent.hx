package app.event;

/**
	See https://www.w3.org/TR/pointerevents
**/
@:publicFields
@:structInit
@:unreflective
#if cpp @:keep #end
class PointerEvent {

	/**
		Unique identifier for the pointer.
		See https://www.w3.org/TR/pointerevents/#dom-pointerevent-pointerid
	**/
	final pointerId: Int;

	/**
		See https://www.w3.org/TR/pointerevents/#dom-pointerevent-pointertype
	**/
	final pointerType: PointerType;

	/**
		See https://www.w3.org/TR/pointerevents/#dfn-primary-pointer
	**/
	final isPrimary: Bool;

	/**
		Indicates button who's state-change caused the event
		- `-1` - no buttons changed since the last event
		- `0` - left mouse button or touch/pen contact
		- `1` - middle mouse button
		- `2` - right mouse button or pen barrel button
		- `3` - mouse back button
		- `4` - mouse forward button
		- `5` - pen eraser button

		See https://www.w3.org/TR/pointerevents/#the-button-property
	**/
	final button: Int;

	/**
		Current state of the pointer's buttons as a bitmask.
		See https://www.w3.org/TR/pointerevents/#the-buttons-property
	**/
	final buttons: Int;

	/**
		Horizontal position in units of **points** where 0 corresponds to the left of the view
	**/
	final x: Float;

	/**
		Vertical position in units of **points** where 0 corresponds to the top of the view
	**/
	final y: Float;
	
	/**
		Horizontal dimension in units of **points** for inputs with a contact size (defaults to 1 for point-like inputs)
	**/
	final width: Float;

	/**
		Vertical dimension in units of **points** for inputs with a contact size (defaults to 1 for point-like inputs)
	**/
	final height: Float;

	/**
		Width of view where the event occurred in **points** units
	**/
	final viewWidth: Float;

	/**
		Height of view where the event occurred in **points** units
	**/
	final viewHeight: Float;

	/**
		Normalized pressure ranging from 0 to 1. For hardware that does not support pressure this value will be 0.5.
		See https://www.w3.org/TR/pointerevents/#dom-pointerevent-pressure
	**/
	final pressure: Float;

	/**
		See https://www.w3.org/TR/pointerevents/#dom-pointerevent-tangentialpressure
	**/
	final tangentialPressure: Float;

	/**
		Pen tilt in the horizontal direction in units of **degrees**, ranging from -90 to 90.
		See https://www.w3.org/TR/pointerevents/#dom-pointerevent-tiltx
	**/
	final tiltX: Float;

	/**
		Pen tilt in the vertical direction in units of **degrees**, ranging from -90 to 90.
		See https://www.w3.org/TR/pointerevents/#dom-pointerevent-tilty
	**/
	final tiltY: Float;

	/**
		Clockwise rotation in units of **degrees** (see `rotationAngle` for touches https://w3c.github.io/touch-events/#dom-touch-rotationangle)
	**/
	final twist: Float;

}