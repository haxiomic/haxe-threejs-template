package app;

import app.event.*;

/**
	**Units**
	- `points` - Abstract length units independent of the display's physical pixel density. All coordinates and dimensions in this API are given in units of `points`. In UIKit this maps the `points` unit, in Android the `density independent pixel` and in HTML it maps to the `px` unit
	- `pixels` - Corresponds to individually addressable values in a texture or display
	
	See [iOS Documentation: Points Verses Pixels](https://developer.apple.com/library/archive/documentation/2DDrawing/Conceptual/DrawingPrintingiOS/GraphicsDrawingOverview/GraphicsDrawingOverview.html#//apple_ref/doc/uid/TP40010156-CH14-SW7)
	**Input**
	Generally input events follow the latest browser input event specifications, however there are small differences, for example: to prevent the platform's default handling for an event, return `true` from an event handling method
	- For mouse, touch and pen input, an interface that closely follows the PointerEvent API is used
	- Wheel events mirror browser [WheelEvent](https://developer.mozilla.org/en-US/docs/Web/API/WheelEvent) where all deltas are in units of **points**, normalizing for `deltaMode`
	- KeyboardEvents mirror browser [KeyboardEvent](https://w3c.github.io/uievents/#idl-keyboardevent) with an extra parameter `hasFocus` to detect if the view is focused for the event
**/
interface InteractionEventsHandler {

	/**
		- Called once after the view has been created
		- Called _after_ the view has been resized
		- `width` and `height` are in units of **points**
	**/
	function onResize(width: Float, height: Float): Void;
	
	/**
		Called when a pointer (mouse, touch or pen) is activated, for a mouse this happens when a button is pressed.
		Return true to prevent default behavior.
		See https://www.w3.org/TR/pointerevents/#the-pointerdown-event
	**/
	function onPointerDown(event: PointerEvent): EventResponse;

	/**
		Called when an active pointer changes either position or pressure (if supported).
		This is called when a cursor moves, whether or not any buttons are down.
		Return true to prevent default behavior.
		See https://www.w3.org/TR/pointerevents/#the-pointermove-event
	**/
	function onPointerMove(event: PointerEvent): EventResponse;

	/**
		Called when a pointer (mouse, touch or pen) is activated, for a mouse this happens when a button is released.
		Return true to prevent default behavior.
		See https://www.w3.org/TR/pointerevents/#the-pointerup-event
	**/
	function onPointerUp(event: PointerEvent): EventResponse;

	/**
		Called when the pointer is unlikely to continue to produce events or the interaction was interrupted by a gesture recognition.
		Return true to prevent default behavior.
		See https://www.w3.org/TR/pointerevents/#the-pointercancel-event
	**/
	function onPointerCancel(event: PointerEvent): EventResponse;

	/**
		Called when a scroll interaction is performed on the view.
		Return true to prevent default behavior.
		If `ctrlKey` is true, the event can be assumed to be a pinch gesture on a trackpad.
	**/
	function onWheel(event: WheelEvent): EventResponse;

	/**
		Called when a key is pressed down with the view focused.
		Return true to prevent default behavior.
		`hasFocus` is true if our view has input focus for the event. For `hasFocus` to be correct the canvas needs to be focusable. This requires setting the `tabIndex` attribute on the canvas
	**/
	function onKeyDown(event: KeyboardEvent, hasFocus: Bool): EventResponse;

	/**
		Called when a key is released with the view focused.
		Return true to prevent default behavior.
		`hasFocus` is true if our view has input focus for the event. For `hasFocus` to be correct the canvas needs to be focusable. This requires setting the `tabIndex` attribute on the canvas
	**/
	function onKeyUp(event: KeyboardEvent, hasFocus: Bool): EventResponse;

	/**
		Called when the haxe view goes from a deactivated state (hidden view, minimized tab, background-mode app) to a foreground active state.
		For example, you should use this event to resume activities and connect to sensor events.
		This method is called as early as possible in the transition and the view may not yet be visible.
		**It is called once at startup.**
	**/
	function onActivate(): Void;

	/**
		Called before the app transitions into a deactivated state (hidden view, minimized tab, background-mode app).
		For example you should use this event to suspend activities to save power, pause a game, save state or disconnect from sensors.
		This method is called as early as possible in the transition and the view may still be visible.
	**/
	function onDeactivate(): Void;

}