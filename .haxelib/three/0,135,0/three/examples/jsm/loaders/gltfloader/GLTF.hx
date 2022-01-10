package three.examples.jsm.loaders.gltfloader;

typedef GLTF = {
	var animations : Array<three.AnimationClip>;
	var scene : three.Group;
	var scenes : Array<three.Group>;
	var cameras : Array<three.Camera>;
	var asset : {
		@:optional
		var copyright : String;
		@:optional
		var generator : String;
		@:optional
		var version : String;
		@:optional
		var minVersion : String;
		@:optional
		var extensions : Dynamic;
		@:optional
		var extras : Dynamic;
	};
	var parser : GLTFParser;
	var userData : Dynamic;
};