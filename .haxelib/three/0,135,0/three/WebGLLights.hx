package three;

@:jsRequire("three", "WebGLLights") extern class WebGLLights {
	function new(extensions:WebGLExtensions, capabilities:WebGLCapabilities);
	var state : {
		var version : Float;
		var hash : {
			var directionalLength : Float;
			var pointLength : Float;
			var spotLength : Float;
			var rectAreaLength : Float;
			var hemiLength : Float;
			var numDirectionalShadows : Float;
			var numPointShadows : Float;
			var numSpotShadows : Float;
		};
		var ambient : Array<Float>;
		var probe : Array<Dynamic>;
		var directional : Array<Dynamic>;
		var directionalShadow : Array<Dynamic>;
		var directionalShadowMap : Array<Dynamic>;
		var directionalShadowMatrix : Array<Dynamic>;
		var spot : Array<Dynamic>;
		var spotShadow : Array<Dynamic>;
		var spotShadowMap : Array<Dynamic>;
		var spotShadowMatrix : Array<Dynamic>;
		var rectArea : Array<Dynamic>;
		var point : Array<Dynamic>;
		var pointShadow : Array<Dynamic>;
		var pointShadowMap : Array<Dynamic>;
		var pointShadowMatrix : Array<Dynamic>;
		var hemi : Array<Dynamic>;
	};
	function get(light:Dynamic):Dynamic;
	function setup(lights:Dynamic):Void;
	function setupView(lights:Dynamic, camera:Dynamic):Void;
	static var prototype : WebGLLights;
}