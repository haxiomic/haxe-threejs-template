package tool;

import three.BufferAttribute;
import three.BufferGeometry;
import three.Mesh;
import three.OrthographicCamera;
import three.Scene;
import three.ShaderMaterial;
import three.ShaderMaterialParameters;
import three.Side;
import three.WebGLRenderTarget;
import three.WebGLRenderer;

class ShaderDev extends Mesh<BufferGeometry, ShaderMaterial> {

	public final shaderMaterial: ShaderMaterial;

	public function new(parameters: ShaderMaterialParameters) {
		var shaderMaterial = new ShaderMaterial(
			Structure.extend(
				{
					vertexShader: '
						varying vec2 vUv;

						void main() {
							vUv = position.xy;
							gl_Position = projectionMatrix * modelViewMatrix * vec4( position, 1.0 );
						}
					',
					depthWrite: false,
					depthTest: false,
					fog: false,
					side: DoubleSide,
				},
				parameters
			)
		);
		var unitQuad = new BufferGeometry();
		var position = new BufferAttribute(new js.lib.Float32Array([
			0, 0,
			1, 0,
			0, 1,

			1, 1,
			0, 1,
			1, 0,
		]), 2);
		unitQuad.setAttribute('position', position);
		super(unitQuad, shaderMaterial);
		this.frustumCulled = false;
		this.shaderMaterial = shaderMaterial;
	}

	public function renderToTexture(renderer: WebGLRenderer, renderTarget: WebGLRenderTarget) {
		var initialVs = shaderMaterial.vertexShader;
		var initialParent = this.parent;
		// disable vertex transform in vs
		shaderMaterial.vertexShader = '
			varying vec2 vUv;

			void main() {
				vUv = position.xy;
				gl_Position = projectionMatrix * vec4(position, 1.0);
			}
		';
		shaderMaterial.needsUpdate = true;

		var scene = new Scene();
		scene.add(this);
		var camera2d = new OrthographicCamera(0, 1, 1, 0, -1, 1);
		renderer.setRenderTarget(renderTarget);
		renderer.render(scene, camera2d);
		scene.remove(this);
		
		if (initialParent != null) {
			initialParent.add(this);
		}

		shaderMaterial.vertexShader = initialVs;
		shaderMaterial.needsUpdate = true;
	}

}