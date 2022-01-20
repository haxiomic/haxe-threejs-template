package event;
import js.Browser.*;
import js.html.Element;
import js.html.KeyboardEvent;
import js.html.MouseEvent;
import js.html.TouchEvent;
import js.html.WheelEvent;

/**
	**Units**
	- `points` - Abstract length units independent of the display's physical pixel density. All coordinates and dimensions in this API are given in units of `points`. In UIKit this maps the `points` unit, in Android the `density independent pixel` and in HTML it maps to the `px` unit
	- `pixels` - Corresponds to individually addressable values in a texture or display
	
	See [iOS Documentation: Points Verses Pixels](https://developer.apple.com/library/archive/documentation/2DDrawing/Conceptual/DrawingPrintingiOS/GraphicsDrawingOverview/GraphicsDrawingOverview.html#//apple_ref/doc/uid/TP40010156-CH14-SW7)
	**Input**
	Generally input events follow the latest browser input event specifications, however there are small differences
	- For mouse, touch and pen input, an interface that closely follows the PointerEvent API is used
	- Wheel events mirror browser [WheelEvent](https://developer.mozilla.org/en-US/docs/Web/API/WheelEvent) where all deltas are in units of **points**, normalizing for `deltaMode`
	- KeyboardEvents mirror browser [KeyboardEvent](https://w3c.github.io/uievents/#idl-keyboardevent) with an extra parameter `hasFocus` to detect if the view is focused for the event
**/
@:nullSafety
class ViewEventManager {
	
	public final el: Element;
	// current pointer state
	public final activePointers = new Map<Int, event.PointerState>();
	public var activePointerCount(default, null) = 0;

	final eventHandler: EventDispatcher;


	public function new(el: Element) {
		this.el = el;
		this.eventHandler = new EventDispatcher();

		if (el.tabIndex == null) {
			// make the el focusable
			// this enables us to determine if our el has focus when receiving key events
			el.tabIndex = 1;
		}

		// disable default touch actions, this helps disable view dragging on touch devices
		el.style.touchAction = 'none';
		el.setAttribute('touch-action', 'none');
		// prevent native touch-scroll
		function cancelEvent(e) {
			e.preventDefault();
			e.stopPropagation();
		}
		el.addEventListener('gesturestart', cancelEvent, false);
		el.addEventListener('gesturechange', cancelEvent, false);
		// el.addEventListener('scroll', cancelEvent); need to experiment

		// attach interaction event listeners
		addPointerEventListeners();
		addWheelEventListeners();
		addKeyboardEventListeners();
		addLifeCycleEventListeners();

		// startup life-cycle event
		onVisibilityChange();
	}
	
	/**
		Callback is triggered when a pointer (mouse, touch or pen) is activated, for a mouse this happens when a button is pressed.
		Return true to prevent default behavior.
		See https://www.w3.org/TR/pointerevents/#the-pointerdown-event
	**/
	public inline function onPointerDown(cb: PointerEvent -> Void) {
		eventHandler.onPointerDownCallbacks.push(cb);
		return { remove: () -> eventHandler.onPointerDownCallbacks.remove(cb) }
	}

	/**
		Callback is triggered when an active pointer changes either position or pressure (if supported).
		This is called when a cursor moves, whether or not any buttons are down.
		Return true to prevent default behavior.
		See https://www.w3.org/TR/pointerevents/#the-pointermove-event
	**/
	public inline function onPointerMove(cb: PointerEvent -> Void) {
		eventHandler.onPointerMoveCallbacks.push(cb);
		return { remove: () -> eventHandler.onPointerMoveCallbacks.remove(cb) }
	}

	/**
		Callback is triggered when a pointer (mouse, touch or pen) is activated, for a mouse this happens when a button is released.
		Return true to prevent default behavior.
		See https://www.w3.org/TR/pointerevents/#the-pointerup-event
	**/
	public inline function onPointerUp(cb: PointerEvent -> Void) {
		eventHandler.onPointerUpCallbacks.push(cb);
		return { remove: () -> eventHandler.onPointerUpCallbacks.remove(cb) }
	}

	/**
		Callback is triggered when the pointer is unlikely to continue to produce events or the interaction was interrupted by a gesture recognition.
		Return true to prevent default behavior.
		See https://www.w3.org/TR/pointerevents/#the-pointercancel-event
	**/
	public inline function onPointerCancel(cb: PointerEvent -> Void) {
		eventHandler.onPointerCancelCallbacks.push(cb);
		return { remove: () -> eventHandler.onPointerCancelCallbacks.remove(cb) }
	}

	/**
		Callback is triggered when a scroll interaction is performed on the view.
		Return true to prevent default behavior.
		If `ctrlKey` is true, the event can be assumed to be a pinch gesture on a trackpad.
	**/
	public inline function onWheel(cb: event.WheelEvent -> Void) {
		eventHandler.onWheelCallbacks.push(cb);
		return { remove: () -> eventHandler.onWheelCallbacks.remove(cb) }
	}

	/**
		Callback is triggered when a key is pressed down with the view focused.
		Return true to prevent default behavior.
		`hasFocus` is true if our view has input focus for the event. For `hasFocus` to be correct the canvas needs to be focusable. This requires setting the `tabIndex` attribute on the canvas
	**/
	public inline function onKeyDown(cb: (event.KeyboardEvent, hasFocus: Bool) -> Void) {
		eventHandler.onKeyDownCallbacks.push(cb);
		return { remove: () -> eventHandler.onKeyDownCallbacks.remove(cb) }
	}

	/**
		Callback is triggered when a key is released with the view focused.
		Return true to prevent default behavior.
		`hasFocus` is true if our view has input focus for the event. For `hasFocus` to be correct the canvas needs to be focusable. This requires setting the `tabIndex` attribute on the canvas
	**/
	public inline function onKeyUp(cb: (event.KeyboardEvent, hasFocus: Bool) -> Void) {
		eventHandler.onKeyUpCallbacks.push(cb);
		return { remove: () -> eventHandler.onKeyUpCallbacks.remove(cb) }
	}

	/**
		Callback is triggered when the haxe view goes from a deactivated state (hidden view, minimized tab, background-mode app) to a foreground active state.
		For example, you should use this event to resume activities and connect to sensor events.
		This method is called as early as possible in the transition and the view may not yet be visible.
		**It is called once at startup.**
	**/
	public inline function onActivate(cb: () -> Void) {
		eventHandler.onActivateCallbacks.push(cb);
		return { remove: () -> eventHandler.onActivateCallbacks.remove(cb) }
	}

	/**
		Callback is triggered before the app transitions into a deactivated state (hidden view, minimized tab, background-mode app).
		For example you should use this event to suspend activities to save power, pause a game, save state or disconnect from sensors.
		This method is called as early as possible in the transition and the view may still be visible.
	**/
	public inline function onDeactivate(cb: () -> Void) {
		eventHandler.onDeactivateCallbacks.push(cb);
		return { remove: () -> eventHandler.onDeactivateCallbacks.remove(cb) }
	}

	var appActivated = false;
	function onVisibilityChange() {
		switch (document.visibilityState) {
			case VISIBLE: if (!appActivated) {
				eventHandler.onActivate();
				appActivated = true;
			}
			case HIDDEN: if (appActivated) {
				eventHandler.onDeactivate();
				appActivated = false;
			}
		}
	}

	function addPointerEventListeners() {
		// Pointer Input
		function executePointerMethodFromMouseEvent(mouseEvent: MouseEvent, pointerMethod: (PointerEvent) -> Void) {
			// trackpad force
			// var force = mouseEvent.force || mouseEvent.webkitForce;
			var force: Float = if (js.Syntax.field(mouseEvent, 'force') != null) {
				js.Syntax.field(mouseEvent, 'force');
			} else if (js.Syntax.field(mouseEvent, 'webkitForce') != null) {
				js.Syntax.field(mouseEvent, 'webkitForce');
			} else {
				0.5;
			}

			// force ranges from 1 (WEBKIT_FORCE_AT_MOUSE_DOWN) to >2 when using a force-press
			// convert force to a 0 - 1 range
			var pressure = Math.max((force - 1), 0);

			pointerMethod({
				pointerId: 1,
				pointerType: 'mouse',
				isPrimary: true,
				button: mouseEvent.button,
				buttons: mouseEvent.buttons,
				x: mouseEvent.clientX,
				y: mouseEvent.clientY,
				width: 1,
				height: 1,
				viewWidth: el.clientWidth,
				viewHeight: el.clientHeight,
				pressure: pressure,
				tangentialPressure: 0,
				tiltX: 0,
				tiltY: 0,
				twist: 0,
				preventDefault: mouseEvent.preventDefault,
				defaultPrevented: () -> mouseEvent.defaultPrevented,
				nativeEvent: mouseEvent,
			});
		}

		// Map<type, {primaryTouchIdentifier: Int, activeCount: Int}>
		var touchInfoForType = new Map<String, {primaryTouchIdentifier: Int, activeCount: Int}>();
		function getTouchInfoForType(type): {primaryTouchIdentifier: Int, activeCount: Int} {
			var touchInfo = touchInfoForType[type];
			if (touchInfo == null) {
				touchInfoForType[type] = touchInfo = {
					primaryTouchIdentifier: null,
					activeCount: 0,
				}
			}
			return touchInfo;
		}

		function executePointerMethodFromTouchEvent(touchEvent: TouchEvent, pointerMethod: (event.PointerEvent) -> Void) {
			var buttonStates: {
				button: Int,
				buttons: Int,
			} = switch (touchEvent.type) {
				case 'touchstart': {
					button: 0,
					buttons: 1,
				}
				case 'touchforcechange', 'touchmove': {
					button: -1,
					buttons: 1,
				}
				default: {
					button: 0,
					buttons: 0,
				}
			}

			for (i in 0...touchEvent.changedTouches.length) {
				var touch: TouchLevel2 = cast touchEvent.changedTouches[i];

				// touchforcechange can fire _after_ touchup fires
				// we filter it out by checking if the touch is included in the list of active touches
				if (touchEvent.type == 'touchforcechange') {
					var touchIsActive = false;
					for (t in touchEvent.touches) {
						if (touch == cast t) {
							touchIsActive = true;
							break;
						}
					}
					if (!touchIsActive) {
						continue;
					}
				}

				var touchInfo = getTouchInfoForType(touch.touchType);

				// set primary touch as the first active touch
				if (touchInfo.activeCount == 0 && touchEvent.type == 'touchstart') {
					touchInfo.primaryTouchIdentifier = touch.identifier;
				}
				// update activeCount
				switch (touchEvent.type) {
					case 'touchstart':
						touchInfo.activeCount++;
					case 'touchcancel', 'touchend':
						touchInfo.activeCount--;
				}

				// convert altitude-azimuth to tilt xy
				var tanAlt = Math.tan(touch.altitudeAngle);
				var radToDeg = 180.0 / Math.PI;
				var tiltX = Math.atan(Math.cos(touch.azimuthAngle) / tanAlt) * radToDeg;
				var tiltY = Math.atan(Math.sin(touch.azimuthAngle) / tanAlt) * radToDeg;

				var radiusX = touch.radiusX != null ? touch.radiusX : (js.Syntax.field(touch, 'webkitRadiusX') != null ? js.Syntax.field(touch, 'webkitRadiusX') : 5);
				var radiusY = touch.radiusY != null ? touch.radiusY : (js.Syntax.field(touch, 'webkitRadiusY') != null ? js.Syntax.field(touch, 'webkitRadiusY') : 5);

				pointerMethod({
					pointerId: touch.identifier,
					pointerType: (touch.touchType == 'stylus') ? 'pen' : 'touch',
					isPrimary: touch.identifier == touchInfo.primaryTouchIdentifier,
					button: buttonStates.button,
					buttons: buttonStates.buttons,
					x: touch.clientX,
					y: touch.clientY,
					width: radiusX * 2,
					height: radiusY * 2,
					viewWidth: el.clientWidth,
					viewHeight: el.clientHeight,
					pressure: touch.force,
					tangentialPressure: 0,
					tiltX: Math.isFinite(tiltX) ? tiltX : 0,
					tiltY: Math.isFinite(tiltY) ? tiltY : 0,
					twist: touch.rotationAngle,
					preventDefault: touchEvent.preventDefault,
					defaultPrevented: () -> touchEvent.defaultPrevented,
					nativeEvent: touchEvent,
				});
			}
		}

		function updatePointerState(e: PointerEvent) {
			var existingPointer = activePointers.get(e.pointerId);
			if (existingPointer != null) {
				// copy state
				Structure.copyFields(e, existingPointer, {exclude: ['pointerId', 'pointerType', 'isPrimary', 'button', 'preventDefault', 'defaultPrevented', 'nativeEvent']});
			} else {
				// add new state
				activePointers.set(e.pointerId, {
					buttons: e.buttons,
					y: e.y,
					x: e.x,
					width: e.width,
					viewWidth: e.viewWidth,
					viewHeight: e.viewHeight,
					twist: e.twist,
					tiltY: e.tiltY,
					tiltX: e.tiltX,
					tangentialPressure: e.tangentialPressure,
					pressure: e.pressure,
					pointerType: e.pointerType,
					pointerId: e.pointerId,
					isPrimary: e.isPrimary,
					height: e.height,
				});
				activePointerCount++;
			}
		}

		function removePointerState(e: PointerEvent) {
			if (activePointers.remove(e.pointerId)) {
				activePointerCount--;
			}
		}

		var onPointerDown = (e: PointerEvent) -> {
			Reflect.setField(e, 'viewWidth', el.clientWidth);
			Reflect.setField(e, 'viewHeight', el.clientHeight);

			updatePointerState(e);

			eventHandler.onPointerDown(e);
		};
		var onPointerMove = (e: PointerEvent) -> {
			Reflect.setField(e, 'viewWidth', el.clientWidth);
			Reflect.setField(e, 'viewHeight', el.clientHeight);

			updatePointerState(e);

			eventHandler.onPointerMove(e);
		};
		var onPointerUp = (e: PointerEvent) -> {
			Reflect.setField(e, 'viewWidth', el.clientWidth);
			Reflect.setField(e, 'viewHeight', el.clientHeight);

			switch e.pointerType {
				case MOUSE:
					updatePointerState(e);
				case PEN, TOUCH:
					removePointerState(e);
			}

			eventHandler.onPointerUp(e);
		};
		var onPointerCancel = (e: PointerEvent) -> {
			Reflect.setField(e, 'viewWidth', el.clientWidth);
			Reflect.setField(e, 'viewHeight', el.clientHeight);

			switch e.pointerType {
				case MOUSE:
					updatePointerState(e);
				case PEN, TOUCH:
					removePointerState(e);
			}

			eventHandler.onPointerCancel(e);
		};

		// use PointerEvent API if supported
		if (js.Syntax.field(window, 'PointerEvent')) {
			el.addEventListener('pointerdown', (e) -> {
				Reflect.setField(e, 'nativeEvent', e);
				onPointerDown(e);
			});
			window.addEventListener('pointermove', (e) -> {
				Reflect.setField(e, 'nativeEvent', e);
				onPointerMove(e);
			});
			window.addEventListener('pointerup', (e) -> {
				Reflect.setField(e, 'nativeEvent', e);
				onPointerUp(e);
			});
			window.addEventListener('pointercancel', (e) -> {
				Reflect.setField(e, 'nativeEvent', e);
				onPointerCancel(e);
			});
		} else {
			el.addEventListener('mousedown', (e) -> executePointerMethodFromMouseEvent(e, onPointerDown));
			window.addEventListener('mousemove', (e) -> executePointerMethodFromMouseEvent(e, onPointerMove));
			window.addEventListener('webkitmouseforcechanged', (e) -> executePointerMethodFromMouseEvent(e, onPointerMove));
			window.addEventListener('mouseforcechanged', (e) -> executePointerMethodFromMouseEvent(e, onPointerMove));
			window.addEventListener('mouseup', (e) -> executePointerMethodFromMouseEvent(e, onPointerUp));
			var useCapture = true;
			el.addEventListener('touchstart', (e) -> executePointerMethodFromTouchEvent(e, onPointerDown), { capture: useCapture, passive: false }); // passive: false
			window.addEventListener('touchmove', (e) -> executePointerMethodFromTouchEvent(e, onPointerMove), { capture: useCapture, passive: false }); // passive: false
			window.addEventListener('touchforcechange', (e) -> executePointerMethodFromTouchEvent(e, onPointerMove), { capture: useCapture, passive: false }); // passive: true
			window.addEventListener('touchend', (e) -> executePointerMethodFromTouchEvent(e, onPointerUp), {capture: useCapture, passive: false }); // passive: true
			window.addEventListener('touchcancel', (e) -> executePointerMethodFromTouchEvent(e, onPointerCancel), { capture: useCapture, passive: false }); // passive: true
		}
	}

	function addWheelEventListeners() {
		el.addEventListener('wheel', (e: js.html.WheelEvent) -> {
			// we normalize for delta modes, so we always scroll in px
			// chrome always uses pixels but firefox can sometime uses lines and pages
			// see https://stackoverflow.com/questions/20110224/what-is-the-height-of-a-line-in-a-wheel-event-deltamode-dom-delta-line
			var x_px = e.clientX;
			var y_px = e.clientY;
			var deltaX_px = e.deltaX;
			var deltaY_px = e.deltaY;
			var deltaZ_px = e.deltaZ;
			switch (e.deltaMode) {
				case WheelEvent.DOM_DELTA_PIXEL:
					deltaX_px = e.deltaX;
					deltaY_px = e.deltaY;
					deltaZ_px = e.deltaZ;
				case WheelEvent.DOM_DELTA_LINE:
					// lets assume the line-height is 16px
					deltaX_px = e.deltaX * 16;
					deltaY_px = e.deltaY * 16;
					deltaZ_px = e.deltaZ * 16;
				case WheelEvent.DOM_DELTA_PAGE:
					// this needs further testing
					deltaX_px = e.deltaX * 100;
					deltaY_px = e.deltaY * 100;
					deltaZ_px = e.deltaZ * 100;
			}
			eventHandler.onWheel({
				x: x_px,
				y: y_px,
				deltaX: deltaX_px,
				deltaY: deltaY_px,
				deltaZ: deltaZ_px,
				// deltaMode: e.deltaMode,
				altKey: e.altKey,
				ctrlKey: e.ctrlKey,
				metaKey: e.metaKey,
				shiftKey: e.shiftKey,

				preventDefault: e.preventDefault,
				defaultPrevented: () -> e.defaultPrevented,

				nativeEvent: e,
			});
		}, { passive: false });
	}

	function addKeyboardEventListeners() {
		// keyboard event
		window.addEventListener('keydown', (e: KeyboardEvent) -> {
			var hasFocus = e.target == el;
			eventHandler.onKeyDown(cast e, hasFocus);
		});
		window.addEventListener('keyup', (e) -> {
			var hasFocus = e.target == el;
			eventHandler.onKeyUp(cast e, hasFocus);
		});
	}

	function addLifeCycleEventListeners() {
		// life-cycle events
		document.addEventListener('visibilitychange', () -> onVisibilityChange());
	}

}

/**
	Adds missing fields to touch type in the level2 spec
**/
extern class TouchLevel2 extends js.html.Touch {
	var touchType: String;
	var altitudeAngle: Float;
	var azimuthAngle: Float;
}

private class EventDispatcher {

	public final onPointerDownCallbacks = new Array<PointerEvent -> Void>();
	public final onPointerMoveCallbacks = new Array<PointerEvent -> Void>();
	public final onPointerUpCallbacks = new Array<PointerEvent -> Void>();
	public final onPointerCancelCallbacks = new Array<PointerEvent -> Void>();
	public final onWheelCallbacks = new Array<(event.WheelEvent) -> Void>();
	public final onKeyDownCallbacks = new Array<(event: event.KeyboardEvent, hasFocus: Bool) -> Void>();
	public final onKeyUpCallbacks = new Array<(event: event.KeyboardEvent, hasFocus: Bool) -> Void>();
	public final onActivateCallbacks = new Array<() -> Void>();
	public final onDeactivateCallbacks = new Array<() -> Void>();

	public function new() {}

	public function onPointerDown(event: PointerEvent): Void {
		for (cb in onPointerDownCallbacks) {
			cb(event);
		}
	}

	public function onPointerMove(event: PointerEvent): Void {
		for (cb in onPointerMoveCallbacks) {
			cb(event);
		}
	}

	public function onPointerUp(event: PointerEvent): Void {
		for (cb in onPointerUpCallbacks) {
			cb(event);
		}
	}

	public function onPointerCancel(event: PointerEvent): Void {
		for (cb in onPointerCancelCallbacks) {
			cb(event);
		}
	}

	public function onWheel(event: event.WheelEvent): Void {
		for (cb in onWheelCallbacks) {
			cb(event);
		}
	}

	public function onKeyDown(event: event.KeyboardEvent, hasFocus: Bool): Void {
		for (cb in onKeyDownCallbacks) {
			cb(event, hasFocus);
		}
	}

	public function onKeyUp(event: event.KeyboardEvent, hasFocus: Bool): Void {
		for (cb in onKeyUpCallbacks) {
			cb(event, hasFocus);
		}
	}

	public function onActivate(): Void {
		for (cb in onActivateCallbacks) {
			cb();
		}
	}

	public function onDeactivate(): Void {
		for (cb in onDeactivateCallbacks) {
			cb();
		}
	}

}
