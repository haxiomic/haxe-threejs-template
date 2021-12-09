package rendering;

import three.TextureDataType;
import three.Side;
import three.WebGLRenderer;

class UVRenderer extends WorldPositionRenderer {

	public function new(
		renderer: WebGLRenderer,
		width: Int,
		height: Int,
		renderLayer: RenderLayer = UVPosition,
		depthPrepassLayer: RenderLayer = DepthPrepass,
		side: Side = DoubleSide,
		type: TextureDataType = HalfFloatType
	) {
		super(
			renderer,
			width,
			height,
			renderLayer,
			depthPrepassLayer,
			side,
			type
		);
		this.shaderMaterial.vertexShader = '
			varying vec3 vUv;

			void main() {
				vUv = vec3(uv, 0.);

				// use the red channel of the vertex color for uv.z
				// this can be used to distinguish vertex islands
				#ifdef USE_COLOR
					vUv.z = color.r;
				#endif

				vec4 p = vec4(position, 1.0);
				vec4 worldP = modelMatrix * p;

				gl_Position = projectionMatrix * viewMatrix * worldP;
			}
		';
		this.shaderMaterial.fragmentShader = '
			varying vec3 vUv;

			void main() {
				gl_FragColor = vec4(vUv, 1.0);
			}
		';
		this.shaderMaterial.vertexColors = true;
	}

}