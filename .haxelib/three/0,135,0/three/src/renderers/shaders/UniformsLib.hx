package three.src.renderers.shaders;

@:jsRequire("three/src/renderers/shaders/UniformsLib") @valueModuleOnly extern class UniformsLib {
	static var UniformsLib : {
		var common : {
			var diffuse : three.IUniform<Dynamic>;
			var opacity : three.IUniform<Dynamic>;
			var map : three.IUniform<Dynamic>;
			var uvTransform : three.IUniform<Dynamic>;
			var uv2Transform : three.IUniform<Dynamic>;
			var alphaMap : three.IUniform<Dynamic>;
		};
		var specularmap : {
			var specularMap : three.IUniform<Dynamic>;
		};
		var envmap : {
			var envMap : three.IUniform<Dynamic>;
			var flipEnvMap : three.IUniform<Dynamic>;
			var reflectivity : three.IUniform<Dynamic>;
			var refractionRatio : three.IUniform<Dynamic>;
			var maxMipLevel : three.IUniform<Dynamic>;
		};
		var aomap : {
			var aoMap : three.IUniform<Dynamic>;
			var aoMapIntensity : three.IUniform<Dynamic>;
		};
		var lightmap : {
			var lightMap : three.IUniform<Dynamic>;
			var lightMapIntensity : three.IUniform<Dynamic>;
		};
		var emissivemap : {
			var emissiveMap : three.IUniform<Dynamic>;
		};
		var bumpmap : {
			var bumpMap : three.IUniform<Dynamic>;
			var bumpScale : three.IUniform<Dynamic>;
		};
		var normalmap : {
			var normalMap : three.IUniform<Dynamic>;
			var normalScale : three.IUniform<Dynamic>;
		};
		var displacementmap : {
			var displacementMap : three.IUniform<Dynamic>;
			var displacementScale : three.IUniform<Dynamic>;
			var displacementBias : three.IUniform<Dynamic>;
		};
		var roughnessmap : {
			var roughnessMap : three.IUniform<Dynamic>;
		};
		var metalnessmap : {
			var metalnessMap : three.IUniform<Dynamic>;
		};
		var gradientmap : {
			var gradientMap : three.IUniform<Dynamic>;
		};
		var fog : {
			var fogDensity : three.IUniform<Dynamic>;
			var fogNear : three.IUniform<Dynamic>;
			var fogFar : three.IUniform<Dynamic>;
			var fogColor : three.IUniform<Dynamic>;
		};
		var lights : {
			var ambientLightColor : three.IUniform<Dynamic>;
			var directionalLights : {
				var value : Array<Dynamic>;
				var properties : {
					var direction : { };
					var color : { };
				};
			};
			var directionalLightShadows : {
				var value : Array<Dynamic>;
				var properties : {
					var shadowBias : { };
					var shadowNormalBias : { };
					var shadowRadius : { };
					var shadowMapSize : { };
				};
			};
			var directionalShadowMap : three.IUniform<Dynamic>;
			var directionalShadowMatrix : three.IUniform<Dynamic>;
			var spotLights : {
				var value : Array<Dynamic>;
				var properties : {
					var color : { };
					var position : { };
					var direction : { };
					var distance : { };
					var coneCos : { };
					var penumbraCos : { };
					var decay : { };
				};
			};
			var spotLightShadows : {
				var value : Array<Dynamic>;
				var properties : {
					var shadowBias : { };
					var shadowNormalBias : { };
					var shadowRadius : { };
					var shadowMapSize : { };
				};
			};
			var spotShadowMap : three.IUniform<Dynamic>;
			var spotShadowMatrix : three.IUniform<Dynamic>;
			var pointLights : {
				var value : Array<Dynamic>;
				var properties : {
					var color : { };
					var position : { };
					var decay : { };
					var distance : { };
				};
			};
			var pointLightShadows : {
				var value : Array<Dynamic>;
				var properties : {
					var shadowBias : { };
					var shadowNormalBias : { };
					var shadowRadius : { };
					var shadowMapSize : { };
				};
			};
			var pointShadowMap : three.IUniform<Dynamic>;
			var pointShadowMatrix : three.IUniform<Dynamic>;
			var hemisphereLights : {
				var value : Array<Dynamic>;
				var properties : {
					var direction : { };
					var skycolor : { };
					var groundColor : { };
				};
			};
			var rectAreaLights : {
				var value : Array<Dynamic>;
				var properties : {
					var color : { };
					var position : { };
					var width : { };
					var height : { };
				};
			};
		};
		var points : {
			var diffuse : three.IUniform<Dynamic>;
			var opacity : three.IUniform<Dynamic>;
			var size : three.IUniform<Dynamic>;
			var scale : three.IUniform<Dynamic>;
			var map : three.IUniform<Dynamic>;
			var uvTransform : three.IUniform<Dynamic>;
		};
	};
}