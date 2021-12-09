package animator;

import haxe.DynamicAccess;
import animator.Easing.EasingFunction;

using Lambda;

private typedef EasingAnimation = {
	easeFn: EasingFunction,
	object: Dynamic,
	fieldName: String,
	x0: Float,
	x1: Float,
	t0: Float,
	duration_s: Float,
	?onComplete: (fieldName: String) -> Void,
	?onUpdate: (fieldName: String, value: Float) -> Void,
}

@:nullSafety
class Animator {

	public final easingAnimations = new haxe.ds.List<EasingAnimation>();
	public final springs = new Array<Spring>();
	var t_s = 0.0;
	var postStepCallbacks = new haxe.ds.List<(t_s: Float, dt_s: Float) -> Void>();

	public function new() {}

	public function addPostStepCallback(callback: (t_s: Float, dt_s: Float) -> Void) {
		if (!postStepCallbacks.has(callback)) {
			postStepCallbacks.push(callback);
		}
	}

	public function removePostStepCallback(callback: (t_s: Float, dt_s: Float) -> Void) {
		postStepCallbacks.remove(callback);
	}

	public function step(dt_s: Float) {
		t_s += dt_s;

		for (e in easingAnimations) {
			var t = t_s - e.t0;
			var complete = t >= e.duration_s;
			var v = complete ? e.x1 : e.easeFn(e.x0, e.x1, e.duration_s, t);
			Reflect.setField(e.object, e.fieldName, v);
			if (e.onUpdate != null) {
				e.onUpdate(e.fieldName, v);
			}
			if (complete) {
				if (e.onComplete != null) {
					e.onComplete(e.fieldName);
				}
				easingAnimations.remove(e);
			}
		}

		for (spring in springs) {
			spring.step(dt_s);
		}

		for (cb in postStepCallbacks) {
			cb(t_s, dt_s);
		}
	}

	public function ease(
		easingFn: EasingFunction,
		object: Dynamic,
		targets: DynamicAccess<Float>,
		duration_s: Float,
		?onComplete: (fieldName: String) -> Void,
		?onUpdate: (fieldName: String, value: Float) -> Void
	) {
		for (fieldName in Reflect.fields(targets)) {
			var existingAnimation = easingAnimations.find(item -> item.object == object && item.fieldName == fieldName);
			if (existingAnimation != null) easingAnimations.remove(existingAnimation);
			var x1 = targets.get(fieldName);
			var x0 = Reflect.field(object, fieldName);
			if (x1 != null && x0 != null) {
				easingAnimations.push({
					easeFn: easingFn,
					object: object,
					fieldName: fieldName,
					duration_s: duration_s,
					x0: (x0: Float),
					x1: (x1: Float),
					t0: t_s,
					onComplete: onComplete,
					onUpdate: onUpdate,
				});
			}
		}
	}

	public function addSpring(spring: Spring) {
		springs.push(spring);
		return spring;
	}

	public function removeSpring(spring: Spring) {
		springs.remove(spring);
	}

	// easing
	public inline function linear(object: Dynamic, targets: DynamicAccess<Float>, duration_s: Float, ?onComplete: (fieldName: String) -> Void, ?onUpdate: (fieldName: String, value: Float) -> Void)
		ease(Easing.linear, object, targets, duration_s, onComplete, onUpdate);
	public inline function sineIn(object: Dynamic, targets: DynamicAccess<Float>, duration_s: Float, ?onComplete: (fieldName: String) -> Void, ?onUpdate: (fieldName: String, value: Float) -> Void)
		ease(Easing.sineIn, object, targets, duration_s, onComplete, onUpdate);
	public inline function sineOut(object: Dynamic, targets: DynamicAccess<Float>, duration_s: Float, ?onComplete: (fieldName: String) -> Void, ?onUpdate: (fieldName: String, value: Float) -> Void)
		ease(Easing.sineOut, object, targets, duration_s, onComplete, onUpdate);
	public inline function sineInOut(object: Dynamic, targets: DynamicAccess<Float>, duration_s: Float, ?onComplete: (fieldName: String) -> Void, ?onUpdate: (fieldName: String, value: Float) -> Void)
		ease(Easing.sineInOut, object, targets, duration_s, onComplete, onUpdate);
	public inline function quadIn(object: Dynamic, targets: DynamicAccess<Float>, duration_s: Float, ?onComplete: (fieldName: String) -> Void, ?onUpdate: (fieldName: String, value: Float) -> Void)
		ease(Easing.quadIn, object, targets, duration_s, onComplete, onUpdate);
	public inline function quadOut(object: Dynamic, targets: DynamicAccess<Float>, duration_s: Float, ?onComplete: (fieldName: String) -> Void, ?onUpdate: (fieldName: String, value: Float) -> Void)
		ease(Easing.quadOut, object, targets, duration_s, onComplete, onUpdate);
	public inline function quadInOut(object: Dynamic, targets: DynamicAccess<Float>, duration_s: Float, ?onComplete: (fieldName: String) -> Void, ?onUpdate: (fieldName: String, value: Float) -> Void)
		ease(Easing.quadInOut, object, targets, duration_s, onComplete, onUpdate);
	public inline function cubicIn(object: Dynamic, targets: DynamicAccess<Float>, duration_s: Float, ?onComplete: (fieldName: String) -> Void, ?onUpdate: (fieldName: String, value: Float) -> Void)
		ease(Easing.cubicIn, object, targets, duration_s, onComplete, onUpdate);
	public inline function cubicOut(object: Dynamic, targets: DynamicAccess<Float>, duration_s: Float, ?onComplete: (fieldName: String) -> Void, ?onUpdate: (fieldName: String, value: Float) -> Void)
		ease(Easing.cubicOut, object, targets, duration_s, onComplete, onUpdate);
	public inline function cubicInOut(object: Dynamic, targets: DynamicAccess<Float>, duration_s: Float, ?onComplete: (fieldName: String) -> Void, ?onUpdate: (fieldName: String, value: Float) -> Void)
		ease(Easing.cubicInOut, object, targets, duration_s, onComplete, onUpdate);

}