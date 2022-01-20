package event;

@:publicFields
@:structInit
@:unreflective
class PointerState {

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
		Current state of the pointer's buttons as a bitmask.
		See https://www.w3.org/TR/pointerevents/#the-buttons-property
	**/
	var buttons: ButtonState;

	/**
		Horizontal position in units of **points** where 0 corresponds to the left of the view
	**/
	var x: Float;

	/**
		Vertical position in units of **points** where 0 corresponds to the top of the view
	**/
	var y: Float;

	/**
		Horizontal dimension in units of **points** for inputs with a contact size (defaults to 1 for point-like inputs)
	**/
	var width: Float;

	/**
		Vertical dimension in units of **points** for inputs with a contact size (defaults to 1 for point-like inputs)
	**/
	var height: Float;

	/**
		Width of view where the event occurred in **points** units
	**/
	var viewWidth: Float;

	/**
		Height of view where the event occurred in **points** units
	**/
	var viewHeight: Float;

	/**
		Normalized pressure ranging from 0 to 1. For hardware that does not support pressure this value will be 0.5.
		See https://www.w3.org/TR/pointerevents/#dom-pointerevent-pressure
	**/
	var pressure: Float;

	/**
		See https://www.w3.org/TR/pointerevents/#dom-pointerevent-tangentialpressure
	**/
	var tangentialPressure: Float;

	/**
		Pen tilt in the horizontal direction in units of **degrees**, ranging from -90 to 90.
		See https://www.w3.org/TR/pointerevents/#dom-pointerevent-tiltx
	**/
	var tiltX: Float;

	/**
		Pen tilt in the vertical direction in units of **degrees**, ranging from -90 to 90.
		See https://www.w3.org/TR/pointerevents/#dom-pointerevent-tilty
	**/
	var tiltY: Float;

	/**
		Clockwise rotation in units of **degrees** (see `rotationAngle` for touches https://w3c.github.io/touch-events/#dom-touch-rotationangle)
	**/
	var twist: Float;

}

enum abstract PointerType(String) to String from String {
	var MOUSE = "mouse";
	var PEN = "pen";
	var TOUCH = "touch";
}

/**
 * Bit offsets for buttons state bit mask
 * See https://www.w3.org/TR/pointerevents/#the-buttons-property
 */
enum abstract Button(Int) to Int from Int {

	/**
	 * left mouse / touch contact
	 */
	final Primary = 1 << 0;
	
	/**
	 * right mouse / pen-barrel
	 */
	final Secondary = 1 << 1;

	final MiddleMouse = 1;

	/**
	 * X1 / back mouse
	 */
	final Back = 1 << 3;

	/**
	 * X2 / forward mouse
	 */
	final Forward = 1 << 4;

	final PenEraser = 1 << 5;
	
}

abstract ButtonState(Int) to Int from Int {

	public inline function isDown(button: Button) {
		return this & button != 0;
	}

	/** No buttons pressed */
	public inline function isEmpty() {
		return this == 0;
	}

}
