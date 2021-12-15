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

	public var environmentPath(default, null): Null<String> = null;
	public final environmentSun: DirectionalLight;
	public final environmentAmbient: AmbientLight;
	final renderer: WebGLRenderer;
	final scene: Scene;
	final onEnvironmentLoaded: Texture -> Void;

	public function new(renderer: WebGLRenderer, scene: Scene, ?onEnvironmentLoaded: (envMap: Texture) -> Void) {
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
	}

	var _pmremRenderTarget: Null<WebGLRenderTarget>;
	public function setEnvironmentMapPath(path: Null<String>, ?onLoaded: (envMap: Texture) -> Void, ?onError: String -> Void) {
		if (path == environmentPath) return; // no change
		if (onLoaded == null) onLoaded = (e) -> {};
		if (onError == null) onError = (e) -> js.Browser.console.error(e);
		environmentPath = path;

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

}