package control;

import Structure.extend;
import animation.Spring;
import event.PointerEvent;
import event.ViewEventManager;
import js.html.Element;
import math.Quat;

/**
	Soft arc ball camera

	Maintains natural drag direction when flipped upside-down (like blender viewport)

	strength / damping parameters
	https://www.desmos.com/calculator/fayu8nu1md
**/
@:nullSafety
class ArcBallControl {

	static final defaults = {
		strength: 700,
		damping: 100,
		dragSpeed: 6,
		angleAroundY: 0,
		angleAroundXZ: 0,
		radius: 1,
		zoomSpeed: 1,
	}

	// arc ball smoothing
	public var dragSpeed: Float;
	public var zoomSpeed: Float;

	public var strength(get, set): Float;
	inline function get_strength() return angleAroundY.strength;
	inline function set_strength(v: Float) return {
		angleAroundY.strength = v;
		angleAroundXZ.strength = v;
		radius.strength = v;
		return v;
	}

	public var damping(get, set): Float;
	inline function get_damping() return angleAroundY.damping;
	inline function set_damping(v: Float) return {
		angleAroundY.damping = v;
		angleAroundXZ.damping = v;
		radius.damping = v;
		return v;
	}

	// orientation (via Springs)
	// where angle is 0 at (x=0,z=1) and 90° at (x=1,z=0)
	public final angleAroundY = new Spring(0.);
	public final angleAroundXZ = new Spring(0.);
	public final axialRotation = new Spring(0.);
	public final radius = new Spring(1.);

	public final target = new Vec3(0., 0., 0.);
	public final position = new Vec3(0., 0., 0.);
	public final orientation = new Quat(0, 0, 0, 1);

	public function new(
		options: {
			?interactionSurface: Element,
			?viewEventManager: event.ViewEventManager,
			?angleAroundY: Float,
			?angleAroundXZ: Float,
			?radius: Float,
			?strength: Float,
			?damping: Float,
			?dragSpeed: Float,
			?zoomSpeed: Float,
		}
	) {

		var options = extend(defaults, options);
		
		this.dragSpeed = options.dragSpeed;
		this.zoomSpeed = options.zoomSpeed;
		this.strength = options.strength;
		this.damping = options.damping;
		this.angleAroundY.forceCompletion(options.angleAroundY);
		this.angleAroundXZ.forceCompletion(options.angleAroundXZ);
		this.radius.forceCompletion(options.radius);

		var interactionSurface = options.interactionSurface;
		var viewEventManager = options.viewEventManager;

		if (viewEventManager == null && interactionSurface != null) {
			viewEventManager = new ViewEventManager(interactionSurface);
		}

		if (viewEventManager != null) {
			viewEventManager.onPointerDown(handlePointerDown);
			viewEventManager.onPointerMove(handlePointerMove);
			viewEventManager.onPointerUp(handlePointerUp);
			viewEventManager.onPointerCancel(handlePointerUp);
			viewEventManager.onWheel((e, onView) -> {
				if (onView && Math.abs(zoomSpeed) > 0) {
					radius.target += e.deltaY * zoomSpeed / 1000;
					radius.target = Math.max(radius.target, 0);
					e.preventDefault();
					e.nativeEvent.stopPropagation();
				}
			});
		}
	}

	public inline function step(dt_s: Float) {
		angleAroundY.step(dt_s);
		angleAroundXZ.step(dt_s);
		axialRotation.step(dt_s);
		radius.step(dt_s);
		
		// spherical polar
		position.x = radius.value * Math.sin(angleAroundY.value) * Math.cos(angleAroundXZ.value);
		position.z = radius.value * Math.cos(angleAroundY.value) * Math.cos(angleAroundXZ.value);
		position.y = radius.value * Math.sin(angleAroundXZ.value);

		// look at (0, 0, 0)
		var axial = Quat.fromAxisAngle(position.normalize(), axialRotation.value);
		var aY = Quat.fromAxisAngle(new Vec3(0, 1, 0), angleAroundY.value);
		var aXZ = Quat.fromAxisAngle(new Vec3(1, 0, 0), -angleAroundXZ.value);
		orientation.copyFrom(axial * (aY * aXZ));
	}

	public inline function applyToCamera(camera: {
		final position: {x: Float, y: Float, z: Float};
		final quaternion: {x: Float, y: Float, z: Float, w: Float};
	}) {
		var p = position + target;
		var q = orientation;
		camera.position.x = p.x;
		camera.position.y = p.y;
		camera.position.z = p.z;
		camera.quaternion.x = q.x;
		camera.quaternion.y = q.y;
		camera.quaternion.z = q.z;
		camera.quaternion.w = q.w;
	}

	public inline function update(camera: {
		final position: {x: Float, y: Float, z: Float};
		final quaternion: {x: Float, y: Float, z: Float, w: Float};
	}, dt_s: Float) {
		step(dt_s);
		applyToCamera(camera);
	}

	var _onDown_angleAroundY: Float = 0;
	var _onDown_angleAroundXZ: Float = 0;
	var _onDown_clientXY = new Vec2(0, 0);
	var _drivingPointerId: Null<Int> = null;
	public inline function handlePointerDown(e: PointerEvent, onTargetView: Bool) {
		if (
			onTargetView && e.button == Primary && e.isPrimary && Math.abs(dragSpeed) > 0
		) {
			_drivingPointerId = e.pointerId;
			_onDown_angleAroundY = angleAroundY.target;
			_onDown_angleAroundXZ = angleAroundXZ.target;
			_onDown_clientXY.x = e.x;
			_onDown_clientXY.y = e.y;
			e.preventDefault();
			e.nativeEvent.stopPropagation();
		}
	}

	public inline function handlePointerMove(e: PointerEvent, _) {
		if (e.pointerId == _drivingPointerId) {
			// normalize coordinates so dragSpeed is independent of screen size
			var surfaceSize = new Vec2(e.viewWidth, e.viewHeight);
			var aspect = e.viewWidth / e.viewHeight;
			var clientXY = new Vec2(e.x, e.y);
			var normXY = clientXY / surfaceSize;
			var normOnDownXY = _onDown_clientXY / surfaceSize;
			var screenSpaceDelta = normXY - normOnDownXY;

			angleAroundXZ.target = _onDown_angleAroundXZ + screenSpaceDelta.y * dragSpeed;

			// flip y-axis rotation direction if we're upside-down
			// fade to 0 in and out of the flip for a smoother transition
			var up = orientation.transform(new Vec3(0, 1, 0));
			var flip = up.y >= 0 ? 1 : -1;
			var fadeMultiplier = (1.0 - Math.pow(Math.abs(up.y) + 1, -4));

			angleAroundY.target = _onDown_angleAroundY - fadeMultiplier * flip * screenSpaceDelta.x * dragSpeed * aspect;

			e.preventDefault();
			e.nativeEvent.stopPropagation();
		}
	}

	public inline function handlePointerUp(e: PointerEvent, _) {
		if (e.pointerId == _drivingPointerId) {
			_drivingPointerId = null;
			
			e.preventDefault();
			e.nativeEvent.stopPropagation();
		}
	}

}