package shaders;

import three.Vector2;
import js.html.HTMLAllCollection;
import three.Texture;
import three.Uniform;
import three.RawShaderMaterial;

class Fxaa extends RawShaderMaterial {
	
	static public inline function get(texture: Texture, width: Float, height: Float) {
		instance.uTexture.value = texture;
		instance.uTexelSize.value.set(1/width, 1/height);
		return instance;
	}
	static final instance = new Fxaa();

	public final uTexture = new Uniform<Texture>(null);
	public final uTexelSize = new Uniform(new Vector2(1,1));

	public function new() {
		super({
			uniforms: {
				textureSampler: uTexture,
				texelSize: uTexelSize,
			},
			vertexShader: tool.CompileTime.embedShader('./fxaa-vert.glsl'),
			fragmentShader: tool.CompileTime.embedShader('./fxaa-frag.glsl'),
			side: DoubleSide
		});
	}

}