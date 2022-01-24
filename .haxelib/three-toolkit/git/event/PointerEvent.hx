package event;

/**
 * Bit offsets for buttons state bit mask
 * See https://www.w3.org/TR/pointerevents/#the-buttons-property
 */
enum abstract ButtonChange(Int) to Int from Int {

	final Nothing = -1;

	/**
	 * left mouse / touch contact
	 */
	final Primary = 0;

	final MiddleMouse = 1;
	
	/**
	 * right mouse / pen-barrel
	 */
	final Secondary = 2;

	/**
	 * X1 / back mouse
	 */
	final Back = 3;

	/**
	 * X2 / forward mouse
	 */
	final Forward = 4;

	final PenEraser = 5;
	
}

/**
	See https://www.w3.org/TR/pointerevents
**/
@:publicFields
@:structInit
@:unreflective
#if cpp @:keep #end
class PointerEvent extends PointerState {

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
	final button: ButtonChange;

	final preventDefault: () -> Void;
	final defaultPrevented: () -> Bool;
	
	final timeStamp: Float;

	/**
		Reference to original native event object – type varies between platform
		Could be PointerEvent, MouseEvent or TouchEvent on js
	**/
	final nativeEvent: #if js js.html.Event #else Dynamic #end;

}