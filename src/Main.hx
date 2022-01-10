import app.InteractionEventsManager;
import environment.EnvironmentManager;
import rendering.BackgroundEnvironment;
import three.PlaneGeometry;
import three.Scene;
import three.Uniform;
import three.examples.jsm.loaders.gltfloader.GLTFLoader;
import tool.CompileTime;
import ui.DevUI;

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
	radius: 4.,
	dragSpeed: 4.,
	zoomSpeed: 1.,
});

final uTime_s = new Uniform(0.0);

final background = new BackgroundEnvironment();
final environmentManager = new EnvironmentManager(renderer, scene, 'assets/env/kiara_1_dawn_2k.rgbd.png', (env) -> {});

// embed the glb model as a base64 string
final haxeLogoDataUrl = 'data:model/gltf-binary;base64,' + CompileTime.embedBase64('haxe-logo.glb');

var renderTargetParametersNeedUpdate = false;

@:keep var devUI = initDevUI();

function main() {
	document.body.appendChild(canvas);

	// create scene
	// load a hdr environment texture and add the background object
	scene.add(background);

	// load our haxe logo glb file
	new GLTFLoader().load(haxeLogoDataUrl, (gltf) -> {
		gltf.scene.position.y = 1;
		scene.add(gltf.scene);
	});

	// nice reflective floor
	var floor = new objects.GlassReflectiveFloor(new PlaneGeometry(10, 10));
	floor.rotateX(-Math.PI * .5);
	floor.reflectorResolution = 0.15;
	floor.reflectorKernel = 0.075;
	floor.reflectorMaterial.transparent = true;
	floor.reflectorMaterial.opacity = 0.25;
	scene.add(floor);
	var floorUI = devUI.addFolder('Floor');
	floorUI.add(floor.reflectorResolution, 0, 1);
	floorUI.add(floor.reflectorKernel, 0, 0.1);

	// set camera look-at target
	arcBallControl.target.y = 1.;

	// begin frame loop
	animationFrame(window.performance.now());
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

	// handle if canvas has resized since the last frame
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

	// update world state for this frame
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

function initDevUI() {
	var gui = new DevUI({
		closed: false,
	});

	gui.domElement.style.userSelect = 'none';
	gui.domElement.parentElement.style.zIndex = '1000';
	
	{	// Rendering pipeline
		var g = gui.addFolder('Rendering');
		g.add(pixelRatio, 0.1, 4).name('resolution');
		g.add(camera.fov, 1, 200).onChange(_ -> camera.updateProjectionMatrix());

		var renderer = renderer;
		g.add(renderer.toneMapping).onChange(v -> {
			// little three.js workaround: force shader rebuild
			var outputEncoding = renderer.outputEncoding;
			renderer.outputEncoding = null;
			window.requestAnimationFrame(t -> renderer.outputEncoding = outputEncoding);
		});

		g.add(renderer.outputEncoding);
		g.add(renderer.toneMappingExposure, 0, 4);
		g.add(renderer.shadowMap.enabled).name('Shadows');
		g.addDropdown(environmentManager.environmentPath, CompileTime.getPathsInDirectory('assets/env', ~/(\.rgbd\.png|\.hdr)$/igm));
		g.add(background.roughness, 0, 1).name('Background Blur');

		g.addFunction(() -> environmentManager.downloadPmremEnvironmentMap()).name("Download Processed HDR");
	}

	{	// Controls
		var g = gui.addFolder('Controls');
		var c = arcBallControl;
		g.add(c.dragSpeed, 0, 15);
		g.add(c.zoomSpeed, 0, 20);
		g.add(c.strength, 0, 1000);
		g.add(c.damping, 0, 200);
	}

	return gui;
}