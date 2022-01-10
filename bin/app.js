(function ($global) { "use strict";
class EReg {
	constructor(r,opt) {
		this.r = new RegExp(r,opt.split("u").join(""));
	}
	match(s) {
		if(this.r.global) {
			this.r.lastIndex = 0;
		}
		this.r.m = this.r.exec(s);
		this.r.s = s;
		return this.r.m != null;
	}
	matched(n) {
		if(this.r.m != null && n >= 0 && n < this.r.m.length) {
			return this.r.m[n];
		} else {
			throw haxe_Exception.thrown("EReg::matched");
		}
	}
	matchedRight() {
		if(this.r.m == null) {
			throw haxe_Exception.thrown("No string matched");
		}
		let sz = this.r.m.index + this.r.m[0].length;
		return HxOverrides.substr(this.r.s,sz,this.r.s.length - sz);
	}
}
EReg.__name__ = true;
class HxOverrides {
	static substr(s,pos,len) {
		if(len == null) {
			len = s.length;
		} else if(len < 0) {
			if(pos == 0) {
				len = s.length + len;
			} else {
				return "";
			}
		}
		return s.substr(pos,len);
	}
	static now() {
		return Date.now();
	}
}
HxOverrides.__name__ = true;
class app_InteractionEventsManager {
	constructor(el) {
		this.haxeAppActivated = false;
		this.elClientHeight = null;
		this.elClientWidth = null;
		this.el = el;
		this.eventHandler = new app__$InteractionEventsManager_EventDispatcher();
		if(el.tabIndex == null) {
			el.tabIndex = 1;
		}
		el.style.touchAction = "none";
		el.setAttribute("touch-action","none");
		let cancelEvent = function(e) {
			e.preventDefault();
			e.stopPropagation();
		};
		el.addEventListener("gesturestart",cancelEvent,false);
		el.addEventListener("gesturechange",cancelEvent,false);
		this.addPointerEventListeners();
		this.addWheelEventListeners();
		this.addKeyboardEventListeners();
		this.addLifeCycleEventListeners();
		this.addResizeEventListeners();
		this.onVisibilityChange();
	}
	onVisibilityChange() {
		switch(window.document.visibilityState) {
		case "hidden":
			if(this.haxeAppActivated) {
				this.eventHandler.onDeactivate();
				this.haxeAppActivated = false;
			}
			break;
		case "visible":
			if(!this.haxeAppActivated) {
				this.eventHandler.onActivate();
				this.haxeAppActivated = true;
			}
			break;
		}
	}
	addPointerEventListeners() {
		let _gthis = this;
		let executePointerMethodFromMouseEvent = function(mouseEvent,pointerMethod) {
			let force = mouseEvent.force != null ? mouseEvent.force : mouseEvent.webkitForce != null ? mouseEvent.webkitForce : 0.5;
			let pressure = Math.max(force - 1,0);
			if(pointerMethod(new app_event_PointerEvent(1,"mouse",true,mouseEvent.button,mouseEvent.buttons,mouseEvent.clientX,mouseEvent.clientY,1,1,_gthis.el.clientWidth,_gthis.el.clientHeight,pressure,0,0,0,0)) == 0) {
				mouseEvent.preventDefault();
			}
		};
		let touchInfoForType_h = Object.create(null);
		let getTouchInfoForType = function(type) {
			let touchInfo = touchInfoForType_h[type];
			if(touchInfo == null) {
				touchInfo = { primaryTouchIdentifier : null, activeCount : 0};
				let v = touchInfo;
				touchInfoForType_h[type] = v;
			}
			return touchInfo;
		};
		let executePointerMethodFromTouchEvent = function(touchEvent,pointerMethod) {
			let buttonStates;
			switch(touchEvent.type) {
			case "touchforcechange":case "touchmove":
				buttonStates = { button : -1, buttons : 1};
				break;
			case "touchstart":
				buttonStates = { button : 0, buttons : 1};
				break;
			default:
				buttonStates = { button : 0, buttons : 0};
			}
			let _g = 0;
			let _g1 = touchEvent.changedTouches.length;
			while(_g < _g1) {
				let i = _g++;
				let touch = touchEvent.changedTouches[i];
				if(touchEvent.type == "touchforcechange") {
					let touchIsActive = false;
					let _g = 0;
					let _g1 = touchEvent.touches;
					while(_g < _g1.length) {
						let t = _g1[_g];
						++_g;
						if(touch == t) {
							touchIsActive = true;
							break;
						}
					}
					if(!touchIsActive) {
						continue;
					}
				}
				let touchInfo = getTouchInfoForType(touch.touchType);
				if(touchInfo.activeCount == 0 && touchEvent.type == "touchstart") {
					touchInfo.primaryTouchIdentifier = touch.identifier;
				}
				switch(touchEvent.type) {
				case "touchcancel":case "touchend":
					touchInfo.activeCount--;
					break;
				case "touchstart":
					touchInfo.activeCount++;
					break;
				}
				let tanAlt = Math.tan(touch.altitudeAngle);
				let radToDeg = 180.0 / Math.PI;
				let tiltX = Math.atan(Math.cos(touch.azimuthAngle) / tanAlt) * radToDeg;
				let tiltY = Math.atan(Math.sin(touch.azimuthAngle) / tanAlt) * radToDeg;
				let radiusX = touch.radiusX != null ? touch.radiusX : touch.webkitRadiusX != null ? touch.webkitRadiusX : 5;
				let radiusY = touch.radiusY != null ? touch.radiusY : touch.webkitRadiusY != null ? touch.webkitRadiusY : 5;
				if(pointerMethod(new app_event_PointerEvent(touch.identifier,touch.touchType == "stylus" ? "pen" : "touch",touch.identifier == touchInfo.primaryTouchIdentifier,buttonStates.button,buttonStates.buttons,touch.clientX,touch.clientY,radiusX * 2,radiusY * 2,_gthis.el.clientWidth,_gthis.el.clientHeight,touch.force,0,isFinite(tiltX) ? tiltX : 0,isFinite(tiltY) ? tiltY : 0,touch.rotationAngle)) == 0) {
					touchEvent.preventDefault();
				}
			}
		};
		let onPointerDown = function(e) {
			e["viewWidth"] = _gthis.el.clientWidth;
			e["viewHeight"] = _gthis.el.clientHeight;
			return _gthis.eventHandler.onPointerDown(e);
		};
		let onPointerMove = function(e) {
			e["viewWidth"] = _gthis.el.clientWidth;
			e["viewHeight"] = _gthis.el.clientHeight;
			return _gthis.eventHandler.onPointerMove(e);
		};
		let onPointerUp = function(e) {
			e["viewWidth"] = _gthis.el.clientWidth;
			e["viewHeight"] = _gthis.el.clientHeight;
			return _gthis.eventHandler.onPointerUp(e);
		};
		let onPointerCancel = function(e) {
			e["viewWidth"] = _gthis.el.clientWidth;
			e["viewHeight"] = _gthis.el.clientHeight;
			return _gthis.eventHandler.onPointerCancel(e);
		};
		if(window.PointerEvent) {
			this.el.addEventListener("pointerdown",onPointerDown);
			window.addEventListener("pointermove",onPointerMove);
			window.addEventListener("pointerup",onPointerUp);
			window.addEventListener("pointercancel",onPointerCancel);
		} else {
			this.el.addEventListener("mousedown",function(e) {
				executePointerMethodFromMouseEvent(e,onPointerDown);
			});
			window.addEventListener("mousemove",function(e) {
				executePointerMethodFromMouseEvent(e,onPointerMove);
			});
			window.addEventListener("webkitmouseforcechanged",function(e) {
				executePointerMethodFromMouseEvent(e,onPointerMove);
			});
			window.addEventListener("mouseforcechanged",function(e) {
				executePointerMethodFromMouseEvent(e,onPointerMove);
			});
			window.addEventListener("mouseup",function(e) {
				executePointerMethodFromMouseEvent(e,onPointerUp);
			});
			this.el.addEventListener("touchstart",function(e) {
				executePointerMethodFromTouchEvent(e,onPointerDown);
			},{ capture : true, passive : false});
			window.addEventListener("touchmove",function(e) {
				executePointerMethodFromTouchEvent(e,onPointerMove);
			},{ capture : true, passive : false});
			window.addEventListener("touchforcechange",function(e) {
				executePointerMethodFromTouchEvent(e,onPointerMove);
			},{ capture : true, passive : false});
			window.addEventListener("touchend",function(e) {
				executePointerMethodFromTouchEvent(e,onPointerUp);
			},{ capture : true, passive : false});
			window.addEventListener("touchcancel",function(e) {
				executePointerMethodFromTouchEvent(e,onPointerCancel);
			},{ capture : true, passive : false});
		}
	}
	addWheelEventListeners() {
		let _gthis = this;
		this.el.addEventListener("wheel",function(e) {
			let x_px = e.clientX;
			let y_px = e.clientY;
			let deltaX_px = e.deltaX;
			let deltaY_px = e.deltaY;
			let deltaZ_px = e.deltaZ;
			switch(e.deltaMode) {
			case 0:
				deltaX_px = e.deltaX;
				deltaY_px = e.deltaY;
				deltaZ_px = e.deltaZ;
				break;
			case 1:
				deltaX_px = e.deltaX * 16;
				deltaY_px = e.deltaY * 16;
				deltaZ_px = e.deltaZ * 16;
				break;
			case 2:
				deltaX_px = e.deltaX * 100;
				deltaY_px = e.deltaY * 100;
				deltaZ_px = e.deltaZ * 100;
				break;
			}
			if(_gthis.eventHandler.onWheel(new app_event_WheelEvent(deltaX_px,deltaY_px,deltaZ_px,x_px,y_px,e.altKey,e.ctrlKey,e.metaKey,e.shiftKey,e)) == 0) {
				e.preventDefault();
			}
		},{ passive : false});
	}
	addKeyboardEventListeners() {
		let _gthis = this;
		window.addEventListener("keydown",function(e) {
			let hasFocus = e.target == _gthis.el;
			if(_gthis.eventHandler.onKeyDown(e,hasFocus) == 0) {
				e.preventDefault();
			}
		});
		window.addEventListener("keyup",function(e) {
			let hasFocus = e.target == _gthis.el;
			if(_gthis.eventHandler.onKeyUp(e,hasFocus) == 0) {
				e.preventDefault();
			}
		});
	}
	addLifeCycleEventListeners() {
		let _gthis = this;
		window.document.addEventListener("visibilitychange",function() {
			_gthis.onVisibilityChange();
		});
	}
	addResizeEventListeners() {
		let _gthis = this;
		window.addEventListener("resize",function() {
			if(_gthis.elClientWidth != _gthis.el.clientWidth || _gthis.elClientHeight != _gthis.el.clientHeight) {
				_gthis.elClientWidth = _gthis.el.clientWidth;
				_gthis.elClientHeight = _gthis.el.clientHeight;
				_gthis.eventHandler.onResize(_gthis.el.clientWidth,_gthis.el.clientHeight);
			}
		},{ capture : false});
	}
}
app_InteractionEventsManager.__name__ = true;
class app__$InteractionEventsManager_EventDispatcher {
	constructor() {
		this.onDeactivateCallbacks = [];
		this.onActivateCallbacks = [];
		this.onKeyUpCallbacks = [];
		this.onKeyDownCallbacks = [];
		this.onWheelCallbacks = [];
		this.onPointerCancelCallbacks = [];
		this.onPointerUpCallbacks = [];
		this.onPointerMoveCallbacks = [];
		this.onPointerDownCallbacks = [];
		this.onResizeCallbacks = [];
	}
	onResize(width,height) {
		let _g = 0;
		let _g1 = this.onResizeCallbacks;
		while(_g < _g1.length) {
			let cb = _g1[_g];
			++_g;
			cb(width,height);
		}
	}
	onPointerDown(event) {
		let _g = 0;
		let _g1 = this.onPointerDownCallbacks;
		while(_g < _g1.length) {
			let cb = _g1[_g];
			++_g;
			if(cb(event) == 0) {
				return 0;
			}
		}
		return 1;
	}
	onPointerMove(event) {
		let _g = 0;
		let _g1 = this.onPointerMoveCallbacks;
		while(_g < _g1.length) {
			let cb = _g1[_g];
			++_g;
			if(cb(event) == 0) {
				return 0;
			}
		}
		return 1;
	}
	onPointerUp(event) {
		let _g = 0;
		let _g1 = this.onPointerUpCallbacks;
		while(_g < _g1.length) {
			let cb = _g1[_g];
			++_g;
			if(cb(event) == 0) {
				return 0;
			}
		}
		return 1;
	}
	onPointerCancel(event) {
		let _g = 0;
		let _g1 = this.onPointerCancelCallbacks;
		while(_g < _g1.length) {
			let cb = _g1[_g];
			++_g;
			if(cb(event) == 0) {
				return 0;
			}
		}
		return 1;
	}
	onWheel(event) {
		let _g = 0;
		let _g1 = this.onWheelCallbacks;
		while(_g < _g1.length) {
			let cb = _g1[_g];
			++_g;
			if(cb(event) == 0) {
				return 0;
			}
		}
		return 1;
	}
	onKeyDown(event,hasFocus) {
		let _g = 0;
		let _g1 = this.onKeyDownCallbacks;
		while(_g < _g1.length) {
			let cb = _g1[_g];
			++_g;
			if(cb(event,hasFocus) == 0) {
				return 0;
			}
		}
		return 1;
	}
	onKeyUp(event,hasFocus) {
		let _g = 0;
		let _g1 = this.onKeyUpCallbacks;
		while(_g < _g1.length) {
			let cb = _g1[_g];
			++_g;
			if(cb(event,hasFocus) == 0) {
				return 0;
			}
		}
		return 1;
	}
	onActivate() {
		let _g = 0;
		let _g1 = this.onActivateCallbacks;
		while(_g < _g1.length) {
			let cb = _g1[_g];
			++_g;
			cb();
		}
	}
	onDeactivate() {
		let _g = 0;
		let _g1 = this.onDeactivateCallbacks;
		while(_g < _g1.length) {
			let cb = _g1[_g];
			++_g;
			cb();
		}
	}
}
app__$InteractionEventsManager_EventDispatcher.__name__ = true;
class control_ArcBallControl {
	constructor(options) {
		this._isPointerDown = false;
		let this1 = new Vec2Data(0,0);
		this._onDown_clientXY = this1;
		this._onDown_angleAroundXZ = 0;
		this._onDown_angleAroundY = 0;
		let this11 = new Vec4Data(0,0,0,1);
		let this12 = this11;
		this.orientation = this12;
		let this13 = new Vec3Data(0.,0.,0.);
		this.position = this13;
		let this14 = new Vec3Data(0.,0.,0.);
		this.target = this14;
		this.radius = new animator_Spring(1.);
		this.axialRotation = new animator_Spring(0.);
		this.angleAroundXZ = new animator_Spring(0.);
		this.angleAroundY = new animator_Spring(0.);
		let a = control_ArcBallControl.defaults;
		let options_zoomSpeed = options.zoomSpeed != null ? options.zoomSpeed : a.zoomSpeed;
		let options_strength = options.strength != null ? options.strength : a.strength;
		let options_radius = options.radius != null ? options.radius : a.radius;
		let options_interactionSurface = options.interactionSurface;
		let options_interactionEventsManager = options.interactionEventsManager;
		let options_dragSpeed = options.dragSpeed != null ? options.dragSpeed : a.dragSpeed;
		let options_damping = options.damping != null ? options.damping : a.damping;
		let options_angleAroundY = options.angleAroundY != null ? options.angleAroundY : a.angleAroundY;
		let options_angleAroundXZ = options.angleAroundXZ != null ? options.angleAroundXZ : a.angleAroundXZ;
		this.dragSpeed = options_dragSpeed;
		this.zoomSpeed = options_zoomSpeed;
		let v = options_strength;
		this.angleAroundY.strength = v;
		this.angleAroundXZ.strength = v;
		this.radius.strength = v;
		let v1 = options_damping;
		this.angleAroundY.damping = v1;
		this.angleAroundXZ.damping = v1;
		this.radius.damping = v1;
		this.angleAroundY.forceCompletion(options_angleAroundY);
		this.angleAroundXZ.forceCompletion(options_angleAroundXZ);
		this.radius.forceCompletion(options_radius);
		let interactionSurface = options_interactionSurface;
		let _gthis = this;
		if(options_interactionEventsManager != null) {
			let cb = function(e) {
				let clientXY_x = e.x;
				let clientXY_y = e.y;
				_gthis._isPointerDown = true;
				_gthis._onDown_angleAroundY = _gthis.angleAroundY.target;
				_gthis._onDown_angleAroundXZ = _gthis.angleAroundXZ.target;
				let this1 = _gthis._onDown_clientXY;
				this1.x = clientXY_x;
				this1.y = clientXY_y;
				return 1;
			};
			options_interactionEventsManager.eventHandler.onPointerDownCallbacks.push(cb);
			let cb1 = function(e) {
				let clientXY_x = e.x;
				let clientXY_y = e.y;
				let surfaceSize_x = e.viewWidth;
				let surfaceSize_y = e.viewHeight;
				if(_gthis._isPointerDown) {
					let aspect = surfaceSize_x / surfaceSize_y;
					let normXY_x = clientXY_x / surfaceSize_x;
					let normXY_y = clientXY_y / surfaceSize_y;
					let a = _gthis._onDown_clientXY;
					let normOnDownXY_x = a.x / surfaceSize_x;
					let normOnDownXY_y = a.y / surfaceSize_y;
					let screenSpaceDelta_x = normXY_x - normOnDownXY_x;
					let screenSpaceDelta_y = normXY_y - normOnDownXY_y;
					_gthis.angleAroundXZ.target = _gthis._onDown_angleAroundXZ + screenSpaceDelta_y * _gthis.dragSpeed;
					let this1 = _gthis.orientation;
					let u_x = this1.x;
					let u_y = this1.y;
					let u_z = this1.z;
					let s = this1.w;
					let a_y = u_y * (2 * (u_x * 0. + u_y + u_z * 0.));
					let b_y = s * s - (u_x * u_x + u_y * u_y + u_z * u_z);
					let a_y1 = a_y + b_y;
					let this_y = u_z * 0. - u_x * 0.;
					let b_y1 = this_y * (2 * s);
					let up_y = a_y1 + b_y1;
					let flip = up_y >= 0 ? 1 : -1;
					let fadeMultiplier = 1.0 - Math.pow(Math.abs(up_y) + 1,-4);
					_gthis.angleAroundY.target = _gthis._onDown_angleAroundY - fadeMultiplier * flip * screenSpaceDelta_x * _gthis.dragSpeed * aspect;
					return 0;
				} else {
					return 1;
				}
			};
			options_interactionEventsManager.eventHandler.onPointerMoveCallbacks.push(cb1);
			let cb2 = function(e) {
				_gthis._isPointerDown = false;
				return 1;
			};
			options_interactionEventsManager.eventHandler.onPointerUpCallbacks.push(cb2);
			let cb3 = function(e) {
				_gthis.radius.target += e.deltaY * _gthis.zoomSpeed / 1000;
				_gthis.radius.target = Math.max(_gthis.radius.target,0);
				return 0;
			};
			options_interactionEventsManager.eventHandler.onWheelCallbacks.push(cb3);
		} else if(interactionSurface != null) {
			interactionSurface.addEventListener("mousedown",function(e) {
				let clientXY_x = e.clientX;
				let clientXY_y = e.clientY;
				_gthis._isPointerDown = true;
				_gthis._onDown_angleAroundY = _gthis.angleAroundY.target;
				_gthis._onDown_angleAroundXZ = _gthis.angleAroundXZ.target;
				let this1 = _gthis._onDown_clientXY;
				this1.x = clientXY_x;
				this1.y = clientXY_y;
			});
			interactionSurface.addEventListener("contextmenu",function(e) {
				_gthis._isPointerDown = false;
			});
			window.addEventListener("mousemove",function(e) {
				let clientXY_x = e.clientX;
				let clientXY_y = e.clientY;
				let surfaceSize_x = interactionSurface.clientWidth;
				let surfaceSize_y = interactionSurface.clientHeight;
				let tmp;
				if(_gthis._isPointerDown) {
					let aspect = surfaceSize_x / surfaceSize_y;
					let normXY_x = clientXY_x / surfaceSize_x;
					let normXY_y = clientXY_y / surfaceSize_y;
					let a = _gthis._onDown_clientXY;
					let normOnDownXY_x = a.x / surfaceSize_x;
					let normOnDownXY_y = a.y / surfaceSize_y;
					let screenSpaceDelta_x = normXY_x - normOnDownXY_x;
					let screenSpaceDelta_y = normXY_y - normOnDownXY_y;
					_gthis.angleAroundXZ.target = _gthis._onDown_angleAroundXZ + screenSpaceDelta_y * _gthis.dragSpeed;
					let this1 = _gthis.orientation;
					let u_x = this1.x;
					let u_y = this1.y;
					let u_z = this1.z;
					let s = this1.w;
					let a_y = u_y * (2 * (u_x * 0. + u_y + u_z * 0.));
					let b_y = s * s - (u_x * u_x + u_y * u_y + u_z * u_z);
					let a_y1 = a_y + b_y;
					let this_y = u_z * 0. - u_x * 0.;
					let b_y1 = this_y * (2 * s);
					let up_y = a_y1 + b_y1;
					let flip = up_y >= 0 ? 1 : -1;
					let fadeMultiplier = 1.0 - Math.pow(Math.abs(up_y) + 1,-4);
					_gthis.angleAroundY.target = _gthis._onDown_angleAroundY - fadeMultiplier * flip * screenSpaceDelta_x * _gthis.dragSpeed * aspect;
					tmp = 0;
				} else {
					tmp = 1;
				}
				if(tmp == 0) {
					e.preventDefault();
				}
			});
			window.addEventListener("mouseup",function(e) {
				_gthis._isPointerDown = false;
			});
			interactionSurface.addEventListener("wheel",function(e) {
				_gthis.radius.target += e.deltaY * _gthis.zoomSpeed / 1000;
				_gthis.radius.target = Math.max(_gthis.radius.target,0);
				e.preventDefault();
			},{ passive : false});
		}
	}
	applyToCamera(camera) {
		let a = this.position;
		let b = this.target;
		let p_x = a.x + b.x;
		let p_y = a.y + b.y;
		let p_z = a.z + b.z;
		let q = this.orientation;
		camera.position.x = p_x;
		camera.position.y = p_y;
		camera.position.z = p_z;
		camera.quaternion.x = q.x;
		camera.quaternion.y = q.y;
		camera.quaternion.z = q.z;
		camera.quaternion.w = q.w;
	}
}
control_ArcBallControl.__name__ = true;
Math.__name__ = true;
var three_Mesh = require("three").Mesh;
class rendering_BackgroundEnvironment extends three_Mesh {
	constructor(roughness) {
		if(roughness == null) {
			roughness = 0.5;
		}
		let environmentMaterial = new rendering_EnvironmentMaterial(roughness);
		super(new three_BoxGeometry(1,1,1),environmentMaterial);
		this.geometry.deleteAttribute("normal");
		this.geometry.deleteAttribute("uv");
		this.name = "BackgroundEnvironment";
		this.frustumCulled = false;
		this.castShadow = false;
		this.receiveShadow = false;
		this.matrixAutoUpdate = false;
		this.renderOrder = -Infinity;
		let _gthis = this;
		this.onBeforeRender = function(renderer,scene,camera,geometry,material,group) {
			let _this = _gthis.material;
			let v = scene.environment;
			if(v != _this.uEnvMap.value) {
				_this.needsUpdate = true;
			}
			if(v != null) {
				_this.uFlipEnvMap.value = v.isCubeTexture == true ? -1 : 1;
			}
			_this.uEnvMap.value = v;
			_this.envMap = v;
			_gthis.matrixWorld.copyPosition(camera.matrixWorld);
		};
	}
}
rendering_BackgroundEnvironment.__name__ = true;
var three_ShaderMaterial = require("three").ShaderMaterial;
class rendering_EnvironmentMaterial extends three_ShaderMaterial {
	constructor(roughness) {
		let uRoughness = new three_Uniform(0.5);
		let uFlipEnvMap = new three_Uniform(-1);
		let uEnvMap = new three_Uniform(null);
		let uMultiplier = new three_Uniform(new three_Color(1,1,1));
		super({ name : "BackgroundEnvironment", uniforms : { "envMap" : uEnvMap, "flipEnvMap" : uFlipEnvMap, "uRoughness" : uRoughness, "uMultiplier" : uMultiplier}, vertexShader : Three.ShaderLib.cube.vertexShader, fragmentShader : "\n\t\t\t\tuniform float uRoughness;\n\t\t\t\tuniform vec3 uMultiplier;\n\t\t\t\t#include <envmap_common_pars_fragment>\n\t\t\t\t#ifdef USE_ENVMAP\n\t\t\t\tvarying vec3 vWorldDirection;\n\t\t\t\t#endif\n\t\t\t\t#include <cube_uv_reflection_fragment>\n\n\t\t\t\tvoid main() {\n\t\t\t\t\t#ifdef USE_ENVMAP\n\t\t\t\t\t\tvec3 reflectVec = vWorldDirection;\n\t\t\t\t\t\t#ifdef ENVMAP_TYPE_CUBE\n\t\t\t\t\t\t\tvec4 envColor = textureCube( envMap, vec3( flipEnvMap * reflectVec.x, reflectVec.yz ) );\n\t\t\t\t\t\t#elif defined( ENVMAP_TYPE_CUBE_UV )\n\t\t\t\t\t\t\tvec4 envColor = textureCubeUV(envMap, reflectVec, uRoughness);\n\t\t\t\t\t\t#elif defined( ENVMAP_TYPE_EQUIREC )\n\t\t\t\t\t\t\tvec2 sampleUV;\n\t\t\t\t\t\t\treflectVec = normalize( reflectVec );\n\t\t\t\t\t\t\tsampleUV.y = asin( clamp( reflectVec.y, - 1.0, 1.0 ) ) * RECIPROCAL_PI + 0.5;\n\t\t\t\t\t\t\tsampleUV.x = atan( reflectVec.z, reflectVec.x ) * RECIPROCAL_PI2 + 0.5;\n\t\t\t\t\t\t\tvec4 envColor = texture2D( envMap, sampleUV );\n\t\t\t\t\t\t#elif defined( ENVMAP_TYPE_SPHERE )\n\t\t\t\t\t\t\treflectVec = normalize( reflectVec );\n\t\t\t\t\t\t\tvec3 reflectView = normalize( ( viewMatrix * vec4( reflectVec, 0.0 ) ).xyz + vec3( 0.0, 0.0, 1.0 ) );\n\t\t\t\t\t\t\tvec4 envColor = texture2D( envMap, reflectView.xy * 0.5 + 0.5 );\n\t\t\t\t\t\t#else\n\t\t\t\t\t\t\tvec4 envColor = vec4( 0.0 );\n\t\t\t\t\t\t#endif\n\t\t\t\t\t\t#ifndef ENVMAP_TYPE_CUBE_UV\n\t\t\t\t\t\t\tenvColor = envMapTexelToLinear( envColor );\n\t\t\t\t\t\t#endif\n\t\t\t\t\t#endif\n\t\t\t\t\t#ifdef USE_ENVMAP\n\t\t\t\t\t\tgl_FragColor = envColor;\n\t\t\t\t\t#else\n\t\t\t\t\t\tgl_FragColor = vec4(1., 1., 1., 1.);\n\t\t\t\t\t#endif\n\n\t\t\t\t\t\n\n\t\t\t\t\tgl_FragColor.rgb *= uMultiplier;\n\t\t\t\t\t#include <tonemapping_fragment>\n\t\t\t\t\t#include <encodings_fragment>\n\t\t\t\t}\n\t\t\t", side : three_Side.DoubleSide, depthWrite : false, depthTest : true, blending : three_Blending.NoBlending});
		this.uRoughness = uRoughness;
		this.uFlipEnvMap = uFlipEnvMap;
		this.uEnvMap = uEnvMap;
		this.uMultiplier = uMultiplier;
		uRoughness.value = roughness;
	}
}
rendering_EnvironmentMaterial.__name__ = true;
var three_Uniform = require("three").Uniform;
var three_Color = require("three").Color;
var Three = require("three");
var three_Side = require("three");
var three_Blending = require("three");
var three_BufferGeometry = require("three").BufferGeometry;
var three_BoxGeometry = require("three").BoxGeometry;
var three_PerspectiveCamera = require("three").PerspectiveCamera;
var ui_ExposedGUI = require("dat.gui").GUI;
class ui_DevUI extends ui_ExposedGUI {
	constructor(options) {
		super(options);
		let styleEl = window.document.createElement("style");
		styleEl.innerHTML = ".dg .title {\n\t\t\toverflow: hidden;\n\t\t\twhite-space: nowrap;\n\t\t}";
		window.document.head.appendChild(styleEl);
	}
	addFolder(name) {
		return super.addFolder(name);
	}
	internalAddMaterial(material,fallbackName) {
		let name = material.name == null || material.name == "" ? fallbackName : material.name;
		while(Object.prototype.hasOwnProperty.call(this.__folders,name)) {
			let endNumReg = new EReg("(\\d)+$","");
			if(endNumReg.match(name)) {
				let num = Std.parseInt(endNumReg.matched(1));
				name = endNumReg.matchedRight() + Std.string(num + 1);
			} else {
				name += "2";
			}
		}
		let g = this.addFolder(name);
		let m = material;
		let type = "Material";
		let o = { };
		Object.defineProperty(o,"visible",{ set : function(__value) {
			m.visible = __value;
		}, get : function() {
			return m.visible;
		}});
		g.add(o,"visible").name("visible");
		let o1 = { };
		Object.defineProperty(o1,"transparent",{ set : function(__value) {
			m.transparent = __value;
		}, get : function() {
			return m.transparent;
		}});
		g.add(o1,"transparent").name("transparent");
		let o2 = { };
		Object.defineProperty(o2,"opacity",{ set : function(__value) {
			m.opacity = __value;
		}, get : function() {
			return m.opacity;
		}});
		let c = g.add(o2,"opacity").name("opacity");
		c = c.min(0);
		c = c.max(1);
		let o3 = { };
		Object.defineProperty(o3,"colorWrite",{ set : function(__value) {
			m.colorWrite = __value;
		}, get : function() {
			return m.colorWrite;
		}});
		g.add(o3,"colorWrite").name("colorWrite");
		let o4 = { };
		Object.defineProperty(o4,"depthWrite",{ set : function(__value) {
			m.depthWrite = __value;
		}, get : function() {
			return m.depthWrite;
		}});
		g.add(o4,"depthWrite").name("depthWrite");
		let o5 = { };
		Object.defineProperty(o5,"depthTest",{ set : function(__value) {
			m.depthTest = __value;
		}, get : function() {
			return m.depthTest;
		}});
		g.add(o5,"depthTest").name("depthTest");
		if(((m) instanceof three_MeshBasicMaterial)) {
			let m1 = m;
			let color = m1.color;
			if(color == null) {
				color = new three_Color();
				m1.color = color;
			}
			g.addColor({ c : color.getHex()},"c").name("color").onChange(function(hex) {
				return color.setHex(hex);
			});
		}
		if(((m) instanceof three_MeshStandardMaterial) || ((m) instanceof material_CustomPhysicalMaterial)) {
			type = "MeshStandardMaterial";
			let m1 = m;
			let o = { };
			Object.defineProperty(o,"flatShading",{ set : function(__value) {
				m1.flatShading = __value;
			}, get : function() {
				return m1.flatShading;
			}});
			g.add(o,"flatShading").name("flatShading").onChange(function(_) {
				return m1.needsUpdate = true;
			});
			let o1 = { };
			Object.defineProperty(o1,"roughness",{ set : function(__value) {
				m1.roughness = __value;
			}, get : function() {
				return m1.roughness;
			}});
			let c = g.add(o1,"roughness").name("roughness");
			c = c.min(0);
			c = c.max(1);
			let o2 = { };
			Object.defineProperty(o2,"metalness",{ set : function(__value) {
				m1.metalness = __value;
			}, get : function() {
				return m1.metalness;
			}});
			let c1 = g.add(o2,"metalness").name("metalness");
			c1 = c1.min(0);
			c1 = c1.max(1);
			let o3 = { };
			Object.defineProperty(o3,"emissiveIntensity",{ set : function(__value) {
				m1.emissiveIntensity = __value;
			}, get : function() {
				return m1.emissiveIntensity;
			}});
			let c2 = g.add(o3,"emissiveIntensity").name("emissiveIntensity");
			c2 = c2.min(0);
			c2 = c2.max(20);
			let color = m1.color;
			if(color == null) {
				color = new three_Color();
				m1.color = color;
			}
			g.addColor({ c : color.getHex()},"c").name("color").onChange(function(hex) {
				return color.setHex(hex);
			});
			let color1 = m1.emissive;
			if(color1 == null) {
				color1 = new three_Color();
				m1.emissive = color1;
			}
			g.addColor({ c : color1.getHex()},"c").name("emissive").onChange(function(hex) {
				return color1.setHex(hex);
			});
			let names = ["FrontSide","BackSide","DoubleSide"];
			let values = [three_Side.FrontSide,three_Side.BackSide,three_Side.DoubleSide];
			let obj = { };
			let _g = 0;
			let _g1 = names.length;
			while(_g < _g1) {
				let i = _g++;
				obj[names[i]] = i;
			}
			let o4 = { };
			Object.defineProperty(o4,"side",{ set : function(__index) {
				m1.side = values[__index | 0];
			}, get : function() {
				return m1.side;
			}});
			g.add(o4,"side",obj).name("side").onChange(function(_) {
				return m1.needsUpdate = true;
			});
			let o5 = { };
			Object.defineProperty(o5,"envMapIntensity",{ set : function(__value) {
				m1.envMapIntensity = __value;
			}, get : function() {
				return m1.envMapIntensity;
			}});
			let c3 = g.add(o5,"envMapIntensity").name("envMapIntensity");
			c3 = c3.min(0);
			c3 = c3.max(4);
			let o6 = { };
			Object.defineProperty(o6,"aoMapIntensity",{ set : function(__value) {
				m1.aoMapIntensity = __value;
			}, get : function() {
				return m1.aoMapIntensity;
			}});
			let c4 = g.add(o6,"aoMapIntensity").name("aoMapIntensity");
			c4 = c4.min(0);
			c4 = c4.max(4);
		}
		if(((m) instanceof three_MeshPhysicalMaterial)) {
			type = "MeshPhysicalMaterial";
			let m1 = m;
			let o = { };
			Object.defineProperty(o,"clearcoat",{ set : function(__value) {
				m1.clearcoat = __value;
			}, get : function() {
				return m1.clearcoat;
			}});
			let c = g.add(o,"clearcoat").name("clearcoat");
			c = c.min(0);
			c = c.max(1);
			let o1 = { };
			Object.defineProperty(o1,"clearcoatRoughness",{ set : function(__value) {
				m1.clearcoatRoughness = __value;
			}, get : function() {
				return m1.clearcoatRoughness;
			}});
			let c1 = g.add(o1,"clearcoatRoughness").name("clearcoatRoughness");
			c1 = c1.min(0);
			c1 = c1.max(1);
			let o2 = { };
			Object.defineProperty(o2,"transmission",{ set : function(__value) {
				m1.transmission = __value;
			}, get : function() {
				return m1.transmission;
			}});
			let c2 = g.add(o2,"transmission").name("transmission");
			c2 = c2.min(0);
			c2 = c2.max(1);
			let o3 = { };
			Object.defineProperty(o3,"ior",{ set : function(__value) {
				m1.ior = __value;
			}, get : function() {
				return m1.ior;
			}});
			let c3 = g.add(o3,"ior").name("ior");
			c3 = c3.min(0);
			c3 = c3.max(3);
			let o4 = { };
			Object.defineProperty(o4,"thickness",{ set : function(__value) {
				m1.thickness = __value;
			}, get : function() {
				return m1.thickness;
			}});
			let c4 = g.add(o4,"thickness").name("thickness");
			c4 = c4.min(0);
			c4 = c4.max(3);
			let color = m1.attenuationColor;
			if(color == null) {
				color = new three_Color();
				m1.attenuationColor = color;
			}
			g.addColor({ c : color.getHex()},"c").name("attenuationColor").onChange(function(hex) {
				return color.setHex(hex);
			});
			let o5 = { };
			Object.defineProperty(o5,"attenuationDistance",{ set : function(__value) {
				m1.attenuationDistance = __value;
			}, get : function() {
				return m1.attenuationDistance;
			}});
			let c5 = g.add(o5,"attenuationDistance").name("attenuationDistance");
			c5 = c5.min(0);
			c5 = c5.max(10);
			let o6 = { };
			Object.defineProperty(o6,"sheen",{ set : function(__value) {
				m1.sheen = __value;
			}, get : function() {
				return m1.sheen;
			}});
			let c6 = g.add(o6,"sheen").name("sheen");
			c6 = c6.min(0);
			c6 = c6.max(1);
			let o7 = { };
			Object.defineProperty(o7,"sheenRoughness",{ set : function(__value) {
				m1.sheenRoughness = __value;
			}, get : function() {
				return m1.sheenRoughness;
			}});
			let c7 = g.add(o7,"sheenRoughness").name("sheenRoughness");
			c7 = c7.min(0);
			c7 = c7.max(1);
			let color1 = m1.sheenColor;
			if(color1 == null) {
				color1 = new three_Color();
				m1.sheenColor = color1;
			}
			g.addColor({ c : color1.getHex()},"c").name("sheenColor").onChange(function(hex) {
				return color1.setHex(hex);
			});
		} else if(((m) instanceof material_CustomPhysicalMaterial)) {
			type = "CustomPhysicalMaterial";
			let m1 = m;
			let o = { };
			Object.defineProperty(o,"clearcoat",{ set : function(__value) {
				let v = __value;
				if(m1.clearcoat > 0 != v > 0) {
					m1.version++;
				}
				m1.clearcoat = v;
			}, get : function() {
				return m1.clearcoat;
			}});
			let c = g.add(o,"clearcoat").name("clearcoat");
			c = c.min(0);
			c = c.max(1);
			let o1 = { };
			Object.defineProperty(o1,"clearcoatRoughness",{ set : function(__value) {
				m1.clearcoatRoughness = __value;
			}, get : function() {
				return m1.clearcoatRoughness;
			}});
			let c1 = g.add(o1,"clearcoatRoughness").name("clearcoatRoughness");
			c1 = c1.min(0);
			c1 = c1.max(1);
			let o2 = { };
			Object.defineProperty(o2,"transmission",{ set : function(__value) {
				let v = __value;
				if(m1.transmission > 0 != v > 0) {
					m1.version++;
				}
				m1.transmission = v;
			}, get : function() {
				return m1.transmission;
			}});
			let c2 = g.add(o2,"transmission").name("transmission");
			c2 = c2.min(0);
			c2 = c2.max(1);
			let o3 = { };
			Object.defineProperty(o3,"ior",{ set : function(__value) {
				m1.ior = __value;
			}, get : function() {
				return m1.ior;
			}});
			let c3 = g.add(o3,"ior").name("ior");
			c3 = c3.min(0);
			c3 = c3.max(3);
			let o4 = { };
			Object.defineProperty(o4,"thickness",{ set : function(__value) {
				m1.thickness = __value;
			}, get : function() {
				return m1.thickness;
			}});
			let c4 = g.add(o4,"thickness").name("thickness");
			c4 = c4.min(0);
			c4 = c4.max(4);
			let color = m1.attenuationColor;
			if(color == null) {
				color = new three_Color();
				m1.attenuationColor = color;
			}
			g.addColor({ c : color.getHex()},"c").name("attenuationColor").onChange(function(hex) {
				return color.setHex(hex);
			});
			let o5 = { };
			Object.defineProperty(o5,"attenuationDistance",{ set : function(__value) {
				m1.attenuationDistance = __value;
			}, get : function() {
				return m1.attenuationDistance;
			}});
			let c5 = g.add(o5,"attenuationDistance").name("attenuationDistance");
			c5 = c5.min(0);
			c5 = c5.max(10);
			let o6 = { };
			Object.defineProperty(o6,"sheen",{ set : function(__value) {
				let v = __value;
				if(m1.sheen > 0 != v > 0) {
					m1.version++;
				}
				m1.sheen = v;
			}, get : function() {
				return m1.sheen;
			}});
			let c6 = g.add(o6,"sheen").name("sheen");
			c6 = c6.min(0);
			c6 = c6.max(1);
			let o7 = { };
			Object.defineProperty(o7,"sheenRoughness",{ set : function(__value) {
				m1.sheenRoughness = __value;
			}, get : function() {
				return m1.sheenRoughness;
			}});
			let c7 = g.add(o7,"sheenRoughness").name("sheenRoughness");
			c7 = c7.min(0);
			c7 = c7.max(1);
			let color1 = m1.sheenColor;
			if(color1 == null) {
				color1 = new three_Color();
				m1.sheenColor = color1;
			}
			g.addColor({ c : color1.getHex()},"c").name("sheenColor").onChange(function(hex) {
				return color1.setHex(hex);
			});
		}
		g.name = "" + name + " :" + type;
		return g;
	}
}
ui_DevUI.__name__ = true;
var three_WebGLRenderer = require("three").WebGLRenderer;
var three_TextureEncoding = require("three");
var three_ToneMapping = require("three");
class Std {
	static string(s) {
		return js_Boot.__string_rec(s,"");
	}
	static parseInt(x) {
		if(x != null) {
			let _g = 0;
			let _g1 = x.length;
			while(_g < _g1) {
				let i = _g++;
				let c = x.charCodeAt(i);
				if(c <= 8 || c >= 14 && c != 32 && c != 45) {
					let nc = x.charCodeAt(i + 1);
					let v = parseInt(x,nc == 120 || nc == 88 ? 16 : 10);
					if(isNaN(v)) {
						return null;
					} else {
						return v;
					}
				}
			}
		}
		return null;
	}
}
Std.__name__ = true;
class js_Boot {
	static __string_rec(o,s) {
		if(o == null) {
			return "null";
		}
		if(s.length >= 5) {
			return "<...>";
		}
		let t = typeof(o);
		if(t == "function" && (o.__name__ || o.__ename__)) {
			t = "object";
		}
		switch(t) {
		case "function":
			return "<function>";
		case "object":
			if(((o) instanceof Array)) {
				let str = "[";
				s += "\t";
				let _g = 0;
				let _g1 = o.length;
				while(_g < _g1) {
					let i = _g++;
					str += (i > 0 ? "," : "") + js_Boot.__string_rec(o[i],s);
				}
				str += "]";
				return str;
			}
			let tostr;
			try {
				tostr = o.toString;
			} catch( _g ) {
				return "???";
			}
			if(tostr != null && tostr != Object.toString && typeof(tostr) == "function") {
				let s2 = o.toString();
				if(s2 != "[object Object]") {
					return s2;
				}
			}
			let str = "{\n";
			s += "\t";
			let hasp = o.hasOwnProperty != null;
			let k = null;
			for( k in o ) {
			if(hasp && !o.hasOwnProperty(k)) {
				continue;
			}
			if(k == "prototype" || k == "__class__" || k == "__super__" || k == "__interfaces__" || k == "__properties__") {
				continue;
			}
			if(str.length != 2) {
				str += ", \n";
			}
			str += s + k + " : " + js_Boot.__string_rec(o[k],s);
			}
			s = s.substring(1);
			str += "\n" + s + "}";
			return str;
		case "string":
			return o;
		default:
			return String(o);
		}
	}
}
js_Boot.__name__ = true;
var three_Scene = require("three").Scene;
class environment_EnvironmentManager {
	constructor(renderer,scene,path,onEnvironmentLoaded) {
		this._environmentPath = null;
		this.renderer = renderer;
		this.scene = scene;
		this.onEnvironmentLoaded = onEnvironmentLoaded != null ? onEnvironmentLoaded : function(_) {
		};
		this.environmentSun = new three_DirectionalLight(16777215,0);
		this.environmentSun.castShadow = true;
		this.environmentSun.shadow.bias = -0.001;
		this.environmentSun.shadow.radius = 7;
		this.environmentSun.layers.enable(1);
		this.environmentSun.visible = false;
		scene.add(this.environmentSun);
		this.environmentAmbient = new three_AmbientLight(0,1);
		this.environmentAmbient.visible = false;
		scene.add(this.environmentAmbient);
		this.setEnvironmentMapPath(path);
	}
	setEnvironmentMapPath(path,onLoaded,onError) {
		if(path == this.get_environmentPath()) {
			return;
		}
		if(onLoaded == null) {
			onLoaded = function(e) {
			};
		}
		if(onError == null) {
			onError = function(e) {
				$global.console.error(e);
			};
		}
		this._environmentPath = path;
		let _gthis = this;
		if(path != null) {
			let ext = haxe_io_Path.extension(path);
			switch(ext.toLowerCase()) {
			case "hdr":
				let iblGenerator = new tool_IBLGenerator(this.renderer);
				iblGenerator.compileEquirectangularShader();
				new three_examples_jsm_loaders_rgbeloader_RGBELoader().setDataType(three_TextureDataType.FloatType).load(path,function(texture,texData) {
					if(_gthis._pmremRenderTarget != null) {
						_gthis._pmremRenderTarget.dispose();
					}
					_gthis._pmremRenderTarget = iblGenerator.fromEquirectangular(texture);
					iblGenerator.dispose();
					_gthis._pmremRenderTarget.texture.sourceFile = path;
					_gthis.setEnvironmentMap(_gthis._pmremRenderTarget.texture);
					onLoaded(_gthis._pmremRenderTarget.texture);
					_gthis.onEnvironmentLoaded(_gthis._pmremRenderTarget.texture);
				});
				break;
			case "png":
				new three_TextureLoader().load(path,function(texture) {
					texture.minFilter = three_TextureFilter.NearestFilter;
					texture.magFilter = three_TextureFilter.NearestFilter;
					texture.type = three_TextureDataType.UnsignedByteType;
					texture.format = three_PixelFormat.RGBEFormat;
					texture.encoding = three_TextureEncoding.RGBDEncoding;
					texture.mapping = three_Mapping.CubeUVReflectionMapping;
					texture.generateMipmaps = false;
					texture.flipY = false;
					texture.sourceFile = path;
					_gthis.setEnvironmentMap(texture);
					onLoaded(texture);
					_gthis.onEnvironmentLoaded(texture);
				});
				break;
			default:
				let error = "Unknown environment extension " + ext;
				$global.console.error(error);
				onError(error);
			}
		}
	}
	setEnvironmentMap(texture) {
		if(this.scene.environment != null) {
			this.scene.environment.dispose();
		}
		this.scene.environment = texture;
	}
	downloadPmremEnvironmentMap() {
		let document = window.document;
		let renderTarget = this._pmremRenderTarget;
		let environmentPath = this.get_environmentPath();
		if(renderTarget != null && environmentPath != null) {
			let w = renderTarget.width | 0;
			let h = renderTarget.height | 0;
			let byteCount = w * h * 4 | 0;
			let buffer = new Uint8ClampedArray(byteCount);
			this.renderer.readRenderTargetPixels(renderTarget,0,0,w,h,buffer);
			let pngCanvas = document.createElement("canvas");
			pngCanvas.width = w;
			pngCanvas.height = h;
			let ctx = pngCanvas.getContext("2d",null);
			let rgbaData = new ImageData(buffer,w,h);
			ctx.putImageData(rgbaData,0,0);
			let encodingName;
			switch(renderTarget.texture.encoding) {
			case three_TextureEncoding.RGBDEncoding:
				encodingName = "rgbd";
				break;
			case three_TextureEncoding.RGBEEncoding:
				encodingName = "rgbe";
				break;
			case three_TextureEncoding.RGBM16Encoding:
				encodingName = "rgbm17";
				break;
			case three_TextureEncoding.RGBM7Encoding:
				encodingName = "rgbm7";
				break;
			default:
				encodingName = null;
			}
			let filename = haxe_io_Path.withoutDirectory(haxe_io_Path.withoutExtension(environmentPath)) + (encodingName != null ? "." + encodingName : "") + ("." + "png");
			pngCanvas.toBlob(function(blob) {
				let a = document.createElement("a");
				document.body.appendChild(a);
				a.style.display = "none";
				let url = URL.createObjectURL(blob);
				a.href = url;
				a.download = filename;
				a.click();
				URL.revokeObjectURL(url);
			},"image/" + "png",1);
		} else {
			console.log("environment/EnvironmentManager.hx:150:","No environment map");
		}
	}
	set_environmentPath(v) {
		this.setEnvironmentMapPath(v);
		return v;
	}
	get_environmentPath() {
		return this._environmentPath;
	}
}
environment_EnvironmentManager.__name__ = true;
var three_DirectionalLight = require("three").DirectionalLight;
var three_AmbientLight = require("three").AmbientLight;
var three_BufferAttribute = require("three").BufferAttribute;
class objects_ClipSpaceTriangle extends three_Mesh {
	constructor(material) {
		super(objects_ClipSpaceTriangle.globalGeom,material);
		this.frustumCulled = false;
		this.castShadow = false;
		this.receiveShadow = false;
	}
}
objects_ClipSpaceTriangle.__name__ = true;
function Main_main() {
	window.document.body.appendChild(Main_canvas);
	Main_scene.add(Main_background);
	let torusKnotMesh = new three_Mesh(new three_TorusKnotGeometry(0.4,0.1,200,50,2,4),new three_MeshPhysicalMaterial({ roughness : 0.4, metalness : 1.0, color : 2460782, clearcoat : 1.0, side : three_Side.FrontSide}));
	torusKnotMesh.position.x = -1;
	Main_scene.add(torusKnotMesh);
	Main_devUI.internalAddMaterial(torusKnotMesh.material,"material");
	Main_animationFrame(window.performance.now());
}
function Main_animationFrame(time_ms) {
	let time_s = time_ms / 1000;
	let dt_ms = Main_animationFrame_lastTime_ms > 0 ? time_ms - Main_animationFrame_lastTime_ms : 0.0;
	if(dt_ms < 1) {
		dt_ms = 1;
	} else if(dt_ms > 33.3333333333333357) {
		dt_ms = 33.3333333333333357;
	}
	let dt_s = dt_ms / 1000;
	Main_animationFrame_lastTime_ms = time_ms;
	Main_uTime_s.value = time_s;
	let gl = Main_renderer.getContext();
	let x = window.innerWidth;
	let y = window.innerHeight;
	let b = Main_pixelRatio;
	let x1 = Math.floor(x * b);
	let y1 = Math.floor(y * b);
	if(!(x1 == gl.drawingBufferWidth && y1 == gl.drawingBufferHeight)) {
		Main_canvas.width = Math.floor(x1);
		Main_canvas.height = Math.floor(y1);
	}
	let newAspect = x1 / y1;
	if(Main_camera.aspect != newAspect) {
		Main_camera.aspect = newAspect;
		Main_camera.updateProjectionMatrix();
	}
	Main_update(time_s,dt_s);
	Main_renderer.setRenderTarget(null);
	Main_renderer.setViewport(0,0,gl.drawingBufferWidth,gl.drawingBufferHeight);
	Main_renderer.clear(true,true,true);
	Main_renderer.render(Main_scene,Main_camera);
	Main_renderTargetParametersNeedUpdate = false;
	window.requestAnimationFrame(Main_animationFrame);
}
function Main_update(time_s,dt_s) {
	let _this = Main_arcBallControl;
	_this.angleAroundY.step(dt_s);
	_this.angleAroundXZ.step(dt_s);
	_this.axialRotation.step(dt_s);
	_this.radius.step(dt_s);
	_this.position.x = _this.radius.value * Math.sin(_this.angleAroundY.value) * Math.cos(_this.angleAroundXZ.value);
	_this.position.z = _this.radius.value * Math.cos(_this.angleAroundY.value) * Math.cos(_this.angleAroundXZ.value);
	_this.position.y = _this.radius.value * Math.sin(_this.angleAroundXZ.value);
	let this1 = _this.position;
	let v = this1;
	let lenSq = v.x * this1.x + v.y * this1.y + v.z * this1.z;
	let denominator = lenSq == 0.0 ? 1.0 : Math.sqrt(lenSq);
	let angle = _this.axialRotation.value;
	let sa = Math.sin(angle * 0.5);
	let x = v.x / denominator * sa;
	let y = v.y / denominator * sa;
	let z = v.z / denominator * sa;
	let w = Math.cos(angle * 0.5);
	let axis_x = 0;
	let axis_y = 1;
	let axis_z = 0;
	let angle1 = _this.angleAroundY.value;
	let sa1 = Math.sin(angle1 * 0.5);
	let x1 = axis_x * sa1;
	let y1 = axis_y * sa1;
	let z1 = axis_z * sa1;
	let w1 = Math.cos(angle1 * 0.5);
	let axis_x1 = 1;
	let axis_y1 = 0;
	let axis_z1 = 0;
	let angle2 = -_this.angleAroundXZ.value;
	let sa2 = Math.sin(angle2 * 0.5);
	let x2 = axis_x1 * sa2;
	let y2 = axis_y1 * sa2;
	let z2 = axis_z1 * sa2;
	let w2 = Math.cos(angle2 * 0.5);
	let this2 = _this.orientation;
	let x3 = x1 * w2 + y1 * z2 - z1 * y2 + w1 * x2;
	let y3 = -x1 * z2 + y1 * w2 + z1 * x2 + w1 * y2;
	let z3 = x1 * y2 - y1 * x2 + z1 * w2 + w1 * z2;
	let w3 = -x1 * x2 - y1 * y2 - z1 * z2 + w1 * w2;
	this2.x = x * w3 + y * z3 - z * y3 + w * x3;
	this2.y = -x * z3 + y * w3 + z * x3 + w * y3;
	this2.z = x * y3 - y * x3 + z * w3 + w * z3;
	this2.w = -x * x3 - y * y3 - z * z3 + w * w3;
	Main_arcBallControl.applyToCamera(Main_camera);
}
function Main_initDevUI() {
	let gui = new ui_DevUI({ closed : false});
	gui.domElement.style.userSelect = "none";
	gui.domElement.parentElement.style.zIndex = "1000";
	let g = gui.addFolder("Rendering");
	let o = { };
	Object.defineProperty(o,"pixelRatio",{ set : function(__value) {
		Main_pixelRatio = __value;
	}, get : function() {
		return Main_pixelRatio;
	}});
	let c = g.add(o,"pixelRatio").name("pixelRatio");
	c = c.min(0.1);
	c = c.max(4);
	c.name("resolution");
	let o1 = { };
	Object.defineProperty(o1,"fov",{ set : function(__value) {
		Main_camera.fov = __value;
	}, get : function() {
		return Main_camera.fov;
	}});
	let c1 = g.add(o1,"fov").name("fov");
	c1 = c1.min(1);
	c1 = c1.max(200);
	c1.onChange(function(_) {
		Main_camera.updateProjectionMatrix();
	});
	let renderer = Main_renderer;
	let names = ["NoToneMapping","LinearToneMapping","ReinhardToneMapping","CineonToneMapping","ACESFilmicToneMapping"];
	let values = [three_ToneMapping.NoToneMapping,three_ToneMapping.LinearToneMapping,three_ToneMapping.ReinhardToneMapping,three_ToneMapping.CineonToneMapping,three_ToneMapping.ACESFilmicToneMapping];
	let obj = { };
	let _g = 0;
	let _g1 = names.length;
	while(_g < _g1) {
		let i = _g++;
		obj[names[i]] = i;
	}
	let o2 = { };
	Object.defineProperty(o2,"toneMapping",{ set : function(__index) {
		renderer.toneMapping = values[__index | 0];
	}, get : function() {
		return renderer.toneMapping;
	}});
	g.add(o2,"toneMapping",obj).name("toneMapping").onChange(function(v) {
		let outputEncoding = renderer.outputEncoding;
		renderer.outputEncoding = null;
		return window.requestAnimationFrame(function(t) {
			renderer.outputEncoding = outputEncoding;
		});
	});
	let names1 = ["LinearEncoding","sRGBEncoding","GammaEncoding","RGBEEncoding","LogLuvEncoding","RGBM7Encoding","RGBM16Encoding","RGBDEncoding"];
	let values1 = [three_TextureEncoding.LinearEncoding,three_TextureEncoding.sRGBEncoding,three_TextureEncoding.GammaEncoding,three_TextureEncoding.RGBEEncoding,three_TextureEncoding.LogLuvEncoding,three_TextureEncoding.RGBM7Encoding,three_TextureEncoding.RGBM16Encoding,three_TextureEncoding.RGBDEncoding];
	let obj1 = { };
	let _g2 = 0;
	let _g3 = names1.length;
	while(_g2 < _g3) {
		let i = _g2++;
		obj1[names1[i]] = i;
	}
	let o3 = { };
	Object.defineProperty(o3,"outputEncoding",{ set : function(__index) {
		renderer.outputEncoding = values1[__index | 0];
	}, get : function() {
		return renderer.outputEncoding;
	}});
	g.add(o3,"outputEncoding",obj1).name("outputEncoding");
	let o4 = { };
	Object.defineProperty(o4,"toneMappingExposure",{ set : function(__value) {
		renderer.toneMappingExposure = __value;
	}, get : function() {
		return renderer.toneMappingExposure;
	}});
	let c2 = g.add(o4,"toneMappingExposure").name("toneMappingExposure");
	c2 = c2.min(0);
	c2 = c2.max(4);
	let o5 = { };
	Object.defineProperty(o5,"enabled",{ set : function(__value) {
		renderer.shadowMap.enabled = __value;
	}, get : function() {
		return renderer.shadowMap.enabled;
	}});
	g.add(o5,"enabled").name("enabled").name("Shadows");
	let o6 = { };
	Object.defineProperty(o6,"roughness",{ set : function(__value) {
		Main_background.material.uRoughness.value = __value;
	}, get : function() {
		return Main_background.material.uRoughness.value;
	}});
	let c3 = g.add(o6,"roughness").name("roughness");
	c3 = c3.min(0);
	c3 = c3.max(1);
	let options = ["assets/env/hilly_terrain_01_1k.rgbd.png","assets/env/snowy_park_01_1k.rgbd.png","assets/env/birchwood_2k.rgbd.png","assets/env/winter_lake_01_1k.rgbd.png","assets/env/snowy_forest_path_01_1k.rgbd.png","assets/env/night_bridge_2k.rgbd.png","assets/env/kiara_1_dawn_2k.rgbd.png","assets/env/venice_sunset_2k.rgbd.png","assets/env/blouberg_sunrise_1_2k.rgbd.png","assets/env/the_sky_is_on_fire_2k.rgbd.png"];
	let _this = options;
	let result = new Array(_this.length);
	let _g4 = 0;
	let _g11 = _this.length;
	while(_g4 < _g11) {
		let i = _g4++;
		result[i] = Std.string(_this[i]);
	}
	let values2 = options;
	let obj2 = { };
	let _g5 = 0;
	let _g6 = result.length;
	while(_g5 < _g6) {
		let i = _g5++;
		obj2[result[i]] = i;
	}
	let o7 = { };
	Object.defineProperty(o7,"environmentPath",{ set : function(__index) {
		Main_environmentManager.set_environmentPath(values2[__index | 0]);
	}, get : function() {
		return Main_environmentManager.get_environmentPath();
	}});
	g.add(o7,"environmentPath",obj2).name("environmentPath");
	g.add({ "fn" : function() {
		Main_environmentManager.downloadPmremEnvironmentMap();
	}},"fn").name("() -> environmentManager.downloadPmremEnvironmentMap()").name("Download Env .png");
	let g1 = gui.addFolder("Controls");
	let c4 = Main_arcBallControl;
	let o8 = { };
	Object.defineProperty(o8,"dragSpeed",{ set : function(__value) {
		c4.dragSpeed = __value;
	}, get : function() {
		return c4.dragSpeed;
	}});
	let c5 = g1.add(o8,"dragSpeed").name("dragSpeed");
	c5 = c5.min(0);
	c5 = c5.max(15);
	let o9 = { };
	Object.defineProperty(o9,"zoomSpeed",{ set : function(__value) {
		c4.zoomSpeed = __value;
	}, get : function() {
		return c4.zoomSpeed;
	}});
	let c6 = g1.add(o9,"zoomSpeed").name("zoomSpeed");
	c6 = c6.min(0);
	c6 = c6.max(20);
	let o10 = { };
	Object.defineProperty(o10,"strength",{ set : function(__value) {
		let v = __value;
		c4.angleAroundY.strength = v;
		c4.angleAroundXZ.strength = v;
		c4.radius.strength = v;
	}, get : function() {
		return c4.angleAroundY.strength;
	}});
	let c7 = g1.add(o10,"strength").name("strength");
	c7 = c7.min(0);
	c7 = c7.max(1000);
	let o11 = { };
	Object.defineProperty(o11,"damping",{ set : function(__value) {
		let v = __value;
		c4.angleAroundY.damping = v;
		c4.angleAroundXZ.damping = v;
		c4.radius.damping = v;
	}, get : function() {
		return c4.angleAroundY.damping;
	}});
	let c8 = g1.add(o11,"damping").name("damping");
	c8 = c8.min(0);
	c8 = c8.max(200);
	return gui;
}
class Reflect {
	static field(o,field) {
		try {
			return o[field];
		} catch( _g ) {
			return null;
		}
	}
	static fields(o) {
		let a = [];
		if(o != null) {
			let hasOwnProperty = Object.prototype.hasOwnProperty;
			for( var f in o ) {
			if(f != "__id__" && f != "hx__closures__" && hasOwnProperty.call(o,f)) {
				a.push(f);
			}
			}
		}
		return a;
	}
}
Reflect.__name__ = true;
function Structure_extendAny(base,extendWidth) {
	let extended = { };
	if(base != null) {
		let _g = 0;
		let _g1 = Reflect.fields(base);
		while(_g < _g1.length) {
			let field = _g1[_g];
			++_g;
			extended[field] = Reflect.field(base,field);
		}
	}
	if(extendWidth != null) {
		let _g = 0;
		let _g1 = Reflect.fields(extendWidth);
		while(_g < _g1.length) {
			let field = _g1[_g];
			++_g;
			extended[field] = Reflect.field(extendWidth,field);
		}
	}
	return extended;
}
class Vec2Data {
	constructor(x,y) {
		this.x = x;
		this.y = y;
	}
}
Vec2Data.__name__ = true;
class Vec3Data {
	constructor(x,y,z) {
		this.x = x;
		this.y = y;
		this.z = z;
	}
}
Vec3Data.__name__ = true;
class Vec4Data {
	constructor(x,y,z,w) {
		this.x = x;
		this.y = y;
		this.z = z;
		this.w = w;
	}
}
Vec4Data.__name__ = true;
class animator_Spring {
	constructor(initialValue,target,strength,damping,velocity,onUpdate) {
		if(velocity == null) {
			velocity = 0.0;
		}
		if(damping == null) {
			damping = 18;
		}
		if(strength == null) {
			strength = 80;
		}
		this.minEnergyThreshold = 1e-5;
		this.value = initialValue;
		this.target = target == null ? initialValue : target;
		this.strength = strength;
		this.damping = damping;
		this.velocity = velocity;
		this.onUpdate = onUpdate;
	}
	step(dt_s) {
		let V0 = this.velocity;
		let X0 = this.value - this.target;
		if(X0 == 0 && V0 == 0 || dt_s == 0) {
			return;
		}
		let k = this.strength;
		let b = this.damping;
		let totalEnergy = 0.5 * V0 * V0 + 0.5 * k * X0 * X0;
		if(totalEnergy < this.minEnergyThreshold) {
			this.velocity = 0;
			this.value = this.target;
		} else {
			let critical = k * 4 - b * b;
			if(critical > 0) {
				let q = 0.5 * Math.sqrt(critical);
				let B = (b * X0 * 0.5 + V0) / q;
				let m = Math.exp(-b * 0.5 * dt_s);
				let c = Math.cos(q * dt_s);
				let s = Math.sin(q * dt_s);
				let x1 = m * (X0 * c + B * s);
				let v1 = m * ((B * q - 0.5 * X0 * b) * c + (-X0 * q - 0.5 * b * B) * s);
				this.velocity = v1;
				this.value = x1 + this.target;
			} else if(critical < 0) {
				let u = 0.5 * Math.sqrt(-critical);
				let p = -0.5 * b + u;
				let n = -0.5 * b - u;
				let B = -(n * X0 - V0) / (2 * u);
				let A = X0 - B;
				let ep = Math.exp(p * dt_s);
				let en = Math.exp(n * dt_s);
				let x1 = A * en + B * ep;
				let v1 = A * n * en + B * p * ep;
				this.velocity = v1;
				this.value = x1 + this.target;
			} else {
				let w = Math.sqrt(k);
				let B = V0 + w * X0;
				let e = Math.exp(-w * dt_s);
				let x1 = (X0 + B * dt_s) * e;
				let v1 = (B - w * (X0 + B * dt_s)) * e;
				this.velocity = v1;
				this.value = x1 + this.target;
			}
		}
		if(this.onUpdate != null) {
			this.onUpdate(this.value,this.velocity);
		}
	}
	forceCompletion(v) {
		if(v != null) {
			this.target = v;
		}
		this.value = this.target;
		this.velocity = 0;
		if(this.onUpdate != null) {
			this.onUpdate(this.value,this.velocity);
		}
	}
}
animator_Spring.__name__ = true;
class app_event_KeyboardEvent {
}
app_event_KeyboardEvent.__name__ = true;
class app_event_PointerEvent {
	constructor(pointerId,pointerType,isPrimary,button,buttons,x,y,width,height,viewWidth,viewHeight,pressure,tangentialPressure,tiltX,tiltY,twist) {
		this.pointerId = pointerId;
		this.pointerType = pointerType;
		this.isPrimary = isPrimary;
		this.button = button;
		this.buttons = buttons;
		this.x = x;
		this.y = y;
		this.width = width;
		this.height = height;
		this.viewWidth = viewWidth;
		this.viewHeight = viewHeight;
		this.pressure = pressure;
		this.tangentialPressure = tangentialPressure;
		this.tiltX = tiltX;
		this.tiltY = tiltY;
		this.twist = twist;
	}
}
app_event_PointerEvent.__name__ = true;
class app_event_WheelEvent {
	constructor(deltaX,deltaY,deltaZ,x,y,altKey,ctrlKey,metaKey,shiftKey,nativeEvent) {
		this.deltaX = deltaX;
		this.deltaY = deltaY;
		this.deltaZ = deltaZ;
		this.x = x;
		this.y = y;
		this.altKey = altKey;
		this.ctrlKey = ctrlKey;
		this.metaKey = metaKey;
		this.shiftKey = shiftKey;
		this.nativeEvent = nativeEvent;
	}
}
app_event_WheelEvent.__name__ = true;
class haxe_Exception extends Error {
	constructor(message,previous,native) {
		super(message);
		this.message = message;
		this.__previousException = previous;
		this.__nativeException = native != null ? native : this;
	}
	get_native() {
		return this.__nativeException;
	}
	static thrown(value) {
		if(((value) instanceof haxe_Exception)) {
			return value.get_native();
		} else if(((value) instanceof Error)) {
			return value;
		} else {
			let e = new haxe_ValueException(value);
			return e;
		}
	}
}
haxe_Exception.__name__ = true;
class haxe_ValueException extends haxe_Exception {
	constructor(value,previous,native) {
		super(String(value),previous,native);
		this.value = value;
	}
}
haxe_ValueException.__name__ = true;
class haxe_io_Path {
	constructor(path) {
		switch(path) {
		case ".":case "..":
			this.dir = path;
			this.file = "";
			return;
		}
		let c1 = path.lastIndexOf("/");
		let c2 = path.lastIndexOf("\\");
		if(c1 < c2) {
			this.dir = HxOverrides.substr(path,0,c2);
			path = HxOverrides.substr(path,c2 + 1,null);
			this.backslash = true;
		} else if(c2 < c1) {
			this.dir = HxOverrides.substr(path,0,c1);
			path = HxOverrides.substr(path,c1 + 1,null);
		} else {
			this.dir = null;
		}
		let cp = path.lastIndexOf(".");
		if(cp != -1) {
			this.ext = HxOverrides.substr(path,cp + 1,null);
			this.file = HxOverrides.substr(path,0,cp);
		} else {
			this.ext = null;
			this.file = path;
		}
	}
	toString() {
		return (this.dir == null ? "" : this.dir + (this.backslash ? "\\" : "/")) + this.file + (this.ext == null ? "" : "." + this.ext);
	}
	static withoutExtension(path) {
		let s = new haxe_io_Path(path);
		s.ext = null;
		return s.toString();
	}
	static withoutDirectory(path) {
		let s = new haxe_io_Path(path);
		s.dir = null;
		return s.toString();
	}
	static extension(path) {
		let s = new haxe_io_Path(path);
		if(s.ext == null) {
			return "";
		}
		return s.ext;
	}
}
haxe_io_Path.__name__ = true;
class haxe_iterators_ArrayIterator {
	constructor(array) {
		this.current = 0;
		this.array = array;
	}
	hasNext() {
		return this.current < this.array.length;
	}
	next() {
		return this.array[this.current++];
	}
}
haxe_iterators_ArrayIterator.__name__ = true;
class material_CustomPhysicalMaterial extends three_ShaderMaterial {
	constructor(additionalUniforms,parameters) {
		let tmp = Structure_extendAny(Three.ShaderLib.physical.uniforms,additionalUniforms != null ? additionalUniforms : { });
		super(Structure_extendAny({ defines : { "STANDARD" : "", "PHYSICAL" : ""}, uniforms : tmp, vertexShader : Three.ShaderLib.physical.vertexShader, fragmentShader : Three.ShaderLib.physical.fragmentShader, fog : true},parameters != null ? parameters : { }));
		this.flatShading = false;
		this.color = new three_Color(16777215);
		this.roughness = 1.0;
		this.metalness = 0.0;
		this.map = null;
		this.lightMap = null;
		this.lightMapIntensity = 1.0;
		this.aoMap = null;
		this.aoMapIntensity = 1.0;
		this.emissive = new three_Color(0);
		this.emissiveIntensity = 1.0;
		this.emissiveMap = null;
		this.bumpMap = null;
		this.bumpScale = 1;
		this.normalMap = null;
		this.normalMapType = three_NormalMapTypes.TangentSpaceNormalMap;
		this.normalScale = new three_Vector2(1,1);
		this.displacementMap = null;
		this.displacementScale = 1;
		this.displacementBias = 0;
		this.roughnessMap = null;
		this.metalnessMap = null;
		this.alphaMap = null;
		this.envMap = null;
		this.envMapIntensity = 1.0;
		this.refractionRatio = 0.98;
		this.wireframeLinecap = "round";
		this.wireframeLinejoin = "round";
		this.isMeshStandardMaterial = true;
		if(this.clearcoat > 0 != false) {
			this.version++;
		}
		this.clearcoat = 0.0;
		this.clearcoatMap = null;
		this.clearcoatRoughness = 0.0;
		this.clearcoatRoughnessMap = null;
		this.clearcoatNormalScale = new three_Vector2(1,1);
		this.clearcoatNormalMap = null;
		if(this.sheen > 0 != false) {
			this.version++;
		}
		this.sheen = 0.0;
		this.sheenColor = new three_Color(0);
		this.sheenColorMap = null;
		this.sheenRoughness = 1.0;
		this.sheenRoughnessMap = null;
		this.transparency = 0.0;
		if(this.transmission > 0 != false) {
			this.version++;
		}
		this.transmission = 0.;
		this.ior = 1.5;
		this.transmissionMap = null;
		this.thickness = 0.01;
		this.thicknessMap = null;
		this.attenuationDistance = 0.0;
		this.attenuationColor = new three_Color(1,1,1);
		this.specularIntensity = 1.0;
		this.specularColor = new three_Color(1,1,1);
		this.specularIntensityMap = null;
		this.specularColorMap = null;
		this.isMeshPhysicalMaterial = true;
		this.isInitialized = true;
		if(parameters != null) {
			this.setValues(parameters);
		}
	}
	setValues(parameters) {
		if(!this.isInitialized) {
			let _g = 0;
			let _g1 = Reflect.fields(parameters);
			while(_g < _g1.length) {
				let key = _g1[_g];
				++_g;
				this[key] = null;
			}
		}
		super.setValues(parameters);
	}
}
material_CustomPhysicalMaterial.__name__ = true;
var three_RawShaderMaterial = require("three").RawShaderMaterial;
class rendering_CopyShader extends three_RawShaderMaterial {
	constructor() {
		let uTexture = new three_Uniform(null);
		let uOpacity = new three_Uniform(1.);
		super({ uniforms : { uTexture : uTexture, uOpacity : uOpacity}, vertexShader : "\n\t\t\t\tattribute vec2 position;\n\t\t\t\tvarying vec2 vUv;\n\t\t\t\tvoid main() {\n\t\t\t\t\tvUv = position * 0.5 + 0.5;\n\t\t\t\t\tgl_Position = vec4(position, 0., 1.);\n\t\t\t\t}\n\t\t\t", fragmentShader : "\n\t\t\t\tprecision highp float;\n\t\t\t\tuniform sampler2D uTexture;\n\t\t\t\tuniform float uOpacity;\n\t\t\t\tvarying vec2 vUv;\n\n\t\t\t\tvoid main() {\n\t\t\t\t\tgl_FragColor = texture2D(uTexture, vUv);\n\t\t\t\t\tgl_FragColor.a *= uOpacity;\n\t\t\t\t}\n\t\t\t", side : three_Side.DoubleSide, depthWrite : false, depthTest : false, fog : false, lights : false, toneMapped : false, blending : three_Blending.NoBlending});
		this.uTexture = uTexture;
		this.uOpacity = uOpacity;
	}
}
rendering_CopyShader.__name__ = true;
class shaders_BloomBlend extends three_RawShaderMaterial {
	constructor() {
		let uTexture = new three_Uniform(null);
		let uBloomMix = new three_Uniform(0.0);
		let uBloomMultiplier = new three_Uniform(1.);
		let uBloomSubtract = new three_Uniform(0.0);
		let uBloomExponent = new three_Uniform(1.);
		super({ uniforms : { uTexture : uTexture, uBloomMix : uBloomMix, uBloomMultiplier : uBloomMultiplier, uBloomSubtract : uBloomSubtract, uBloomExponent : uBloomExponent}, vertexShader : "\n\t\t\t\tattribute vec2 position;\n\n\t\t\t\tvarying vec2 vUv;\n\n\t\t\t\tvoid main() {\n\t\t\t\t\tvUv = position * 0.5 + 0.5;\n\t\t\t\t\tgl_Position = vec4(position, 0., 1.);\n\t\t\t\t}\n\t\t\t", fragmentShader : "\n\t\t\t\tprecision highp float;\n\n\t\t\t\tuniform sampler2D uTexture;\n\t\t\t\tuniform float uBloomMix;\n\t\t\t\tuniform float uBloomMultiplier;\n\t\t\t\tuniform float uBloomSubtract;\n\t\t\t\tuniform float uBloomExponent;\n\n\t\t\t\tvarying vec2 vUv;\n\n\t\t\t\tvoid main() {\n\t\t\t\t\tgl_FragColor = texture2D(uTexture, vUv);\n\t\t\t\t\tgl_FragColor.rgb = max(gl_FragColor.rgb - uBloomSubtract, vec3(0.));\n\t\t\t\t\tgl_FragColor.rgb = pow(gl_FragColor.rgb, vec3(uBloomExponent)) * uBloomMultiplier;\n\t\t\t\t\tgl_FragColor.a *= uBloomMix;\n\t\t\t\t}\n\t\t\t", side : three_Side.DoubleSide, blending : three_Blending.CustomBlending, blendEquation : three_BlendingEquation.AddEquation, blendSrc : three_BlendingDstFactor.OneFactor, blendDst : three_BlendingDstFactor.OneMinusSrcAlphaFactor});
		this.uTexture = uTexture;
		this.uBloomMix = uBloomMix;
		this.uBloomMultiplier = uBloomMultiplier;
		this.uBloomSubtract = uBloomSubtract;
		this.uBloomExponent = uBloomExponent;
	}
}
shaders_BloomBlend.__name__ = true;
class shaders_Blur1D extends three_RawShaderMaterial {
	constructor(ctx,kernel,truncationSigma,directionX,directionY,linearSampling) {
		let uTexture = new three_Uniform(null);
		let uTexelSize = new three_Uniform(new three_Vector2(1,1));
		let shaderParts = shaders_Blur1D.generateShaderParts(ctx,kernel,truncationSigma,directionX,directionY,linearSampling);
		let tmp = "\n\t\t\t\tprecision " + "mediump" + " float;\n\t\t\t\tattribute vec2 position;\n\n\t\t\t\tuniform vec2 invResolution;\n\n\t\t\t\t\n" + shaderParts.varyingDeclarations.join("\n") + "\n\n\t\t\t\tconst vec2 madd = vec2(0.5, 0.5);\n\n\t\t\t\tvoid main() {\n\t\t\t\t\tvec2 texelCoord = (position * madd + madd);\n\n\t\t\t\t\t\n" + shaderParts.varyingValues.join("\n") + "\n\n\t\t\t\t\tgl_Position = vec4(position, 0.0, 1.);\n\t\t\t\t}\n\t\t\t";
		let tmp1 = "\n\t\t\t\tprecision " + "mediump" + " float;\n\t\t\t\tuniform sampler2D texture;\n\n\t\t\t\t\n" + shaderParts.fragmentDeclarations.join("\n") + "\n\n\t\t\t\t\n" + shaderParts.varyingDeclarations.join("\n") + "\n\n\t\t\t\tvoid main() {\n\t\t\t\t\t\n" + shaderParts.fragmentVariables.join("\n") + "\n\n\t\t\t\t\tvec4 blend = vec4(0.0);\n\t\t\t\t\t\n" + shaderParts.textureSamples.join("\n") + ";\n\t\t\t\t\tgl_FragColor = blend;\n\t\t\t\t}\n\t\t\t";
		super({ uniforms : { texture : uTexture, invResolution : uTexelSize}, vertexShader : tmp, fragmentShader : tmp1});
		this.uTexture = uTexture;
		this.uTexelSize = uTexelSize;
		this.kernel = kernel;
		this.directionX = directionX;
		this.directionY = directionY;
	}
	static generateShaderParts(ctx,kernel,truncationSigma,directionX,directionY,linearSampling) {
		let N = shaders_Blur1D.nearestBestKernel(kernel);
		let centerIndex = (N - 1) / 2;
		let offsets = [];
		let weights = [];
		let totalWeight = 0.0;
		let _g = 0;
		while(_g < N) {
			let i = _g++;
			let u = i / (N - 1);
			let w = shaders_Blur1D.gaussianWeight(u * 2.0 - 1,truncationSigma);
			offsets[i] = i - centerIndex;
			weights[i] = w;
			totalWeight += w;
		}
		let _g1 = 0;
		let _g2 = weights.length;
		while(_g1 < _g2) {
			let i = _g1++;
			weights[i] /= totalWeight;
		}
		if(linearSampling) {
			let lerpSampleOffsets = [];
			let lerpSampleWeights = [];
			let i = 0;
			while(i < N) {
				let A = weights[i];
				let leftOffset = offsets[i];
				if(i + 1 < N) {
					let B = weights[i + 1];
					let lerpWeight = A + B;
					let alpha = B / (A + B);
					let lerpOffset = leftOffset + alpha;
					lerpSampleOffsets.push(lerpOffset);
					lerpSampleWeights.push(lerpWeight);
				} else {
					lerpSampleOffsets.push(leftOffset);
					lerpSampleWeights.push(A);
				}
				i += 2;
			}
			offsets = lerpSampleOffsets;
			weights = lerpSampleWeights;
		}
		let maxVaryingRows = ctx.getParameter(36348);
		let varyingCount = Math.min(offsets.length,maxVaryingRows) | 0;
		let _g3 = [];
		let _g4 = 0;
		while(_g4 < varyingCount) {
			let i = _g4++;
			_g3.push("varying vec2 sampleCoord" + i + ";");
		}
		let _g5 = [];
		let _g6 = 0;
		while(_g6 < varyingCount) {
			let i = _g6++;
			_g5.push("sampleCoord" + i + " = texelCoord + vec2(" + shaders_Blur1D.glslFloat(offsets[i] * directionX) + ", " + shaders_Blur1D.glslFloat(offsets[i] * directionY) + ") * invResolution;");
		}
		let _g7 = [];
		let _g8 = varyingCount;
		let _g9 = offsets.length;
		while(_g8 < _g9) {
			let i = _g8++;
			_g7.push("vec2 sampleCoord" + i + " = sampleCoord0 + vec2(" + shaders_Blur1D.glslFloat((offsets[i] - offsets[0]) * directionX) + ", " + shaders_Blur1D.glslFloat((offsets[i] - offsets[0]) * directionY) + ") * invResolution;");
		}
		let _g10 = [];
		let _g11 = 0;
		let _g12 = offsets.length;
		while(_g11 < _g12) {
			let i = _g11++;
			_g10.push("blend += texture2D(texture, sampleCoord" + i + ") * " + shaders_Blur1D.glslFloat(weights[i]) + ";");
		}
		return { varyingDeclarations : _g3, varyingValues : _g5, fragmentDeclarations : varyingCount < offsets.length ? ["uniform vec2 invResolution;"] : [""], fragmentVariables : _g7, textureSamples : _g10};
	}
	static nearestBestKernel(idealKernel) {
		let v = Math.round(idealKernel);
		if(v % 2 != 0 && Math.floor(v / 2) % 2 == 0 && v > 0) {
			return Math.max(v,3) | 0;
		}
		let k = v - 1;
		if(k % 2 != 0 && Math.floor(k / 2) % 2 == 0 && k > 0) {
			return Math.max(k,3) | 0;
		}
		let k1 = v + 1;
		if(k1 % 2 != 0 && Math.floor(k1 / 2) % 2 == 0 && k1 > 0) {
			return Math.max(k1,3) | 0;
		}
		let k2 = v - 2;
		if(k2 % 2 != 0 && Math.floor(k2 / 2) % 2 == 0 && k2 > 0) {
			return Math.max(k2,3) | 0;
		}
		let k3 = v + 2;
		if(k3 % 2 != 0 && Math.floor(k3 / 2) % 2 == 0 && k3 > 0) {
			return Math.max(k3,3) | 0;
		}
		return Math.max(v,3) | 0;
	}
	static gaussianWeight(x,truncationSigma) {
		let denominator = Math.sqrt(2.0 * Math.PI) * truncationSigma;
		let exponent = -(x * x / (2.0 * truncationSigma * truncationSigma));
		let weight = 1.0 / denominator * Math.exp(exponent);
		return weight;
	}
	static glslFloat(f) {
		let s = f == null ? "null" : "" + f;
		if(s.indexOf(".") == -1) {
			s += ".";
		}
		return s;
	}
}
shaders_Blur1D.__name__ = true;
var three_BlendingDstFactor = require("three");
var three_BlendingEquation = require("three");
var three_Mapping = require("three");
var three_MeshBasicMaterial = require("three").MeshBasicMaterial;
var three_MeshStandardMaterial = require("three").MeshStandardMaterial;
var three_MeshPhysicalMaterial = require("three").MeshPhysicalMaterial;
var three_NormalMapTypes = require("three");
var three_PixelFormat = require("three");
var three_TextureDataType = require("three");
var three_TextureFilter = require("three");
var three_TextureLoader = require("three").TextureLoader;
var three_TorusKnotGeometry = require("three").TorusKnotGeometry;
var three_Vector2 = require("three").Vector2;
var three_WebGLRenderTarget = require("three").WebGLRenderTarget;
var three_examples_jsm_loaders_rgbeloader_RGBELoader = require("three/examples/jsm/loaders/RGBELoader").RGBELoader;
var tool_PMREMGeneratorInternal = require("three").PMREMGenerator;
class tool_IBLGenerator extends tool_PMREMGeneratorInternal {
	constructor(renderer) {
		super(renderer);
	}
	_allocateTargets(equirectangular) {
		let params = { magFilter : three_TextureFilter.NearestFilter, minFilter : three_TextureFilter.NearestFilter, generateMipmaps : false, type : three_TextureDataType.UnsignedByteType, format : three_PixelFormat.RGBEFormat, encoding : this._isLDR(equirectangular) ? equirectangular.encoding : three_TextureEncoding.RGBDEncoding, depthBuffer : false, stencilBuffer : false};
		let cubeUVRenderTarget = this._createRenderTarget(params);
		cubeUVRenderTarget.depthBuffer = equirectangular != null ? false : true;
		this._pingPongRenderTarget = this._createRenderTarget(params);
		return cubeUVRenderTarget;
	}
	_isLDR(texture) {
		if(texture == null || texture.type != three_TextureDataType.UnsignedByteType) {
			return false;
		}
		if(!(texture.encoding == three_TextureEncoding.LinearEncoding || texture.encoding == three_TextureEncoding.sRGBEncoding)) {
			return texture.encoding == three_TextureEncoding.GammaEncoding;
		} else {
			return true;
		}
	}
	_createRenderTarget(params) {
		let cubeUVRenderTarget = new three_WebGLRenderTarget(3 * tool_IBLGenerator.SIZE_MAX,3 * tool_IBLGenerator.SIZE_MAX,params);
		cubeUVRenderTarget.texture.mapping = three_Mapping.CubeUVReflectionMapping;
		cubeUVRenderTarget.texture.name = "PMREM.cubeUv";
		cubeUVRenderTarget.scissorTest = true;
		return cubeUVRenderTarget;
	}
}
tool_IBLGenerator.__name__ = true;
if(typeof(performance) != "undefined" ? typeof(performance.now) == "function" : false) {
	HxOverrides.now = performance.now.bind(performance);
}
{
	String.__name__ = true;
	Array.__name__ = true;
}
js_Boot.__toStr = ({ }).toString;
control_ArcBallControl.defaults = { strength : 700, damping : 100, dragSpeed : 6, angleAroundY : 0, angleAroundXZ : 0, radius : 1, zoomSpeed : 1};
objects_ClipSpaceTriangle.globalGeom = (function($this) {
	var $r;
	let buffer = new three_BufferGeometry();
	let triangle = new Float32Array([-1,-1,3,-1,-1,3]);
	let uv = new Float32Array(triangle.map(function(v) {
		return v * 0.5 + 0.5;
	}));
	buffer.setAttribute("position",new three_BufferAttribute(triangle,2));
	buffer.setAttribute("uv",new three_BufferAttribute(uv,2));
	$r = buffer;
	return $r;
}(this));
var Main_pixelRatio = Math.min(window.devicePixelRatio,2);
var Main_camera = new three_PerspectiveCamera(70,1,0.01,100);
var Main_canvas = (function($this) {
	var $r;
	let _ = window.document.createElement("canvas");
	_.style.position = "absolute";
	_.style.zIndex = "0";
	_.style.top = "0";
	_.style.left = "0";
	_.style.width = "100%";
	_.style.height = "100%";
	$r = _;
	return $r;
}(this));
var Main_renderer = (function($this) {
	var $r;
	let _ = new three_WebGLRenderer({ canvas : Main_canvas, antialias : true, powerPreference : "high-performance"});
	_.autoClear = false;
	_.autoClearColor = false;
	_.autoClearDepth = false;
	_.shadowMap.enabled = false;
	_.outputEncoding = three_TextureEncoding.sRGBEncoding;
	_.toneMapping = three_ToneMapping.ACESFilmicToneMapping;
	_.toneMappingExposure = 1.0;
	_.physicallyCorrectLights = true;
	$r = _;
	return $r;
}(this));
var Main_scene = new three_Scene();
var Main_eventManager = new app_InteractionEventsManager(Main_canvas);
var Main_arcBallControl = new control_ArcBallControl({ interactionEventsManager : Main_eventManager, radius : 4.5, dragSpeed : 4., zoomSpeed : 1.});
var Main_uTime_s = new three_Uniform(0.0);
var Main_background = new rendering_BackgroundEnvironment();
var Main_environmentManager = new environment_EnvironmentManager(Main_renderer,Main_scene,"assets/env/birchwood_2k.rgbd.png",function(env) {
});
var Main_renderTargetParametersNeedUpdate = false;
var Main_devUI = Main_initDevUI();
var Main_animationFrame_lastTime_ms = -1.0;
tool_IBLGenerator.LOD_MAX = 8;
tool_IBLGenerator.SIZE_MAX = Math.pow(2,tool_IBLGenerator.LOD_MAX);
Main_main();
})(typeof window != "undefined" ? window : typeof global != "undefined" ? global : typeof self != "undefined" ? self : this);

//# sourceMappingURL=app.js.map