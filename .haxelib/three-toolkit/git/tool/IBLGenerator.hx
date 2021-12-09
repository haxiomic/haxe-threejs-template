package tool;

import three.WebGLRenderTargetOptions;
import three.TextureEncoding;
import three.PixelFormat;
import three.TextureDataType;
import three.TextureFilter;
import three.Texture;
import three.WebGLRenderTarget;
import three.WebGLRenderer;

@:jsRequire("three", "PMREMGenerator")
extern class PMREMGeneratorInternal extends three.PMREMGenerator {

	var _pingPongRenderTarget: WebGLRenderTarget;

	public function new(renderer: WebGLRenderer);
	function _allocateTargets(equirectangular: Texture): WebGLRenderTarget;

}

// RGBD vs RGBM vs RGBE https://lousodrome.net/blog/light/tag/rgbm/

class IBLGenerator extends PMREMGeneratorInternal {

	static final LOD_MIN = 4;
	static final LOD_MAX = 8;
	static final SIZE_MAX = Math.pow(2, LOD_MAX);

	override function _allocateTargets(equirectangular: Texture): WebGLRenderTarget {
		var params = {
			magFilter: TextureFilter.NearestFilter,
			minFilter: TextureFilter.NearestFilter,
			generateMipmaps: false,
			type: TextureDataType.UnsignedByteType,
			format: PixelFormat.RGBEFormat,
			encoding: _isLDR(equirectangular) ? equirectangular.encoding : TextureEncoding.RGBDEncoding,
			depthBuffer: false,
			stencilBuffer: false
		};

		var cubeUVRenderTarget = _createRenderTarget(cast params);
		cubeUVRenderTarget.depthBuffer = equirectangular != null ? false : true;
		this._pingPongRenderTarget = _createRenderTarget(cast params);
		return cubeUVRenderTarget;
	}

	function _isLDR(texture: Null<Texture>) {
		if (texture == null || texture.type != UnsignedByteType) return false;
		return texture.encoding == LinearEncoding || texture.encoding == sRGBEncoding || texture.encoding == GammaEncoding;
	}

	function _createRenderTarget(params: WebGLRenderTargetOptions) {
		var cubeUVRenderTarget = new WebGLRenderTarget(3 * SIZE_MAX, 3 * SIZE_MAX, params);
		cubeUVRenderTarget.texture.mapping = CubeUVReflectionMapping;
		cubeUVRenderTarget.texture.name = 'PMREM.cubeUv';
		cubeUVRenderTarget.scissorTest = true;
		return cubeUVRenderTarget;
	}
	
}