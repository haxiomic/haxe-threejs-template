package rendering;

import three.TextureDataType;
import three.Side;
import rendering.RenderLayer;
import three.Camera;
import three.MeshBasicMaterial;
import three.Object3D;
import three.PixelFormat;
import three.Scene;
import three.ShaderMaterial;
import three.WebGLRenderTarget;
import three.WebGLRenderer;

#if (three >= "0.133.0")
private typedef Object3D = three.Object3D<three.Event>;
#end

/**
	**Uses the `WorldPosition` layer**
	Make sure to enable `WorldPosition` on objects that should be rendered
**/
@:nullSafety
class WorldPositionRenderer {

	public var width(default, null): Float;
	public var height(default, null): Float;
	
	public final renderTarget: WebGLRenderTarget;
	final renderer: WebGLRenderer;
	final scene: Scene;
	final shaderMaterial: ShaderMaterial;
	final renderLayer: RenderLayer;
	final depthPrepassLayer: RenderLayer;
	final depthPrepassMaterial = new MeshBasicMaterial({color: 0x00FFFF, fog: false, side: DoubleSide});
	
	var object: Null<Object3D>;
	var depthPrepass: Bool = false;

	public function new(
		renderer: WebGLRenderer,
		width: Int,
		height: Int,
		renderLayer: RenderLayer = WorldPosition,
		depthPrepassLayer: RenderLayer = DepthPrepass,
		side: Side = DoubleSide,
		type: TextureDataType = HalfFloatType
	) {
		this.renderer = renderer;
		this.width = width;
		this.height = height;
		this.renderLayer = renderLayer;
		this.depthPrepassLayer = depthPrepassLayer;

		this.renderTarget = new WebGLRenderTarget(width, height, {
			magFilter: LinearFilter,
			minFilter: LinearFilter,
			depthBuffer: true,
			generateMipmaps: false,
			stencilBuffer: false,
			anisotropy: 0,
			type: type,
			format: PixelFormat.RGBAFormat,
		});

		this.scene = new Scene();
		this.shaderMaterial = new ShaderMaterial({
			uniforms: {},
			vertexShader: '
				varying vec3 vWorldPosition;

				void main() {
					vec4 p = vec4( position, 1.0 );
					vec4 worldP = modelMatrix * p;
					vWorldPosition = worldP.xyz;

					gl_Position = projectionMatrix * viewMatrix * worldP;
				}
			',
			fragmentShader: '
				varying vec3 vWorldPosition;
				
				void main() {
					gl_FragColor = vec4(vWorldPosition, 1.0);
				}
			',
			blending: NoBlending,
			side: side,
		});

		this.scene.overrideMaterial = shaderMaterial;
	}

	public function setSize(width: Float, height: Float) {
		renderTarget.setSize(width, height);
		this.width = width;
		this.height = height;
	}

	public function setObject(object: Object3D, depthPrepass: Bool) {
		this.object = object;
		this.depthPrepass = depthPrepass;
	}

	public function render(camera: Camera) {
		renderer.setRenderTarget(renderTarget);
		var clearAlphaBefore = renderer.getClearAlpha();
		renderer.setClearAlpha(0);

		renderer.clear(true, true, false);

		if (object != null) {
			var parent = object.parent;
			scene.add(object);

			var maskBefore = camera.layers.mask;

			// render depth prepass
			if (depthPrepass) {
				camera.layers.set(depthPrepassLayer);
				var gl = renderer.getContext();
				gl.colorMask(false, false, false, false);
				renderer.render(scene, camera);
				gl.colorMask(true, true, true, true);
			}

			camera.layers.set(renderLayer);
			renderer.render(scene, camera);
			camera.layers.mask = maskBefore;

			scene.remove(object);
			if (parent != null) {
				parent.add(object);
			}
		}

		renderer.setClearAlpha(clearAlphaBefore);
	}

}