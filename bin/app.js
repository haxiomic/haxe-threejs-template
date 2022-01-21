(function ($global) { "use strict";
var $estr = function() { return js_Boot.__string_rec(this,''); },$hxEnums = $hxEnums || {},$_;
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
class event_ViewEventManager {
	constructor(el) {
		this.appActivated = false;
		this.useCapture = true;
		this.activePointerCount = 0;
		this.activePointers = new haxe_ds_IntMap();
		this.el = el;
		this.eventHandler = new event__$ViewEventManager_EventDispatcher();
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
		this.onVisibilityChange();
	}
	onVisibilityChange() {
		switch(window.document.visibilityState) {
		case "hidden":
			if(this.appActivated) {
				let _g = 0;
				let _g1 = this.eventHandler.onDeactivateCallbacks;
				while(_g < _g1.length) _g1[_g++]();
				this.appActivated = false;
			}
			break;
		case "visible":
			if(!this.appActivated) {
				let _g = 0;
				let _g1 = this.eventHandler.onActivateCallbacks;
				while(_g < _g1.length) _g1[_g++]();
				this.appActivated = true;
			}
			break;
		}
	}
	addPointerEventListeners() {
		let _gthis = this;
		let executePointerMethodFromMouseEvent = function(mouseEvent,pointerMethod) {
			let force = mouseEvent.force != null ? mouseEvent.force : mouseEvent.webkitForce != null ? mouseEvent.webkitForce : 0.5;
			pointerMethod(new event_PointerEvent(mouseEvent.button,$bind(mouseEvent,mouseEvent.preventDefault),function() {
				return mouseEvent.defaultPrevented;
			},mouseEvent.timeStamp,mouseEvent.target == _gthis.el,mouseEvent,1,"mouse",true,mouseEvent.buttons,mouseEvent.clientX,mouseEvent.clientY,1,1,_gthis.el.clientWidth,_gthis.el.clientHeight,Math.max(force - 1,0),0,0,0,0));
		};
		let touchInfoForType_h = Object.create(null);
		let getTouchInfoForType = function(type) {
			let touchInfo = touchInfoForType_h[type];
			if(touchInfo == null) {
				touchInfo = { primaryTouchIdentifier : null, activeCount : 0};
				touchInfoForType_h[type] = touchInfo;
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
				let touch = touchEvent.changedTouches[_g++];
				if(touchEvent.type == "touchforcechange") {
					let touchIsActive = false;
					let _g = 0;
					let _g1 = touchEvent.touches;
					while(_g < _g1.length) if(touch == _g1[_g++]) {
						touchIsActive = true;
						break;
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
				let _g1 = touch.identifier;
				let _g2 = touch.touchType == "stylus" ? "pen" : "touch";
				let _g3 = touch.identifier == touchInfo.primaryTouchIdentifier;
				let _g4 = buttonStates.button;
				let _g5 = buttonStates.buttons;
				let _g6 = touch.clientX;
				let _g7 = touch.clientY;
				let _g8 = _gthis.el.clientWidth;
				let _g9 = _gthis.el.clientHeight;
				let _g10 = touch.force;
				let _g11 = isFinite(tiltX) ? tiltX : 0;
				pointerMethod(new event_PointerEvent(_g4,$bind(touchEvent,touchEvent.preventDefault),function() {
					return touchEvent.defaultPrevented;
				},touchEvent.timeStamp,touchEvent.target == _gthis.el,touchEvent,_g1,_g2,_g3,_g5,_g6,_g7,radiusX * 2,radiusY * 2,_g8,_g9,_g10,0,_g11,isFinite(tiltY) ? tiltY : 0,touch.rotationAngle));
			}
		};
		let updatePointerState = function(e) {
			let existingPointer = _gthis.activePointers.h[e.pointerId];
			if(existingPointer != null) {
				existingPointer.buttons = e.buttons;
				existingPointer.x = e.x;
				existingPointer.y = e.y;
				existingPointer.width = e.width;
				existingPointer.height = e.height;
				existingPointer.viewWidth = e.viewWidth;
				existingPointer.viewHeight = e.viewHeight;
				existingPointer.pressure = e.pressure;
				existingPointer.tangentialPressure = e.tangentialPressure;
				existingPointer.tiltX = e.tiltX;
				existingPointer.tiltY = e.tiltY;
				existingPointer.twist = e.twist;
			} else {
				_gthis.activePointers.h[e.pointerId] = new event_PointerState(e.pointerId,e.pointerType,e.isPrimary,e.buttons,e.x,e.y,e.width,e.height,e.viewWidth,e.viewHeight,e.pressure,e.tangentialPressure,e.tiltX,e.tiltY,e.twist);
				_gthis.activePointerCount++;
			}
		};
		let removePointerState = function(e) {
			if(_gthis.activePointers.remove(e.pointerId)) {
				_gthis.activePointerCount--;
			}
		};
		let onPointerDown = function(e) {
			updatePointerState(e);
			let _g = 0;
			let _g1 = _gthis.eventHandler.onPointerDownCallbacks;
			while(_g < _g1.length) _g1[_g++](e);
		};
		let onPointerMove = function(e) {
			updatePointerState(e);
			let _g = 0;
			let _g1 = _gthis.eventHandler.onPointerMoveCallbacks;
			while(_g < _g1.length) _g1[_g++](e);
		};
		let onPointerUp = function(e) {
			switch(e.pointerType) {
			case "mouse":
				updatePointerState(e);
				break;
			case "pen":case "touch":
				removePointerState(e);
				break;
			}
			let _g = 0;
			let _g1 = _gthis.eventHandler.onPointerUpCallbacks;
			while(_g < _g1.length) _g1[_g++](e);
		};
		let onPointerCancel = function(e) {
			switch(e.pointerType) {
			case "mouse":
				updatePointerState(e);
				break;
			case "pen":case "touch":
				removePointerState(e);
				break;
			}
			let _g = 0;
			let _g1 = _gthis.eventHandler.onPointerCancelCallbacks;
			while(_g < _g1.length) _g1[_g++](e);
		};
		if(window.PointerEvent) {
			window.addEventListener("pointerdown",function(e) {
				let e1 = e;
				onPointerDown(new event_PointerEvent(e1.button,$bind(e1,e1.preventDefault),function() {
					return e1.defaultPrevented;
				},e1.timeStamp,e1.target == _gthis.el,e1,e1.pointerId,e1.pointerType,e1.isPrimary,e1.buttons,e1.x,e1.y,e1.width,e1.height,_gthis.el.clientWidth,_gthis.el.clientHeight,e1.pressure,e1.tangentialPressure,e1.tiltX,e1.tiltY,e1.twist));
			},this.useCapture);
			if(PointerEvent.prototype.getCoalescedEvents != null) {
				window.addEventListener("pointermove",function(e) {
					let _g = 0;
					let _g1 = e.getCoalescedEvents();
					while(_g < _g1.length) {
						let e = _g1[_g++];
						onPointerMove(new event_PointerEvent(e.button,$bind(e,e.preventDefault),function() {
							return e.defaultPrevented;
						},e.timeStamp,e.target == _gthis.el,e,e.pointerId,e.pointerType,e.isPrimary,e.buttons,e.x,e.y,e.width,e.height,_gthis.el.clientWidth,_gthis.el.clientHeight,e.pressure,e.tangentialPressure,e.tiltX,e.tiltY,e.twist));
					}
				},this.useCapture);
			} else {
				window.addEventListener("pointermove",function(e) {
					let e1 = e;
					onPointerMove(new event_PointerEvent(e1.button,$bind(e1,e1.preventDefault),function() {
						return e1.defaultPrevented;
					},e1.timeStamp,e1.target == _gthis.el,e1,e1.pointerId,e1.pointerType,e1.isPrimary,e1.buttons,e1.x,e1.y,e1.width,e1.height,_gthis.el.clientWidth,_gthis.el.clientHeight,e1.pressure,e1.tangentialPressure,e1.tiltX,e1.tiltY,e1.twist));
				},this.useCapture);
			}
			window.addEventListener("pointerup",function(e) {
				let e1 = e;
				onPointerUp(new event_PointerEvent(e1.button,$bind(e1,e1.preventDefault),function() {
					return e1.defaultPrevented;
				},e1.timeStamp,e1.target == _gthis.el,e1,e1.pointerId,e1.pointerType,e1.isPrimary,e1.buttons,e1.x,e1.y,e1.width,e1.height,_gthis.el.clientWidth,_gthis.el.clientHeight,e1.pressure,e1.tangentialPressure,e1.tiltX,e1.tiltY,e1.twist));
			},this.useCapture);
			window.addEventListener("pointercancel",function(e) {
				let e1 = e;
				onPointerCancel(new event_PointerEvent(e1.button,$bind(e1,e1.preventDefault),function() {
					return e1.defaultPrevented;
				},e1.timeStamp,e1.target == _gthis.el,e1,e1.pointerId,e1.pointerType,e1.isPrimary,e1.buttons,e1.x,e1.y,e1.width,e1.height,_gthis.el.clientWidth,_gthis.el.clientHeight,e1.pressure,e1.tangentialPressure,e1.tiltX,e1.tiltY,e1.twist));
			},this.useCapture);
		} else {
			window.addEventListener("mousedown",function(e) {
				executePointerMethodFromMouseEvent(e,onPointerDown);
			},this.useCapture);
			window.addEventListener("mousemove",function(e) {
				executePointerMethodFromMouseEvent(e,onPointerMove);
			},this.useCapture);
			window.addEventListener("webkitmouseforcechanged",function(e) {
				executePointerMethodFromMouseEvent(e,onPointerMove);
			},this.useCapture);
			window.addEventListener("mouseup",function(e) {
				executePointerMethodFromMouseEvent(e,onPointerUp);
			},this.useCapture);
			window.addEventListener("touchstart",function(e) {
				executePointerMethodFromTouchEvent(e,onPointerDown);
			},{ capture : this.useCapture, passive : false});
			window.addEventListener("touchmove",function(e) {
				executePointerMethodFromTouchEvent(e,onPointerMove);
			},{ capture : this.useCapture, passive : false});
			window.addEventListener("touchforcechange",function(e) {
				executePointerMethodFromTouchEvent(e,onPointerMove);
			},{ capture : this.useCapture, passive : false});
			window.addEventListener("touchend",function(e) {
				executePointerMethodFromTouchEvent(e,onPointerUp);
			},{ capture : this.useCapture, passive : false});
			window.addEventListener("touchcancel",function(e) {
				executePointerMethodFromTouchEvent(e,onPointerCancel);
			},{ capture : this.useCapture, passive : false});
		}
	}
	addWheelEventListeners() {
		let _gthis = this;
		window.addEventListener("wheel",function(e) {
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
			let event = new event_WheelEvent(deltaX_px,deltaY_px,deltaZ_px,x_px,y_px,e.altKey,e.ctrlKey,e.metaKey,e.shiftKey,$bind(e,e.preventDefault),function() {
				return e.defaultPrevented;
			},e.timeStamp,e.target == _gthis.el,e);
			let _g = 0;
			let _g1 = _gthis.eventHandler.onWheelCallbacks;
			while(_g < _g1.length) _g1[_g++](event);
		},{ passive : false, capture : this.useCapture});
	}
	addKeyboardEventListeners() {
		let _gthis = this;
		window.addEventListener("keydown",function(e) {
			let hasFocus = e.target == _gthis.el;
			let event = e;
			let _g = 0;
			let _g1 = _gthis.eventHandler.onKeyDownCallbacks;
			while(_g < _g1.length) _g1[_g++](event,hasFocus);
		});
		window.addEventListener("keyup",function(e) {
			let hasFocus = e.target == _gthis.el;
			let event = e;
			let _g = 0;
			let _g1 = _gthis.eventHandler.onKeyUpCallbacks;
			while(_g < _g1.length) _g1[_g++](event,hasFocus);
		});
	}
	addLifeCycleEventListeners() {
		let _gthis = this;
		window.document.addEventListener("visibilitychange",function() {
			_gthis.onVisibilityChange();
		});
	}
}
event_ViewEventManager.__name__ = true;
class event__$ViewEventManager_EventDispatcher {
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
	}
}
event__$ViewEventManager_EventDispatcher.__name__ = true;
class control_ArcBallControl {
	constructor(options) {
		this._drivingPointerId = null;
		this._onDown_clientXY = new Vec2Data(0,0);
		this._onDown_angleAroundXZ = 0;
		this._onDown_angleAroundY = 0;
		this.orientation = new Vec4Data(0,0,0,1);
		this.position = new Vec3Data(0.,0.,0.);
		this.target = new Vec3Data(0.,0.,0.);
		this.radius = new animation_Spring(1.);
		this.axialRotation = new animation_Spring(0.);
		this.angleAroundXZ = new animation_Spring(0.);
		this.angleAroundY = new animation_Spring(0.);
		let a = control_ArcBallControl.defaults;
		let options_viewEventManager = options.viewEventManager;
		let options_radius = options.radius != null ? options.radius : a.radius;
		let options_interactionSurface = options.interactionSurface;
		let options_angleAroundXZ = options.angleAroundXZ != null ? options.angleAroundXZ : a.angleAroundXZ;
		this.dragSpeed = options.dragSpeed != null ? options.dragSpeed : a.dragSpeed;
		this.zoomSpeed = options.zoomSpeed != null ? options.zoomSpeed : a.zoomSpeed;
		let v = options.strength != null ? options.strength : a.strength;
		this.angleAroundY.strength = v;
		this.angleAroundXZ.strength = v;
		this.radius.strength = v;
		let v1 = options.damping != null ? options.damping : a.damping;
		this.angleAroundY.damping = v1;
		this.angleAroundXZ.damping = v1;
		this.radius.damping = v1;
		this.angleAroundY.forceCompletion(options.angleAroundY != null ? options.angleAroundY : a.angleAroundY);
		this.angleAroundXZ.forceCompletion(options_angleAroundXZ);
		this.radius.forceCompletion(options_radius);
		let viewEventManager = options_viewEventManager;
		if(options_viewEventManager == null && options_interactionSurface != null) {
			viewEventManager = new event_ViewEventManager(options_interactionSurface);
		}
		let _gthis = this;
		if(viewEventManager != null) {
			viewEventManager.eventHandler.onPointerDownCallbacks.push($bind(this,this.handlePointerDown));
			viewEventManager.eventHandler.onPointerMoveCallbacks.push($bind(this,this.handlePointerMove));
			viewEventManager.eventHandler.onPointerUpCallbacks.push($bind(this,this.handlePointerUp));
			viewEventManager.eventHandler.onPointerCancelCallbacks.push($bind(this,this.handlePointerUp));
			let cb = function(e) {
				if(e.onTargetView && _gthis.zoomSpeed > 0) {
					_gthis.radius.target += e.deltaY * _gthis.zoomSpeed / 1000;
					_gthis.radius.target = Math.max(_gthis.radius.target,0);
					e.preventDefault();
					e.nativeEvent.stopPropagation();
				}
			};
			viewEventManager.eventHandler.onWheelCallbacks.push(cb);
		}
	}
	handlePointerDown(e) {
		if(e.onTargetView && e.button == 0 && e.isPrimary) {
			this._drivingPointerId = e.pointerId;
			this._onDown_angleAroundY = this.angleAroundY.target;
			this._onDown_angleAroundXZ = this.angleAroundXZ.target;
			this._onDown_clientXY.x = e.x;
			this._onDown_clientXY.y = e.y;
			e.preventDefault();
			e.nativeEvent.stopPropagation();
		}
	}
	handlePointerMove(e) {
		if(e.pointerId == this._drivingPointerId) {
			let surfaceSize_x = e.viewWidth;
			let surfaceSize_y = e.viewHeight;
			let a = this._onDown_clientXY;
			this.angleAroundXZ.target = this._onDown_angleAroundXZ + (e.y / surfaceSize_y - a.y / surfaceSize_y) * this.dragSpeed;
			let this1 = this.orientation;
			let u_x = this1.x;
			let u_y = this1.y;
			let u_z = this1.z;
			let s = this1.w;
			let up_y = u_y * (2 * (u_x * 0. + u_y + u_z * 0.)) + (s * s - (u_x * u_x + u_y * u_y + u_z * u_z)) + (u_z * 0. - u_x * 0.) * (2 * s);
			this.angleAroundY.target = this._onDown_angleAroundY - (1.0 - Math.pow(Math.abs(up_y) + 1,-4)) * (up_y >= 0 ? 1 : -1) * (e.x / surfaceSize_x - a.x / surfaceSize_x) * this.dragSpeed * (e.viewWidth / e.viewHeight);
			e.preventDefault();
			e.nativeEvent.stopPropagation();
		}
	}
	handlePointerUp(e) {
		if(e.pointerId == this._drivingPointerId) {
			this._drivingPointerId = null;
			e.preventDefault();
			e.nativeEvent.stopPropagation();
		}
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
		styleEl.innerHTML = "\n\t\t.dg .title {\n\t\t\toverflow: hidden;\n\t\t\twhite-space: nowrap;\n\t\t}\n\t\t/** allow function buttons to use all space **/\n\t\t.dg .function .property-name {\n\t\t\twidth: auto;\n\t\t\twhite-space: nowrap;\n\t\t}\n\t\t";
		window.document.head.appendChild(styleEl);
	}
	addFolder(name) {
		return super.addFolder(name);
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
			if(o.__enum__) {
				let e = $hxEnums[o.__enum__];
				let con = e.__constructs__[o._hx_index];
				let n = con._hx_name;
				if(con.__params__) {
					s = s + "\t";
					return n + "(" + ((function($this) {
						var $r;
						let _g = [];
						{
							let _g1 = 0;
							let _g2 = con.__params__;
							while(true) {
								if(!(_g1 < _g2.length)) {
									break;
								}
								let p = _g2[_g1];
								_g1 = _g1 + 1;
								_g.push(js_Boot.__string_rec(o[p],s));
							}
						}
						$r = _g;
						return $r;
					}(this))).join(",") + ")";
				} else {
					return n;
				}
			}
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
			let buffer = new Uint8ClampedArray(w * h * 4 | 0);
			this.renderer.readRenderTargetPixels(renderTarget,0,0,w,h,buffer);
			let pngCanvas = document.createElement("canvas");
			pngCanvas.width = w;
			pngCanvas.height = h;
			pngCanvas.getContext("2d",null).putImageData(new ImageData(buffer,w,h),0,0);
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
			window.alert("First load a .hdr environment file in order to download a pre-processed version");
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
function Main_main() {
	window.document.body.appendChild(Main_canvas);
	Main_scene.add(Main_background);
	new three_examples_jsm_loaders_gltfloader_GLTFLoader().load(Main_haxeLogoDataUrl,function(gltf) {
		gltf.scene.position.y = 1;
		Main_scene.add(gltf.scene);
	});
	let floor = new objects_GlassReflectiveFloor(new three_PlaneGeometry(10,10));
	floor.rotateX(-Math.PI * .5);
	floor.reflectorResolution = 0.15;
	floor.reflectorKernel = 0.075;
	floor.material.transparent = true;
	floor.material.opacity = 0.25;
	Main_scene.add(floor);
	let floorUI = Main_devUI.addFolder("Floor");
	let o = { };
	Object.defineProperty(o,"reflectorResolution",{ set : function(__value) {
		floor.reflectorResolution = __value;
	}, get : function() {
		return floor.reflectorResolution;
	}});
	let c = floorUI.add(o,"reflectorResolution").name("reflectorResolution");
	c = c.min(0);
	c = c.max(1);
	let o1 = { };
	Object.defineProperty(o1,"reflectorKernel",{ set : function(__value) {
		floor.reflectorKernel = __value;
	}, get : function() {
		return floor.reflectorKernel;
	}});
	let c1 = floorUI.add(o1,"reflectorKernel").name("reflectorKernel");
	c1 = c1.min(0);
	c1 = c1.max(0.1);
	Main_arcBallControl.target.y = 1.;
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
	Main_animationFrame_lastTime_ms = time_ms;
	Main_uTime_s.value = time_s;
	let gl = Main_renderer.getContext();
	let x = window.innerWidth;
	let a_y = window.innerHeight;
	let b = Main_pixelRatio;
	let targetSize_x = Math.floor(x * b);
	let targetSize_y = Math.floor(a_y * b);
	if(!(targetSize_x == gl.drawingBufferWidth && targetSize_y == gl.drawingBufferHeight)) {
		Main_canvas.width = Math.floor(targetSize_x);
		Main_canvas.height = Math.floor(targetSize_y);
	}
	let newAspect = targetSize_x / targetSize_y;
	if(Main_camera.aspect != newAspect) {
		Main_camera.aspect = newAspect;
		Main_camera.updateProjectionMatrix();
	}
	Main_update(time_s,dt_ms / 1000);
	Main_renderer.setRenderTarget(null);
	Main_renderer.setViewport(0,0,gl.drawingBufferWidth,gl.drawingBufferHeight);
	Main_renderer.clear(true,true,true);
	Main_renderer.render(Main_scene,Main_camera);
	window.requestAnimationFrame(Main_animationFrame);
}
function Main_update(time_s,dt_s) {
	let _this = Main_arcBallControl;
	let camera = Main_camera;
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
	let axial_x = v.x / denominator * sa;
	let axial_y = v.y / denominator * sa;
	let axial_z = v.z / denominator * sa;
	let axial_w = Math.cos(angle * 0.5);
	let angle1 = _this.angleAroundY.value;
	let sa1 = Math.sin(angle1 * 0.5);
	let aY_x = 0. * sa1;
	let aY_y = sa1;
	let aY_z = 0. * sa1;
	let aY_w = Math.cos(angle1 * 0.5);
	let angle2 = -_this.angleAroundXZ.value;
	let sa2 = Math.sin(angle2 * 0.5);
	let aXZ_x = sa2;
	let aXZ_y = 0. * sa2;
	let aXZ_z = 0. * sa2;
	let aXZ_w = Math.cos(angle2 * 0.5);
	let this2 = _this.orientation;
	let rhs_x = aY_x * aXZ_w + aY_y * aXZ_z - aY_z * aXZ_y + aY_w * aXZ_x;
	let rhs_y = -aY_x * aXZ_z + aY_y * aXZ_w + aY_z * aXZ_x + aY_w * aXZ_y;
	let rhs_z = aY_x * aXZ_y - aY_y * aXZ_x + aY_z * aXZ_w + aY_w * aXZ_z;
	let rhs_w = -aY_x * aXZ_x - aY_y * aXZ_y - aY_z * aXZ_z + aY_w * aXZ_w;
	this2.x = axial_x * rhs_w + axial_y * rhs_z - axial_z * rhs_y + axial_w * rhs_x;
	this2.y = -axial_x * rhs_z + axial_y * rhs_w + axial_z * rhs_x + axial_w * rhs_y;
	this2.z = axial_x * rhs_y - axial_y * rhs_x + axial_z * rhs_w + axial_w * rhs_z;
	this2.w = -axial_x * rhs_x - axial_y * rhs_y - axial_z * rhs_z + axial_w * rhs_w;
	let a = _this.position;
	let b = _this.target;
	let q = _this.orientation;
	camera.position.x = a.x + b.x;
	camera.position.y = a.y + b.y;
	camera.position.z = a.z + b.z;
	camera.quaternion.x = q.x;
	camera.quaternion.y = q.y;
	camera.quaternion.z = q.z;
	camera.quaternion.w = q.w;
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
		obj[names[i]] = values[i];
	}
	let o2 = { };
	Object.defineProperty(o2,"toneMapping",{ set : function(__strValue) {
		let _g = 0;
		while(_g < values.length) {
			let value = values[_g];
			++_g;
			if(Std.string(value) == __strValue) {
				renderer.toneMapping = value;
				break;
			}
		}
	}, get : function() {
		return renderer.toneMapping;
	}});
	g.add(o2,"toneMapping",obj).name("toneMapping").onChange(function(v) {
		let outputEncoding = renderer.outputEncoding;
		renderer.outputEncoding = outputEncoding != three_TextureEncoding.LinearEncoding ? three_TextureEncoding.LinearEncoding : three_TextureEncoding.GammaEncoding;
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
		obj1[names1[i]] = values1[i];
	}
	let o3 = { };
	Object.defineProperty(o3,"outputEncoding",{ set : function(__strValue) {
		let _g = 0;
		while(_g < values1.length) {
			let value = values1[_g];
			++_g;
			if(Std.string(value) == __strValue) {
				renderer.outputEncoding = value;
				break;
			}
		}
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
	let options = ["assets/env/hilly_terrain_01_1k.rgbd.png","assets/env/snowy_park_01_1k.rgbd.png","assets/env/birchwood_2k.rgbd.png","assets/env/winter_lake_01_1k.rgbd.png","assets/env/snowy_forest_path_01_1k.rgbd.png","assets/env/night_bridge_2k.rgbd.png","assets/env/kiara_1_dawn_2k.rgbd.png","assets/env/venice_sunset_2k.rgbd.png","assets/env/blouberg_sunrise_1_2k.rgbd.png","assets/env/the_sky_is_on_fire_2k.rgbd.png"];
	let _this = options;
	let result = new Array(_this.length);
	let _g4 = 0;
	let _g5 = _this.length;
	while(_g4 < _g5) {
		let i = _g4++;
		result[i] = Std.string(_this[i]);
	}
	let values2 = options;
	let obj2 = { };
	let _g6 = 0;
	let _g7 = result.length;
	while(_g6 < _g7) {
		let i = _g6++;
		obj2[result[i]] = values2[i];
	}
	let o6 = { };
	Object.defineProperty(o6,"environmentPath",{ set : function(__strValue) {
		let _g = 0;
		while(_g < values2.length) {
			let value = values2[_g];
			++_g;
			if((value == null ? "null" : "" + value) == __strValue) {
				Main_environmentManager.set_environmentPath(value);
				break;
			}
		}
	}, get : function() {
		return Main_environmentManager.get_environmentPath();
	}});
	g.add(o6,"environmentPath",obj2).name("environmentPath");
	let o7 = { };
	Object.defineProperty(o7,"roughness",{ set : function(__value) {
		Main_background.material.uRoughness.value = __value;
	}, get : function() {
		return Main_background.material.uRoughness.value;
	}});
	let c3 = g.add(o7,"roughness").name("roughness");
	c3 = c3.min(0);
	c3 = c3.max(1);
	c3.name("Background Blur");
	g.add({ "fn" : function() {
		Main_environmentManager.downloadPmremEnvironmentMap();
	}},"fn").name("() -> environmentManager.downloadPmremEnvironmentMap()").name("Download Processed HDR");
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
class animation_Spring {
	constructor(initialValue,target,style,velocity,onUpdate,onComplete) {
		if(velocity == null) {
			velocity = 0.0;
		}
		this.minEnergyThreshold = 1e-5;
		if(style == null) {
			style = animation_SpringStyle.Critical(0.5);
		}
		this.value = initialValue;
		this.target = target == null ? initialValue : target;
		switch(style._hx_index) {
		case 0:
			this.damping = 3.356694 / style.approxHalfLife_s;
			this.strength = this.damping * this.damping / 4;
			break;
		case 1:
			this.damping = style.damping;
			this.strength = style.strength;
			break;
		}
		this.velocity = velocity;
		this.onUpdate = onUpdate;
		this.onComplete = onComplete;
	}
	step(dt_s) {
		let V0 = this.velocity;
		let X0 = this.value - this.target;
		if(X0 == 0 && V0 == 0 || dt_s == 0) {
			return;
		}
		let k = this.strength;
		let b = this.damping;
		if(this.getTotalEnergy() < this.minEnergyThreshold) {
			this.velocity = 0;
			this.value = this.target;
			if(this.onComplete != null) {
				this.onComplete();
			}
		} else {
			let critical = k * 4 - b * b;
			if(critical > 0) {
				let q = 0.5 * Math.sqrt(critical);
				let B = (b * X0 * 0.5 + V0) / q;
				let m = Math.exp(-b * 0.5 * dt_s);
				let c = Math.cos(q * dt_s);
				let s = Math.sin(q * dt_s);
				this.velocity = m * ((B * q - 0.5 * X0 * b) * c + (-X0 * q - 0.5 * b * B) * s);
				this.value = m * (X0 * c + B * s) + this.target;
			} else if(critical < 0) {
				let u = 0.5 * Math.sqrt(-critical);
				let p = -0.5 * b + u;
				let n = -0.5 * b - u;
				let B = -(n * X0 - V0) / (2 * u);
				let A = X0 - B;
				let ep = Math.exp(p * dt_s);
				let en = Math.exp(n * dt_s);
				this.velocity = A * n * en + B * p * ep;
				this.value = A * en + B * ep + this.target;
			} else {
				let w = Math.sqrt(k);
				let B = V0 + w * X0;
				let e = Math.exp(-w * dt_s);
				this.velocity = (B - w * (X0 + B * dt_s)) * e;
				this.value = (X0 + B * dt_s) * e + this.target;
			}
		}
		if(this.onUpdate != null) {
			this.onUpdate(this.value,this.velocity);
		}
	}
	getTotalEnergy() {
		let x = this.value - this.target;
		return 0.5 * this.velocity * this.velocity + 0.5 * this.strength * x * x;
	}
	forceCompletion(v) {
		if(v != null) {
			this.target = v;
		}
		this.value = this.target;
		this.velocity = 0;
		this.step(0);
	}
}
animation_Spring.__name__ = true;
var animation_SpringStyle = $hxEnums["animation.SpringStyle"] = { __ename__:true,__constructs__:null
	,Critical: ($_=function(approxHalfLife_s) { return {_hx_index:0,approxHalfLife_s:approxHalfLife_s,__enum__:"animation.SpringStyle",toString:$estr}; },$_._hx_name="Critical",$_.__params__ = ["approxHalfLife_s"],$_)
	,Custom: ($_=function(strength,damping) { return {_hx_index:1,strength:strength,damping:damping,__enum__:"animation.SpringStyle",toString:$estr}; },$_._hx_name="Custom",$_.__params__ = ["strength","damping"],$_)
};
animation_SpringStyle.__constructs__ = [animation_SpringStyle.Critical,animation_SpringStyle.Custom];
class event_KeyboardEvent {
}
event_KeyboardEvent.__name__ = true;
class event_PointerState {
	constructor(pointerId,pointerType,isPrimary,buttons,x,y,width,height,viewWidth,viewHeight,pressure,tangentialPressure,tiltX,tiltY,twist) {
		this.pointerId = pointerId;
		this.pointerType = pointerType;
		this.isPrimary = isPrimary;
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
event_PointerState.__name__ = true;
class event_PointerEvent extends event_PointerState {
	constructor(button,preventDefault,defaultPrevented,timeStamp,onTargetView,nativeEvent,pointerId,pointerType,isPrimary,buttons,x,y,width,height,viewWidth,viewHeight,pressure,tangentialPressure,tiltX,tiltY,twist) {
		super(pointerId,pointerType,isPrimary,buttons,x,y,width,height,viewWidth,viewHeight,pressure,tangentialPressure,tiltX,tiltY,twist);
		this.button = button;
		this.preventDefault = preventDefault;
		this.defaultPrevented = defaultPrevented;
		this.timeStamp = timeStamp;
		this.onTargetView = onTargetView;
		this.nativeEvent = nativeEvent;
	}
}
event_PointerEvent.__name__ = true;
class event_WheelEvent {
	constructor(deltaX,deltaY,deltaZ,x,y,altKey,ctrlKey,metaKey,shiftKey,preventDefault,defaultPrevented,timeStamp,onTargetView,nativeEvent) {
		this.deltaX = deltaX;
		this.deltaY = deltaY;
		this.deltaZ = deltaZ;
		this.x = x;
		this.y = y;
		this.altKey = altKey;
		this.ctrlKey = ctrlKey;
		this.metaKey = metaKey;
		this.shiftKey = shiftKey;
		this.preventDefault = preventDefault;
		this.defaultPrevented = defaultPrevented;
		this.timeStamp = timeStamp;
		this.onTargetView = onTargetView;
		this.nativeEvent = nativeEvent;
	}
}
event_WheelEvent.__name__ = true;
class haxe_ds_IntMap {
	constructor() {
		this.h = { };
	}
	remove(key) {
		if(!this.h.hasOwnProperty(key)) {
			return false;
		}
		delete(this.h[key]);
		return true;
	}
}
haxe_ds_IntMap.__name__ = true;
class haxe_ds_StringMap {
	constructor() {
		this.h = Object.create(null);
	}
}
haxe_ds_StringMap.__name__ = true;
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
			while(_g < _g1.length) this[_g1[_g++]] = null;
		}
		super.setValues(parameters);
	}
}
material_CustomPhysicalMaterial.__name__ = true;
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
var three_examples_jsm_objects_reflector_Reflector = require("three/examples/jsm/objects/Reflector").Reflector;
class objects_GlassReflectiveFloor extends three_examples_jsm_objects_reflector_Reflector {
	constructor(geometry,options) {
		let b = options != null ? options : { };
		super(geometry,{ textureWidth : b.textureWidth != null ? b.textureWidth : 1, textureHeight : b.textureHeight != null ? b.textureHeight : 1, shader : b.shader, encoding : b.encoding != null ? b.encoding : three_TextureEncoding.LinearEncoding, color : b.color, clipBias : b.clipBias != null ? b.clipBias : 0.});
		this.reflectorResolution = 0.5;
		this.reflectorKernel = 0.020;
		this.reflectorSigma = 0.5;
		this.reflectorPOT = false;
		this.name = "GlassReflectiveFloor";
		let reflectorRenderTarget = this.getRenderTarget();
		let _onBeforeRender = $bind(this,this.onBeforeRender);
		let postProcess = null;
		let _gthis = this;
		this.onBeforeRender = function(renderer,scene,camera,geometry,material,group) {
			let currentTarget = renderer.getRenderTarget();
			let targetSize_x = 0;
			let targetSize_y = 0;
			if(currentTarget != null) {
				targetSize_x = currentTarget.width;
				targetSize_y = currentTarget.height;
			} else {
				let gl = renderer.getContext();
				targetSize_x = gl.drawingBufferWidth;
				targetSize_y = gl.drawingBufferHeight;
			}
			let b = _gthis.reflectorResolution;
			let x = Math.floor(targetSize_x * b);
			let y = Math.floor(targetSize_y * b);
			let targetSize_x1 = x;
			let targetSize_y1 = y;
			if(_gthis.reflectorPOT) {
				targetSize_x1 = Math.pow(2,Math.floor(Math.log(x) / 0.6931471805599453));
				targetSize_y1 = Math.pow(2,Math.floor(Math.log(y) / 0.6931471805599453));
			}
			if(!(targetSize_x1 == reflectorRenderTarget.width && targetSize_y1 == reflectorRenderTarget.height)) {
				reflectorRenderTarget.setSize(targetSize_x1,targetSize_y1);
			}
			let _previousEncoding = renderer.outputEncoding;
			let _previousToneMapping = renderer.toneMapping;
			let _previousExposure = renderer.toneMappingExposure;
			renderer.outputEncoding = three_TextureEncoding.LinearEncoding;
			_onBeforeRender(renderer,scene,camera,geometry,material,group);
			renderer.outputEncoding = _previousEncoding;
			renderer.toneMapping = _previousToneMapping;
			renderer.toneMappingExposure = _previousExposure;
			if(_gthis.reflectorKernel > 0) {
				if(postProcess == null) {
					postProcess = new rendering_PostProcess(renderer);
				}
				let previousTarget = renderer.getRenderTarget();
				postProcess.blurSelf("reflection-blur",reflectorRenderTarget,_gthis.reflectorKernel,_gthis.reflectorSigma);
				renderer.setRenderTarget(previousTarget);
			}
		};
		let _originalMaterial = this.material;
		let material = new material_CustomPhysicalMaterial(_originalMaterial.uniforms,{ name : "ReflectiveFloor", fog : false, roughness : 0, metalness : 0.25, color : new three_Color(16777215), emissiveIntensity : 0, flatShading : false, defines : { USE_UV : 1}, vertexShader : "\n\t\t\t\t#define STANDARD\n\n\t\t\t\tvarying vec3 vViewPosition;\n\t\t\t\t#ifdef USE_TRANSMISSION\n\t\t\t\t\tvarying vec3 vWorldPosition;\n\t\t\t\t#endif\n\t\t\t\t#include <common>\n\t\t\t\t#include <uv_pars_vertex>\n\t\t\t\t#include <uv2_pars_vertex>\n\t\t\t\t#include <displacementmap_pars_vertex>\n\t\t\t\t#include <color_pars_vertex>\n\t\t\t\t#include <fog_pars_vertex>\n\t\t\t\t#include <normal_pars_vertex>\n\t\t\t\t#include <morphtarget_pars_vertex>\n\t\t\t\t#include <skinning_pars_vertex>\n\t\t\t\t#include <shadowmap_pars_vertex>\n\t\t\t\t#include <logdepthbuf_pars_vertex>\n\t\t\t\t#include <clipping_planes_pars_vertex>\n\n\t\t\t\t// reflector\n\t\t\t\tuniform mat4 textureMatrix;\n\t\t\t\tvarying vec4 vReflectorUv;\n\n\n\t\t\t\tvoid main() {\n\t\t\t\t\t#include <uv_vertex>\n\t\t\t\t\t#include <uv2_vertex>\n\t\t\t\t\t#include <color_vertex>\n\t\t\t\t\t#include <beginnormal_vertex>\n\t\t\t\t\t#include <morphnormal_vertex>\n\t\t\t\t\t#include <skinbase_vertex>\n\t\t\t\t\t#include <skinnormal_vertex>\n\t\t\t\t\t#include <defaultnormal_vertex>\n\t\t\t\t\t#include <normal_vertex>\n\t\t\t\t\t#include <begin_vertex>\n\t\t\t\t\t#include <morphtarget_vertex>\n\t\t\t\t\t#include <skinning_vertex>\n\t\t\t\t\t#include <displacementmap_vertex>\n\t\t\t\t\t#include <project_vertex>\n\t\t\t\t\t#include <logdepthbuf_vertex>\n\t\t\t\t\t#include <clipping_planes_vertex>\n\t\t\t\t\tvViewPosition = - mvPosition.xyz;\n\t\t\t\t\t#include <worldpos_vertex>\n\t\t\t\t\t#include <shadowmap_vertex>\n\t\t\t\t\t#include <fog_vertex>\n\t\t\t\t#ifdef USE_TRANSMISSION\n\t\t\t\t\tvWorldPosition = worldPosition.xyz;\n\t\t\t\t#endif\n\n\n\t\t\t\t\tvReflectorUv = textureMatrix * vec4( position, 1.0 );\n\t\t\t\t}\n\t\t\t", fragmentShader : "\n\t\t\t\t#define STANDARD\n\t\t\t\tuniform float opacity;\n\n\t\t\t\tvarying vec3 vViewPosition;\n\t\t\t\tvarying vec3 vNormal;\n\t\t\t\t// varying vec3 vPosition;\n\t\t\t\tvarying vec2 vUv;\n\t\n\t\t\t\t// reflector\n\t\t\t\tuniform sampler2D tDiffuse;\n\t\t\t\tvarying vec4 vReflectorUv;\n\n\t\t\t\tfloat F_Schlick( const in float f0, const in float f90, const in float dotVH ) {\n\t\t\t\t\tfloat fresnel = exp2( ( - 5.55473 * dotVH - 6.98316 ) * dotVH );\n\t\t\t\t\treturn f0 * ( 1.0 - fresnel ) + ( f90 * fresnel );\n\t\t\t\t}\n\n\t\t\t\tvoid main() {\n\t\t\t\t\tvec3 planarReflection = texture2DProj( tDiffuse, vReflectorUv ).rgb;\n\n\t\t\t\t\tvec3 viewDir = normalize( vViewPosition );\n\t\t\t\t\tvec3 normal = normalize(vNormal);\n\n\t\t\t\t\tfloat mask = smoothstep(0.5, 0.2, length(0.5 - vUv));\n\t\t\t\t\tgl_FragColor = vec4(planarReflection, F_Schlick(opacity, 1.0, dot(normal, viewDir)) * mask);\n\n\t\t\t\t\t#include <tonemapping_fragment>\n\t\t\t\t\t#include <encodings_fragment>\n\t\t\t\t\t#include <premultiplied_alpha_fragment>\n\t\t\t\t}\n\t\t\t"});
		material.uniforms = Structure_extendAny(material.uniforms,_originalMaterial.uniforms);
		this.material = material;
	}
}
objects_GlassReflectiveFloor.__name__ = true;
var three_OrthographicCamera = require("three").OrthographicCamera;
class rendering_FragmentRenderer {
	constructor(renderer) {
		this._oldViewport = new three_Vector4();
		this.renderer = renderer;
	}
	render(target,material,clearColor,viewport) {
		this.renderer.setRenderTarget(target);
		let restoreViewport = false;
		if(viewport != null) {
			restoreViewport = true;
			this.renderer.getViewport(this._oldViewport);
			this.renderer.setViewport(viewport.x,viewport.y,viewport.z,viewport.w);
		}
		rendering_FragmentRenderer.rttMesh.material = material;
		rendering_FragmentRenderer.rttMesh.visible = material != null;
		if(clearColor != null) {
			this.renderer.setClearColor(clearColor);
			this.renderer.clear(true,true,true);
		}
		this.renderer.render(rendering_FragmentRenderer.rttScene,rendering_FragmentRenderer.rttCamera);
		if(restoreViewport) {
			this.renderer.setViewport(this._oldViewport.x,this._oldViewport.y,this._oldViewport.z,this._oldViewport.w);
		}
	}
}
rendering_FragmentRenderer.__name__ = true;
class rendering_PostProcess {
	constructor(renderer) {
		this.renderer = renderer;
		this.gl = renderer.getContext();
		this.fragmentRenderer = new rendering_FragmentRenderer(renderer);
		this.renderTargetStore = new rendering_RenderTargetStore(renderer);
	}
	blurSelf(uid,source,kernel_yFraction,sigma) {
		if(sigma == null) {
			sigma = 0.5;
		}
		let blurInput = source.texture;
		if(kernel_yFraction == 0) {
			return blurInput;
		} else {
			let width = blurInput.image.width;
			let height = blurInput.image.height;
			let targetOptions = { wrapS : blurInput.wrapS, wrapT : blurInput.wrapT, encoding : blurInput.encoding, generateMipmaps : blurInput.generateMipmaps, anisotropy : blurInput.anisotropy, type : blurInput.type, format : blurInput.format, minFilter : blurInput.minFilter, magFilter : blurInput.magFilter};
			let blurXTarget = this.renderTargetStore.acquire("blurX." + uid,width,height,targetOptions);
			let blurXYTarget = source != null ? source : this.renderTargetStore.acquire("blurXY." + uid,width,height,targetOptions);
			let kernelY_texels = kernel_yFraction * blurInput.image.height;
			let kernelX_texels = kernel_yFraction * (1 / (blurInput.image.width / blurInput.image.height)) * blurInput.image.width;
			let tmp = this.fragmentRenderer;
			let kernel = kernelX_texels;
			let width1 = blurInput.image.width;
			let height1 = blurInput.image.height;
			kernel = shaders_Blur1D.nearestBestKernel(kernelX_texels);
			let key = "" + kernel + "@" + 1. + "@" + 0. + "@" + sigma;
			let instance = shaders_Blur1D.instances.h[key];
			if(instance == null) {
				instance = new shaders_Blur1D(this.gl,kernel,sigma,1.,0.,true);
				shaders_Blur1D.instances.h[key] = instance;
			}
			instance.uTexture.value = blurInput;
			instance.uTexelSize.value.set(1 / width1,1 / height1);
			tmp.render(blurXTarget,instance,0);
			let tmp1 = this.fragmentRenderer;
			let kernel1 = kernelY_texels;
			let texture = blurXTarget.texture;
			let width2 = blurXTarget.width;
			let height2 = blurXTarget.height;
			kernel1 = shaders_Blur1D.nearestBestKernel(kernelY_texels);
			let key1 = "" + kernel1 + "@" + 0. + "@" + 1. + "@" + sigma;
			let instance1 = shaders_Blur1D.instances.h[key1];
			if(instance1 == null) {
				instance1 = new shaders_Blur1D(this.gl,kernel1,sigma,0.,1.,true);
				shaders_Blur1D.instances.h[key1] = instance1;
			}
			instance1.uTexture.value = texture;
			instance1.uTexelSize.value.set(1 / width2,1 / height2);
			tmp1.render(blurXYTarget,instance1,0);
			return blurXYTarget.texture;
		}
	}
}
rendering_PostProcess.__name__ = true;
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
class rendering_RenderTargetStore {
	constructor(renderer) {
		this.renderer = renderer;
		this.map = new haxe_ds_StringMap();
		let gl = renderer.getContext();
		this.maxMsaaSamples = renderer.capabilities.isWebGL2 ? gl.getParameter(36183) : 0;
	}
	acquire(uid,width,height,options,alwaysSyncOptions) {
		if(alwaysSyncOptions == null) {
			alwaysSyncOptions = false;
		}
		let target = this.map.h[uid];
		let needsNew = target == null;
		let msaaSamples = Math.min(this.maxMsaaSamples,options.msaaSamples != null ? options.msaaSamples : 0);
		if(alwaysSyncOptions && !needsNew) {
			needsNew = options.depthBuffer != null && options.depthBuffer != target.depthBuffer || options.stencilBuffer != null && options.stencilBuffer != target.stencilBuffer || options.depthTexture != null && options.depthTexture != target.depthTexture || (options.wrapS != null && target.texture.wrapS != options.wrapS || options.wrapT != null && target.texture.wrapT != options.wrapT || options.magFilter != null && target.texture.magFilter != options.magFilter || options.minFilter != null && target.texture.minFilter != options.minFilter || options.format != null && target.texture.format != options.format || options.type != null && target.texture.type != options.type || options.anisotropy != null && target.texture.anisotropy != options.anisotropy || target.samples != msaaSamples);
		}
		if(needsNew) {
			if(target != null) {
				target.dispose();
			}
			if(msaaSamples > 0) {
				let _ = new three_WebGLMultisampleRenderTarget(width,height,options);
				_.samples = msaaSamples;
				target = _;
			} else {
				target = new three_WebGLRenderTarget(width,height,options);
			}
			target["name"] = uid;
			this.map.h[uid] = target;
		} else {
			target.texture.generateMipmaps = options.generateMipmaps;
			target.texture.encoding = options.encoding;
			if(width != target.width || height != target.height) {
				target.setSize(width,height);
			}
		}
		return target;
	}
}
rendering_RenderTargetStore.__name__ = true;
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
			let w = shaders_Blur1D.gaussianWeight(i / (N - 1) * 2.0 - 1,truncationSigma);
			offsets[i] = i - centerIndex;
			weights[i] = w;
			totalWeight += w;
		}
		let _g1 = 0;
		let _g2 = weights.length;
		while(_g1 < _g2) weights[_g1++] /= totalWeight;
		if(linearSampling) {
			let lerpSampleOffsets = [];
			let lerpSampleWeights = [];
			let i = 0;
			while(i < N) {
				let A = weights[i];
				let leftOffset = offsets[i];
				if(i + 1 < N) {
					let B = weights[i + 1];
					lerpSampleOffsets.push(leftOffset + B / (A + B));
					lerpSampleWeights.push(A + B);
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
		while(_g4 < varyingCount) _g3.push("varying vec2 sampleCoord" + _g4++ + ";");
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
		return 1.0 / (Math.sqrt(2.0 * Math.PI) * truncationSigma) * Math.exp(-(x * x / (2.0 * truncationSigma * truncationSigma)));
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
var three_NormalMapTypes = require("three");
var three_PixelFormat = require("three");
var three_PlaneGeometry = require("three").PlaneGeometry;
var three_TextureDataType = require("three");
var three_TextureFilter = require("three");
var three_TextureLoader = require("three").TextureLoader;
var three_Vector2 = require("three").Vector2;
var three_Vector4 = require("three").Vector4;
var three_WebGLRenderTarget = require("three").WebGLRenderTarget;
var three_WebGLMultisampleRenderTarget = require("three").WebGLMultisampleRenderTarget;
var three_examples_jsm_loaders_gltfloader_GLTFLoader = require("three/examples/jsm/loaders/GLTFLoader").GLTFLoader;
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
function $bind(o,m) { if( m == null ) return null; if( m.__id__ == null ) m.__id__ = $global.$haxeUID++; var f; if( o.hx__closures__ == null ) o.hx__closures__ = {}; else f = o.hx__closures__[m.__id__]; if( f == null ) { f = m.bind(o); o.hx__closures__[m.__id__] = f; } return f; }
$global.$haxeUID |= 0;
if(typeof(performance) != "undefined" ? typeof(performance.now) == "function" : false) {
	HxOverrides.now = performance.now.bind(performance);
}
{
	String.__name__ = true;
	Array.__name__ = true;
}
js_Boot.__toStr = ({ }).toString;
control_ArcBallControl.defaults = { strength : 700, damping : 100, dragSpeed : 6, angleAroundY : 0, angleAroundXZ : 0, radius : 1, zoomSpeed : 1};
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
var Main_eventManager = new event_ViewEventManager(Main_canvas);
var Main_arcBallControl = new control_ArcBallControl({ viewEventManager : Main_eventManager, radius : 4., dragSpeed : 4., zoomSpeed : 1.});
var Main_uTime_s = new three_Uniform(0.0);
var Main_background = new rendering_BackgroundEnvironment();
var Main_environmentManager = new environment_EnvironmentManager(Main_renderer,Main_scene,"assets/env/kiara_1_dawn_2k.rgbd.png",function(env) {
});
var Main_haxeLogoDataUrl = "data:model/gltf-binary;base64," + "Z2xURgIAAADMEgAAgAQAAEpTT057ImFzc2V0Ijp7ImdlbmVyYXRvciI6Iktocm9ub3MgZ2xURiBCbGVuZGVyIEkvTyB2MS43LjMzIiwidmVyc2lvbiI6IjIuMCJ9LCJzY2VuZSI6MCwic2NlbmVzIjpbeyJuYW1lIjoiU2NlbmUiLCJub2RlcyI6WzBdfV0sIm5vZGVzIjpbeyJtZXNoIjowLCJuYW1lIjoiSGF4ZSIsInJvdGF0aW9uIjpbLTAuNzA3MTA2ODI4Njg5NTc1MiwwLDAsMC43MDcxMDY4Mjg2ODk1NzUyXX1dLCJtYXRlcmlhbHMiOlt7ImRvdWJsZVNpZGVkIjp0cnVlLCJuYW1lIjoiTWF0ZXJpYWwiLCJwYnJNZXRhbGxpY1JvdWdobmVzcyI6eyJiYXNlQ29sb3JGYWN0b3IiOlswLjkyMTU4MjE2MjM4MDIxODUsMC4yNDIyODEwMDQ3ODY0OTE0LDAuMDEzNzAyMTE2OTA2NjQyOTE0LDFdLCJtZXRhbGxpY0ZhY3RvciI6MC44MDIyNzI3MzcwMjYyMTQ2LCJyb3VnaG5lc3NGYWN0b3IiOjAuMzk1NDU0NTU1NzQ5ODkzMn19XSwibWVzaGVzIjpbeyJuYW1lIjoiUGxhbmUiLCJwcmltaXRpdmVzIjpbeyJhdHRyaWJ1dGVzIjp7IlBPU0lUSU9OIjowLCJOT1JNQUwiOjEsIlRFWENPT1JEXzAiOjJ9LCJpbmRpY2VzIjozLCJtYXRlcmlhbCI6MH1dfV0sImFjY2Vzc29ycyI6W3siYnVmZmVyVmlldyI6MCwiY29tcG9uZW50VHlwZSI6NTEyNiwiY291bnQiOjEwNiwibWF4IjpbMSwwLjQwMjYwNTc0MjIxNjExMDIzLDFdLCJtaW4iOlstMSwtMC40MDI2MDU3NDIyMTYxMTAyMywtMV0sInR5cGUiOiJWRUMzIn0seyJidWZmZXJWaWV3IjoxLCJjb21wb25lbnRUeXBlIjo1MTI2LCJjb3VudCI6MTA2LCJ0eXBlIjoiVkVDMyJ9LHsiYnVmZmVyVmlldyI6MiwiY29tcG9uZW50VHlwZSI6NTEyNiwiY291bnQiOjEwNiwidHlwZSI6IlZFQzIifSx7ImJ1ZmZlclZpZXciOjMsImNvbXBvbmVudFR5cGUiOjUxMjMs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";
var Main_devUI = Main_initDevUI();
var Main_animationFrame_lastTime_ms = -1.0;
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
rendering_FragmentRenderer.rttScene = new three_Scene();
rendering_FragmentRenderer.rttCamera = new three_OrthographicCamera(-1,1,1,-1,0,1);
rendering_FragmentRenderer.rttMesh = (function($this) {
	var $r;
	let mesh = new objects_ClipSpaceTriangle(null);
	rendering_FragmentRenderer.rttScene.add(mesh);
	$r = mesh;
	return $r;
}(this));
shaders_Blur1D.instances = new haxe_ds_StringMap();
tool_IBLGenerator.LOD_MAX = 8;
tool_IBLGenerator.SIZE_MAX = Math.pow(2,tool_IBLGenerator.LOD_MAX);
Main_main();
})(typeof window != "undefined" ? window : typeof global != "undefined" ? global : typeof self != "undefined" ? self : this);
