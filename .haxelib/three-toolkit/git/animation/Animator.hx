package animation;

#if (!macro)
using Lambda;

@:nullSafety
class Animator {

	public final temporaryTweens = new Array<Tween>();
	public final temporarySprings = new Array<Spring>();
	public final springs = new Array<Spring>();
	var t_s = 0.0;
	var preStepCallbacks = new Array<(t_s: Float, dt_s: Float) -> Void>();
	var postStepCallbacks = new Array<(t_s: Float, dt_s: Float) -> Void>();

	public function new() {}

	public function step(dt_s: Float) {
		t_s += dt_s;

		for (cb in preStepCallbacks) {
			cb(t_s, dt_s);
		}

		for (tween in temporaryTweens) {
			if (!tween.isComplete()) {
				tween.step(dt_s);
			}
			if (tween.isComplete()) {
				temporaryTweens.remove(tween);
			}
		}

		for (spring in temporarySprings) {
			if (!spring.isComplete()) {
				spring.step(dt_s);
			}
			if (spring.isComplete()) {
				temporarySprings.remove(spring);
			}
		}

		for (spring in springs) {
			spring.step(dt_s);
		}

		for (cb in postStepCallbacks) {
			cb(t_s, dt_s);
		}
	}

	public macro function tweenTo(self: Expr, fieldExpression: ExprOf<Float>, toValue: ExprOf<Float>, ?options: ExprOf<{
		?duration_s: Float,
		?onUpdate: (value: Float) -> Void,
		?onComplete: () -> Void,
		?easing: Easing,
	}>): ExprOf<Void>; // implementation below in macro code

	/**
	 * Animate value with a spring, the spring is removed when the value is reached (if ever)
	 */
	public macro function springTo(self: Expr, fieldExpression: ExprOf<Float>, toValue: ExprOf<Float>, options: ExprOf<{
		?onUpdate: (value: Float) -> Void,
		?onComplete: () -> Void,
		?style: animation.Spring.SpringStyle,
	}>): ExprOf<Spring>;

	/**
	 * Add permanent spring that will not be removed when the target is reached
	 * @param spring 
	 */
	public inline function addSpring(spring: Spring) {
		springs.push(spring);
		return spring;
	}

	public inline function removeSpring(spring: Spring) {
		springs.remove(spring);
	}

	public inline function createSpring(
		initialValue: Float,
		?target: Float,
		?style: animation.Spring.SpringStyle,
		velocity: Float = 0.0,
		?onUpdate: (value: Float, velocity: Float) -> Void,
		?onComplete: () -> Void
	) {
		return addSpring(new Spring(initialValue, target, style, velocity, onUpdate, onComplete));
	}

	public function addBeforeStepCallback(callback: (t_s: Float, dt_s: Float) -> Void) {
		if (!preStepCallbacks.has(callback)) {
			preStepCallbacks.push(callback);
		}
		return {remove: () -> preStepCallbacks.remove(callback)};
	}

	public function addAfterStepCallback(callback: (t_s: Float, dt_s: Float) -> Void) {
		if (!postStepCallbacks.has(callback)) {
			postStepCallbacks.push(callback);
		}
		return {remove: () -> postStepCallbacks.remove(callback)};
	}

	public function removeBeforeStepCallback(callback: (t_s: Float, dt_s: Float) -> Void) {
		return preStepCallbacks.remove(callback);
	}

	public function removeAfterStepCallback(callback: (t_s: Float, dt_s: Float) -> Void) {
		return postStepCallbacks.remove(callback);
	}

}

#else // if macro

import haxe.macro.Expr;

class Animator {

	public macro function tweenTo(self: Expr, fieldExpression: ExprOf<Float>, toValue: ExprOf<Float>, options: Expr): ExprOf<Void> {
		return macro @:privateAccess {
			var options: {
				?duration_s: Float,
				?onUpdate: (value: Float) -> Void,
				?onComplete: () -> Void,
				?easing: animation.Easing,
			} = $options;

			var startValue: Float = $fieldExpression;
			var toValue: Float = $toValue;

			$self.temporaryTweens.push(
				new animation.Tween(
					options.easing,
					(__: Float) -> $fieldExpression = __,
					startValue,
					toValue,
					options.duration_s,
					options.onUpdate,
					options.onComplete
				)
			);

		};
	}

	public macro function springTo(self: Expr, fieldExpression: ExprOf<Float>, toValue: ExprOf<Float>, options: Expr): ExprOf<Spring> {
		return macro {
			var options:{
				?onUpdate: (value: Float) -> Void,
				?onComplete: () -> Void,
				?style: animation.Spring.SpringStyle,
			} = $options;

			var startValue: Float = $fieldExpression;
			var toValue: Float = $toValue;

			$self.temporarySprings.push(
				new animation.Spring(
					startValue,
					toValue,
					options.style,
					0.,
					if (options.onUpdate == null) {
						(__: Float, ___) -> $fieldExpression = __;
					} else {
						(__: Float, ___) -> {
							$fieldExpression = __;
							options.onUpdate(__);
						}
					},
					options.onComplete
				)
			);
		};
	}

}

#end
