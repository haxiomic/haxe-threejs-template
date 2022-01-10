package environment;

import haxe.io.Path;
import three.AmbientLight;
import three.DirectionalLight;
import three.Scene;
import three.Texture;
import three.TextureLoader;
import three.WebGLRenderTarget;
import three.WebGLRenderer;
import three.examples.jsm.loaders.rgbeloader.RGBELoader;
import tool.IBLGenerator;

class EnvironmentManager {

	public var environmentPath(get, set): Null<String>;
	var _environmentPath: Null<String> = null;

	public final environmentSun: DirectionalLight;
	public final environmentAmbient: AmbientLight;
	final renderer: WebGLRenderer;
	final scene: Scene;
	final onEnvironmentLoaded: Texture -> Void;

	public function new(renderer: WebGLRenderer, scene: Scene, ?path: String, ?onEnvironmentLoaded: (envMap: Texture) -> Void) {
		this.renderer = renderer;
		this.scene = scene;
		this.onEnvironmentLoaded = onEnvironmentLoaded != null ? onEnvironmentLoaded : _ -> {};

		environmentSun = new DirectionalLight(0xFFFFFF, 0);
		environmentSun.castShadow = true;
		environmentSun.shadow.bias = -0.001;
		environmentSun.shadow.radius = 7;
		environmentSun.layers.enable(Blended);
		environmentSun.visible = false;
		scene.add(environmentSun);

		environmentAmbient = new AmbientLight(0x000000, 1);
		environmentAmbient.visible = false;
		scene.add(environmentAmbient);

		setEnvironmentMapPath(path);
	}

	var _pmremRenderTarget: Null<WebGLRenderTarget>;
	public function setEnvironmentMapPath(path: Null<String>, ?onLoaded: (envMap: Texture) -> Void, ?onError: String -> Void) {
		if (path == environmentPath) return; // no change
		if (onLoaded == null) onLoaded = (e) -> {};
		if (onError == null) onError = (e) -> js.Browser.console.error(e);
		_environmentPath = path;

		if (path != null) {
			var ext = Path.extension(path);

			switch ext.toLowerCase() {
				case 'hdr':
					var iblGenerator = new tool.IBLGenerator(renderer);
					iblGenerator.compileEquirectangularShader();
					new RGBELoader()
					.setDataType(FloatType)
					.load(
						path,
						(texture, texData) -> {
						if (_pmremRenderTarget != null) {
							_pmremRenderTarget.dispose();
						}

						_pmremRenderTarget = iblGenerator.fromEquirectangular(texture);
						iblGenerator.dispose();
						_pmremRenderTarget.texture.sourceFile = path;
						setEnvironmentMap(_pmremRenderTarget.texture);
						onLoaded(_pmremRenderTarget.texture);
						onEnvironmentLoaded(_pmremRenderTarget.texture);
					});
				case 'png':
					new TextureLoader().load(path, texture -> {
						texture.minFilter = NearestFilter;
						texture.magFilter = NearestFilter;
						texture.type = UnsignedByteType;
						texture.format = RGBEFormat;
						texture.encoding = RGBDEncoding;
						texture.mapping = CubeUVReflectionMapping;
						texture.generateMipmaps = false;
						texture.flipY = false;
						texture.sourceFile = path;
						setEnvironmentMap(texture);
						onLoaded(texture);
						onEnvironmentLoaded(texture);
					});
				default:
					var error = 'Unknown environment extension $ext';
					js.Browser.console.error(error);
					onError(error);
			}
		}
	}

	public function setEnvironmentMap(texture: Texture) {
		if (scene.environment != null) {
			scene.environment.dispose();
		}
		scene.environment = texture;
	}

	public function downloadPmremEnvironmentMap() {
		final document = js.Browser.document;
		final renderTarget = this._pmremRenderTarget;
		final environmentPath = this.environmentPath;
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
			js.Browser.alert('First load a .hdr environment file in order to download a pre-processed version');
		}
	}

	function set_environmentPath(v: String) {
		setEnvironmentMapPath(v);
		return v;
	}

	function get_environmentPath() {
		return _environmentPath;
	}

}