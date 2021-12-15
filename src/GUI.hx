#if (!macro && dev)
import dat_gui.GUI;
import environment.EnvironmentManager;
import three.WebGLRenderer;
import three.TextureEncoding;
import three.ToneMapping;
import three.Material;
import three.MeshPhysicalMaterial;
import Main.environmentManager;

var gui: GUI;

@:access(Main)
function init() {
	gui = new dat_gui.GUI({
		closed: false
	});
	
	gui.domElement.style.userSelect = 'none';
	gui.domElement.parentElement.style.zIndex = '1000';

	{	// Rendering pipeline
		var g = gui.addFolder('Rendering');
		addProperty(g, Main.pixelRatio, 0.1, 4).name('resolution');
		addProperty(g, Main.camera.fov, 1, 200, (v) -> Main.camera.updateProjectionMatrix());

		var renderer = Main.renderer;

		g.add({toneMapping: renderer.toneMapping}, 'toneMapping', {
			'NoToneMapping': NoToneMapping,
			'LinearToneMapping': LinearToneMapping,
			'ReinhardToneMapping': ReinhardToneMapping,
			'CineonToneMapping': CineonToneMapping,
			'ACESFilmicToneMapping': ACESFilmicToneMapping
		}).onChange(v -> {
			renderer.toneMapping = Std.parseInt(v);
			renderer.outputEncoding = renderer.outputEncoding;
		});

		g.add({outputEncoding: renderer.outputEncoding}, 'outputEncoding', {
			'LinearEncoding': TextureEncoding.LinearEncoding,
			'sRGBEncoding': TextureEncoding.sRGBEncoding,
			'GammaEncoding': TextureEncoding.GammaEncoding,
		})
		.onChange(v -> {
			renderer.outputEncoding = Std.parseInt(v);
		});

		addProperty(g, renderer.toneMappingExposure, 0, 4);

		var environments = [
			'winter_lake_01_1k.rgbd.png',
			'venice_sunset_2k.rgbd.png',
			'the_sky_is_on_fire_2k.rgbd.png',
			'snowy_park_01_1k.rgbd.png',
			'snowy_forest_path_01_1k.rgbd.png',
			'night_bridge_2k.rgbd.png',
			'kiara_1_dawn_2k.rgbd.png',
			'hilly_terrain_01_1k.rgbd.png',
			'blouberg_sunrise_1_2k.rgbd.png',
			'birchwood_2k.rgbd.png',
		].map(p -> 'assets/env/$p');

		g.add({p: Main.environmentManager.environmentPath}, 'p', environments).onChange(p -> {
			Main.environmentManager.setEnvironmentMapPath(p, (e) -> gui.updateDisplay());
		}).name('Environment');

		g.add({d: () -> downloadPmremEnvironmentMap(renderer, environmentManager)}, 'd').name("Download Env .png");
	}

	{	// Controls
		var g = gui.addFolder('Controls');
		var c = Main.arcBallControl;
		addProperty(g, c.dragSpeed, 0, 15);
		addProperty(g, c.zoomSpeed, 0, 20);
		addProperty(g, c.strength, 0, 1000);
		addProperty(g, c.damping, 0, 200);
	}

}

function addMaterial(g: dat_gui.GUI, material: Material, name: String) {
	var g = g.addFolder(name);
	var m = material;

	var type = 'Material';

	addProperty(g, m.visible);
	addProperty(g, m.transparent);
	addProperty(g, m.opacity, 0, 1);
	addProperty(g, m.colorWrite);
	addProperty(g, m.depthWrite);
	addProperty(g, m.depthTest);

	if (m is three.MeshBasicMaterial) {
		var m: three.MeshBasicMaterial = cast m;
		addProperty(g, m.color);
	}

	if (m is three.MeshStandardMaterial || m is material.CustomPhysicalMaterial) {
		type = 'MeshStandardMaterial';
		var m: three.MeshStandardMaterial = cast m;
		addProperty(g, m.roughness, 0, 1);
		addProperty(g, m.metalness, 0, 1);
		// addProperty(g, m.refractionRatio, 0, 1);
		addProperty(g, m.emissiveIntensity, 0, 20);
		addProperty(g, m.color);
		addProperty(g, m.emissive);
		addProperty(g, m.side).step(1);
		addProperty(g, m.envMapIntensity, 0, 4);
		addProperty(g, m.aoMapIntensity, 0, 4);
	}

	if (m is MeshPhysicalMaterial) {
		type = 'MeshPhysicalMaterial';
		var m: MeshPhysicalMaterial = cast m;
		addProperty(g, m.clearcoat, 0, 1);
		addProperty(g, m.clearcoatRoughness, 0, 1);
		addProperty(g, m.transmission, 0, 1);
		addProperty(g, m.ior, 0, 3);
		addProperty(g, m.thickness, 0, 3);
		#if (three < "0.135.0")
		addProperty(g, m.attenuationTint);
		#else
		addProperty(g, m.attenuationColor);
		#end
		addProperty(g, m.attenuationDistance, 0, 10);
		addProperty(g, m.sheen, 0, 1);
		addProperty(g, m.sheenRoughness, 0, 1);
		#if (three < "0.135.0")
		addProperty(g, m.sheenTint);
		#else
		addProperty(g, m.sheenColor);
		#end
	} else if (m is material.CustomPhysicalMaterial) {
		// repeat so than haxe properties are used
		type = 'CustomPhysicalMaterial';
		var m: material.CustomPhysicalMaterial = cast m;
		addProperty(g, m.clearcoat, 0, 1);
		addProperty(g, m.clearcoatRoughness, 0, 1);
		addProperty(g, m.transmission, 0, 1);
		addProperty(g, m.ior, 0, 3);
		addProperty(g, m.thickness, 0, 4);
		#if (three < "0.135.0")
		addProperty(g, m.attenuationTint);
		#else
		addProperty(g, m.attenuationColor);
		#end
		addProperty(g, m.attenuationDistance, 0, 10);
		addProperty(g, m.sheen, 0, 1);
		addProperty(g, m.sheenRoughness, 0, 1);
		#if (three < "0.135.0")
		addProperty(g, m.sheenTint);
		#else
		addProperty(g, m.sheenColor);
		#end
	} 

	g.name = '$name | $type';

	return g;
}

function downloadPmremEnvironmentMap(renderer: WebGLRenderer, environmentManager: EnvironmentManager) {
	final renderer = renderer;
	final document = js.Browser.document;
	final renderTarget = @:privateAccess environmentManager._pmremRenderTarget;
	final environmentPath = @:privateAccess environmentManager.environmentPath;
	final imageKind = 'png';
	if (renderTarget != null && environmentPath != null) {
		var w = Std.int(renderTarget.width);
		var h = Std.int(renderTarget.height);
		var byteCount = Std.int(w*h*4);
		var buffer = new js.lib.Uint8ClampedArray(byteCount);
		renderer.readRenderTargetPixels(renderTarget, 0, 0, w, h, buffer);

		var pngCanvas = document.createCanvasElement();
		pngCanvas.width = w;
		pngCanvas.height = h;
		var ctx = pngCanvas.getContext2d();
		var rgbaData = new js.html.ImageData(buffer, w, h);
		ctx.putImageData(rgbaData, 0, 0);

		var encodingName = switch renderTarget.texture.encoding {
			case RGBDEncoding: 'rgbd';
			case RGBEEncoding: 'rgbe';
			case RGBM16Encoding: 'rgbm17';
			case RGBM7Encoding: 'rgbm7';
			default: null;
		}

		var filename = haxe.io.Path.withoutDirectory(haxe.io.Path.withoutExtension(environmentPath)) + (encodingName != null ? '.$encodingName' : '') + '.$imageKind';

		pngCanvas.toBlob((blob) -> {
			// trigger download
			var a = document.createAnchorElement();
			document.body.appendChild(a);
			a.style.display = 'none';
			var url = js.html.URL.createObjectURL(blob);
			a.href = url;
			a.download = filename;
			a.click();
			js.html.URL.revokeObjectURL(url);
		}, 'image/$imageKind', 1);

		// document.body.appendChild(pngCanvas);
		// pngCanvas.style.position = 'absolute';
		// pngCanvas.style.zIndex = '1000';
	} else {
		trace('No environment map');
	}
}

#end

#if macro
import haxe.macro.Expr;
import haxe.macro.Context;
#end

/**
	Little utility to better integrate with haxe properties
**/
macro function addProperty<T>(g: ExprOf<dat_gui.GUI>, expr: ExprOf<T>, ?min: ExprOf<Float>, ?max: ExprOf<Float>, ?onChange: ExprOf<(v: T) -> Void>): ExprOf<dat_gui.GUI> {
	if (min == null) min = macro 0;
	if (max == null) max = macro 0;

	var name = switch expr.expr {
		case EField(e, field): field;
		case EConst(CIdent(ident)): ident;
		default: new haxe.macro.Printer().printExpr(expr);
	}
	
	var type = Context.typeof(expr);

	return if (Context.unify(type, Context.getType('haxe.Constraints.Function'))) {
		macro $g.add({f: $expr}, 'f')
				.name($v{name});
	} else if (Context.unify(type, Context.getType('three.Color'))) {
		macro {
			var g = $g;
			var color: three.Color = $expr;
			if (color == null) {
				color = new three.Color();
				$expr = color;
			}
			g.addColor({c: color.getHex()}, 'c')
			.name($v{name})
			.onChange((hex) -> {
				var color = $expr;
				color.setHex(hex);
				var cb = $onChange;
				if (cb != null) cb(color);
			});
		};
	} else if (Context.unify(type, Context.getType('three.Uniform'))) {
		 macro {
			var g = $g;
			g.add($expr, 'value', ${min}, ${max})
			.name($v{name});
		};
	} else {
		macro {
			var o = {};
			// use native javascript setter as a proxy
			js.lib.Object.defineProperty(o, 'f', {
				set: (x) -> $expr = x,
				get: () -> $expr,
			});
			$g.add(o, 'f', ${min}, ${max})
				.name($v{name})
				.onChange(v -> {
					$expr = v;
					var cb = $onChange;
					if (cb != null) cb(v);
				})
				.listen();
		}
	}
}