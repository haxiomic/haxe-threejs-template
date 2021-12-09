package three;

@:jsRequire("three", "XRHandJoint") @:enum extern abstract XRHandJoint(Int) from Int to Int {
	var wrist;
	@:native("thumb-metacarpal")
	var thumb_metacarpal;
	@:native("thumb-phalanx-proximal")
	var thumb_phalanx_proximal;
	@:native("thumb-phalanx-distal")
	var thumb_phalanx_distal;
	@:native("thumb-tip")
	var thumb_tip;
	@:native("index-finger-metacarpal")
	var index_finger_metacarpal;
	@:native("index-finger-phalanx-proximal")
	var index_finger_phalanx_proximal;
	@:native("index-finger-phalanx-intermediate")
	var index_finger_phalanx_intermediate;
	@:native("index-finger-phalanx-distal")
	var index_finger_phalanx_distal;
	@:native("index-finger-tip")
	var index_finger_tip;
	@:native("middle-finger-metacarpal")
	var middle_finger_metacarpal;
	@:native("middle-finger-phalanx-proximal")
	var middle_finger_phalanx_proximal;
	@:native("middle-finger-phalanx-intermediate")
	var middle_finger_phalanx_intermediate;
	@:native("middle-finger-phalanx-distal")
	var middle_finger_phalanx_distal;
	@:native("middle-finger-tip")
	var middle_finger_tip;
	@:native("ring-finger-metacarpal")
	var ring_finger_metacarpal;
	@:native("ring-finger-phalanx-proximal")
	var ring_finger_phalanx_proximal;
	@:native("ring-finger-phalanx-intermediate")
	var ring_finger_phalanx_intermediate;
	@:native("ring-finger-phalanx-distal")
	var ring_finger_phalanx_distal;
	@:native("ring-finger-tip")
	var ring_finger_tip;
	@:native("pinky-finger-metacarpal")
	var pinky_finger_metacarpal;
	@:native("pinky-finger-phalanx-proximal")
	var pinky_finger_phalanx_proximal;
	@:native("pinky-finger-phalanx-intermediate")
	var pinky_finger_phalanx_intermediate;
	@:native("pinky-finger-phalanx-distal")
	var pinky_finger_phalanx_distal;
	@:native("pinky-finger-tip")
	var pinky_finger_tip;
}