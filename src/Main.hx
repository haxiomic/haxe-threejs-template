import environment.EnvironmentManager;
import VectorMath;
import app.InteractionEventsManager;
import js.Browser.*;
import rendering.BackgroundEnvironment;
import rendering.FragmentRenderer;
import rendering.PostProcess;
import rendering.RenderTargetStore;
import three.Scene;
import three.Uniform;
import tool.LightingDebugProbes;


// settings
var pixelRatio = min(window.devicePixelRatio, 2);

final camera = new three.PerspectiveCamera(70, 1, 0.01, 100);
final canvas = {
	var _ = document.createCanvasElement();
	_.style.position = 'absolute';
	_.style.zIndex = '0';
	_.style.top = '0';
	_.style.left = '0';
	_.style.width = '100%';
	_.style.height = '100%';
	_;
}

final renderer = {
	var _ = new three.WebGLRenderer({
		canvas: canvas,
		antialias: true,
		powerPreference: 'high-performance',
	});
	_.autoClear = false;
	_.autoClearColor = false;
	_.autoClearDepth = false;
	_.shadowMap.enabled = false;

	_.outputEncoding = sRGBEncoding;
	_.toneMapping = ACESFilmicToneMapping;

	_.toneMappingExposure = 1.0;
	_.physicallyCorrectLights = true;
	_;
}

final gl = renderer.getContext();

final scene = new Scene();

final eventManager = new InteractionEventsManager(canvas);

final arcBallControl = new control.ArcBallControl({
	interactionEventsManager: eventManager,
	radius: 4.5,
	dragSpeed: 4.,
	zoomSpeed: 1.,
});

final uTime_s = new Uniform(0.0);

final fragmentRenderer = new FragmentRenderer(renderer);
final renderTargetStore = new RenderTargetStore(renderer);
final postProcess = new PostProcess(renderer);

final background = new BackgroundEnvironment();

final environmentManager = new EnvironmentManager(renderer, scene, (env) -> {});

var renderTargetParametersNeedUpdate = false;

function main() {
	document.body.appendChild(canvas);

	environmentManager.setEnvironmentMapPath('assets/env/snowy_forest_path_01_1k.rgbd.png');

	scene.add(background);
	scene.add(new LightingDebugProbes());

	animationFrame(window.performance.now());

	// developer code
	#if dev
	GUI.init();
	untyped window.renderer = renderer;
	untyped window.THREE = Three;
	untyped window.camera = camera;
	untyped window.scene = scene;
	#end
}

private var animationFrame_lastTime_ms = -1.0;
function animationFrame(time_ms: Float) {
	var time_s = time_ms / 1000;
	var dt_ms = animationFrame_lastTime_ms > 0 ? (time_ms - animationFrame_lastTime_ms) : 0.0;
	dt_ms = clamp(dt_ms, 1, 1000 / 30); // limit dt
	var dt_s = dt_ms / 1000;
	animationFrame_lastTime_ms = time_ms;

	uTime_s.value = time_s;

	var gl = renderer.getContext();

	// Rendering Pipeline
	{
		var targetSize = floor(vec2(window.innerWidth, window.innerHeight) * pixelRatio);
			
		// resize canvas and camera projection aspect if needed
		if (targetSize != vec2(gl.drawingBufferWidth, gl.drawingBufferHeight)) {
			canvas.width = floor(targetSize.x);
			canvas.height = floor(targetSize.y);
		}

		var viewportSize = vec2(targetSize.x, targetSize.y);

		var newAspect = viewportSize.x / viewportSize.y;
		if (camera.aspect != newAspect) {
			camera.aspect = newAspect;
			camera.updateProjectionMatrix();
		}
	}

	update(time_s, dt_s);

	// render to canvas	
	renderer.setRenderTarget(null);
	renderer.setViewport(0, 0, gl.drawingBufferWidth, gl.drawingBufferHeight);	
	renderer.clear(true, true, true);
	renderer.render(scene, camera);

	renderTargetParametersNeedUpdate = false;

	window.requestAnimationFrame(animationFrame);
}

function update(time_s: Float, dt_s: Float) {
	arcBallControl.step(dt_s);
	arcBallControl.applyToCamera(camera);
}