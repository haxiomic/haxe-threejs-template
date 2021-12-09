package tool;

import js.lib.Promise;
import three.Texture;
import three.TextureEncoding;
import three.TextureFilter;
import three.TextureLoader;

typedef TextureOptions = {
	?generateMipmaps: Bool,
	?encoding: TextureEncoding,
	?magFilter: TextureFilter,
	?minFilter: TextureFilter,
}

class TextureTools {

	static public function textureFromUrl(path: String, ?options: TextureOptions) {
		if (options == null) {
			options = {};
		}
		return new Promise((resolve, reject) -> {
			new TextureLoader().load(path, (t) -> {
				if (options.generateMipmaps != null) {
					t.generateMipmaps = options.generateMipmaps;
				}
				if (options.encoding != null) {
					t.encoding = options.encoding;
				}
				if (options.magFilter != null) {
					t.magFilter = options.magFilter;
				}
				if (options.minFilter != null) {
					t.minFilter = options.minFilter;
				}
				resolve(t);
			});
		});
	}

	static public function textureFromBase64(base64: String, mimeType: String, ?options: {
		?generateMipmaps: Bool,
		?encoding: TextureEncoding,
		?magFilter: TextureFilter,
		?minFilter: TextureFilter,
	}): Promise<Texture> {
		var dataUrl = 'data:$mimeType;base64,$base64';
		return textureFromUrl(dataUrl, options);
	}

}