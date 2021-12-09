package rendering;

import three.RawShaderMaterial;
import three.Texture;
import three.Uniform;
import three.Vector2;
import three.WebGLRenderer;

enum abstract DataFormat(Int) {
	/**
		[ p q ]
		position = texture2D(uPosDelta, 0.5).xy
		lastPosition = texture2D(uPosDelta, 0.5).zw
	**/
	var SinglePixel;

	/**
		Use if position contains more than two values
		[ p, q ]
		position = texture2D(uPosDelta, vec2(0.25, 0.5));
		lastPosition = texture2D(uPosDelta, vec2(0.75, 0.5));
	**/
	var DoublePixel;
}

class PosDeltaSampler {

	public final uPosTexture = new Uniform(cast null);
	public final dataFormat: DataFormat;

	final renderer: WebGLRenderer;
	final fragmentRenderer: FragmentRenderer;
	final positionTexture: Texture;
	final renderTarget: DualRenderTarget;
	final shader: RawShaderMaterial;

	final uPointerUv = new Uniform(new Vector2());

	public function new(renderer: WebGLRenderer, positionTexture: Texture, dataFormat: DataFormat) {
		this.renderer = renderer;
		this.fragmentRenderer = new FragmentRenderer(renderer);
		this.positionTexture = positionTexture;
		this.dataFormat = dataFormat;

		this.renderTarget = new DualRenderTarget(renderer, 2, 1, {
			minFilter: NearestFilter,
			magFilter: NearestFilter,
			encoding: LinearEncoding,
			type: positionTexture.type,
			stencilBuffer: false,
			depthBuffer: false,
			anisotropy: 0,
			format: positionTexture.format,
			generateMipmaps: false,
		});

		this.shader = new RawShaderMaterial({
			uniforms: {
				uPointerUv: uPointerUv,
				uPositionTexture: new Uniform(positionTexture),
				uLastFrameTexture: renderTarget.uniform,
			},
			vertexShader: '
				attribute vec2 position;

				varying vec2 vUv;

				void main() {
					vUv = position * 0.5 + 0.5;
					gl_Position = vec4(position, 0., 1.);
				}
			',
			fragmentShader: '
				precision highp float;

				uniform vec2 uPointerUv;

				uniform sampler2D uLastFrameTexture;
				uniform sampler2D uPositionTexture;

				${switch dataFormat { case DoublePixel: 'varying vec2 vUv;'; case _: ''; }}

				void main() {
					${switch dataFormat {
						case SinglePixel: '
							gl_FragColor = vec4(
								texture2D(uPositionTexture, uPointerUv).xy,
								texture2D(uLastFrameTexture, vec2(0.5)).xy
							);
						';
						case DoublePixel: '
							if (vUv.x > 0.5) {
								gl_FragColor = texture2D(uLastFrameTexture, vec2(0.25, 0.5));
							} else {
								gl_FragColor = texture2D(uPositionTexture, uPointerUv);
							}
						';
					}}
				}
			',
		});
	}

	public function update(pointerUv: Vector2) {
		(this.uPointerUv.value: Vector2).copy(pointerUv);

		this.fragmentRenderer.render(renderTarget.getRenderTarget(), shader);
		renderTarget.swap();

		uPosTexture.value = renderTarget.getTexture();
	}

}