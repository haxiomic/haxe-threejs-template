package animation;

import animation.Easing.EasingFunction;
import animation.Easing.EasingFunctions;

class Tween {

	final easeFn: EasingFunction;
	final setValue: (v: Float) -> Void;
	final x0: Float;
	final x1: Float;
	final duration_s: Float;
	final onUpdate: Null<(value: Float) -> Void>;
	final onComplete: Null<() -> Void>;

	// current state
	var t: Float = 0.;

	public function new(
		easing: Easing,
		setValue: (x: Float) -> Void,
		x0: Float,
		x1: Float,
		duration_s: Float,
		?onUpdate: (value: Float) -> Void,
		?onComplete: () -> Void
	) {
		this.easeFn = getEasingFunction(easing);
		this.setValue = setValue;
		this.x0 = x0;
		this.x1 = x1;
		this.duration_s = duration_s;
		this.onUpdate = onUpdate;
		this.onComplete = onComplete;
	}

	public function step(dt_s: Float) {
		t += dt_s;

		var complete = isComplete();

		var x = complete ? x1 : easeFn(x0, x1, duration_s, t);

		setValue(x);

		if (onUpdate != null) {
			onUpdate(x);
		}

		if (complete && onComplete != null) {
			onComplete();
		}
	}

	public function setTime(t_s: Float) {
		t = t_s;
		step(0);
	}

	public function isComplete() {
		return t >= duration_s;
	}

	public function forceCompletion() {
		setTime(duration_s);
	}

	function getEasingFunction(easing: Easing) {
		return switch easing {
			case Custom(fn): fn;
			case Linear: EasingFunctions.linear;
			case SineIn: EasingFunctions.sineIn;
			case SineOut: EasingFunctions.sineOut;
			case SineInOut: EasingFunctions.sineInOut;
			case QuadIn: EasingFunctions.quadIn;
			case QuadOut: EasingFunctions.quadOut;
			case QuadInOut: EasingFunctions.quadInOut;
			case CubicIn: EasingFunctions.cubicIn;
			case CubicOut: EasingFunctions.cubicOut;
			case CubicInOut: EasingFunctions.cubicInOut;
		}
	}

}