package rendering;

import three.WebGLRenderer;
import three.Texture;
import three.Uniform;
import three.WebGLRenderTargetOptions;
import rendering.WebGLRenderTarget;

class DualRenderTarget {

	public final uniform: Uniform<Texture>;

	public var width(get, null): Int;
	public var height(get, null): Int;

	var options: WebGLRenderTargetOptions;

	var a: WebGLRenderTarget;
	var b: WebGLRenderTarget;

	final postProcess: PostProcess;

	public function new(renderer: WebGLRenderer, width: Float, height: Float, ?options: WebGLRenderTargetOptions) {
		this.options = options;
		this.postProcess = new PostProcess(renderer);
		a = new WebGLRenderTarget(width, height, options);
		b = new WebGLRenderTarget(width, height, options);
		uniform = new Uniform(b.texture);
	}

	public function setOptions(newOptions: WebGLRenderTargetOptions) {
		this.options = newOptions;
		// recreate the render targets
		this.resize(this.width, this.height);
	}

	public function resize(newWidth: Int, newHeight: Int) {
		var aNew = new WebGLRenderTarget(newWidth, newHeight, options);
		var bNew = new WebGLRenderTarget(newWidth, newHeight, options);

		// // copy content to new texture (following whatever filtering params the textures use)
		postProcess.blit(a.texture, aNew);
		postProcess.blit(b.texture, bNew);

		a.dispose();
		b.dispose();

		a = aNew;
		b = bNew;

		uniform.value = b.texture;
	}

	public inline function swap() {
		var t = a;
		a = b;
		b = t;
		uniform.value = b.texture;
	}

	public inline function getWriteRenderTarget() {
		return a;
	}

	public inline function getReadRenderTarget() {
		return b;
	}

	public inline function getRenderTarget() {
		return a;
	}

	public inline function getTexture() {
		return b.texture;
	}

	inline function get_width() return Std.int(a.width);
	inline function get_height() return Std.int(a.height);

}