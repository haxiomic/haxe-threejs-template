package rendering;

import js.html.webgl.WebGL2RenderingContext;
import three.WebGLMultisampleRenderTarget;
import three.WebGLRenderTarget;
import three.WebGLRenderTargetOptions;
import three.WebGLRenderer;

class RenderTargetStore {

	final map: Map<String, WebGLRenderTarget>;
	final renderer: WebGLRenderer;
	final maxMsaaSamples: Int;

	public function new(renderer: WebGLRenderer) {
		this.renderer = renderer;
		this.map = new Map();
		var gl = renderer.getContext();
		this.maxMsaaSamples = renderer.capabilities.isWebGL2 ? gl.getParameter(WebGL2RenderingContext.MAX_SAMPLES) : 0;
	}
	
	/**
		Creates render target with specified options if one does not exist, or synchronizes options (including resizing) if one does

		Content is undefined
	**/
	public function acquire(uid: String, width: Float, height: Float, options: WebGLRenderTargetOptions & { ?msaaSamples: Int }, alwaysSyncOptions: Bool = false): rendering.WebGLRenderTarget {
		var target = this.map.get(uid);

		var needsNew = target == null;

		var msaaSamples = Math.min(maxMsaaSamples, options.msaaSamples != null ? options.msaaSamples : 0);

		// here options may change at runtime so we check if the options are correct and create a new target if mismatching
		if (alwaysSyncOptions && !needsNew) {
			needsNew = (
				(options.depthBuffer != null && options.depthBuffer != target.depthBuffer) ||
				(options.stencilBuffer != null && options.stencilBuffer != target.stencilBuffer) ||
				(options.depthTexture != null && options.depthTexture != target.depthTexture)
			) || (
				(options.wrapS != null && target.texture.wrapS != options.wrapS) ||
				(options.wrapT != null && target.texture.wrapT != options.wrapT) ||
				(options.magFilter != null && target.texture.magFilter != options.magFilter) ||
				(options.minFilter != null && target.texture.minFilter != options.minFilter) ||
				(options.format != null && target.texture.format != options.format) ||
				(options.type != null && target.texture.type != options.type) ||
				(options.anisotropy != null && target.texture.anisotropy != options.anisotropy) ||
				((cast target: WebGLMultisampleRenderTarget).samples != msaaSamples)
			);
		}

		if (needsNew) {
			if (target != null) {
				target.dispose();
			}
			target = if (msaaSamples > 0) {
				var _ = new WebGLMultisampleRenderTarget(width, height, options);
				_.samples = msaaSamples;
				_;
			} else {
				new WebGLRenderTarget(width, height, options);
			}
			Reflect.setField(target, 'name', uid);
			this.map.set(uid, target);
		} else {
			// synchronize props
			target.texture.generateMipmaps = options.generateMipmaps;
			target.texture.encoding = options.encoding;

			var needsResize = width != target.width || height != target.height;
			if (needsResize) {
				target.setSize(width, height);
			}
		}

		return target;
	}

	public function clearAndDispose() {
		for (target in this.map) {
			target.dispose();
		}
		this.map.clear();
	}
	
	public inline function get(uid: String) return this.map.get(uid);

	public inline function exists(uid: String) return this.map.exists(uid);

	public inline function iterator() return this.map.iterator();
	public inline function keyValueIterator() return this.map.keyValueIterator();

}