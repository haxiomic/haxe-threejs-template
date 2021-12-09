package tool;

import js.Lib;
import js.html.webgl.RenderingContext;

private typedef Times = {
	textureUploadTime_ms: Float,
	textureUploadCallCount: Int,
	programCompileTime_ms: Float,
	programCompileCallCount: Int,
	longestFrameTime_ms: Float,
	longestFrameChangeCount: Int,
}

class WebGLPerformanceMonitor {

	public var times: Times = {
		textureUploadTime_ms: 0.0,
		textureUploadCallCount: 0,
		programCompileTime_ms: 0.0,
		programCompileCallCount: 0,
		longestFrameTime_ms: 0.0,
		longestFrameChangeCount: 0,
	};

	public var onTextureUpload: (functionName: String, dt_ms: Float) -> Void = (_, _) -> {};
	public var onSubProgramCompile: (functionName: String, dt_ms: Float) -> Void = (_, _) -> {};
	public var onProgramCompile: (functionName: String, dt_ms: Float) -> Void = (_, _) -> {};
	public var onUpdate: (functionName: String, times: Times) -> Void = (_, _) -> {};
	
	public function new(gl: RenderingContext) {
		// monitor texture upload

		var onTextureUpload = (functionName, dt_ms: Float) -> {
			times.textureUploadTime_ms += dt_ms;
			times.textureUploadCallCount++;
			this.onTextureUpload(functionName, dt_ms);
			this.onUpdate(functionName, times);
		}

		monitorFunction(gl, 'texImage2D', onTextureUpload);
		monitorFunction(gl, 'texSubImage2D', onTextureUpload);
		monitorFunction(gl, 'compressedTexImage2D', onTextureUpload);
		monitorFunction(gl, 'compressedTexSubImage2D', onTextureUpload);

		// monitor shader compilation

		var onSubProgramCompile = (functionName, dt_ms) -> {
			times.programCompileTime_ms += dt_ms;
			// don't increment call count because we only want to consider complete programs
			this.onSubProgramCompile(functionName, dt_ms);
			this.onUpdate(functionName, times);
		}

		var onProgramCompile = (functionName, dt_ms) -> {
			times.programCompileTime_ms += dt_ms;
			times.programCompileCallCount++;
			this.onProgramCompile(functionName, dt_ms);
			this.onUpdate(functionName, times);
		}

		monitorFunction(gl, 'linkProgram', onProgramCompile);
		monitorFunction(gl, 'compileShader', onSubProgramCompile);
		monitorFunction(gl, 'validateProgram', onSubProgramCompile);
		monitorFunction(gl, 'createProgram', onSubProgramCompile);
		monitorFunction(gl, 'createShader', onSubProgramCompile);
		monitorFunction(gl, 'shaderSource', onSubProgramCompile);
		monitorFunction(gl, 'getShaderInfoLog', onSubProgramCompile);
		monitorFunction(gl, 'getShaderParameter', onSubProgramCompile);
		monitorFunction(gl, 'getShaderSource', onSubProgramCompile);
		monitorFunction(gl, 'getShaderPrecisionFormat', onSubProgramCompile);
		monitorFunction(gl, 'getAttachedShaders', onSubProgramCompile);
		monitorFunction(gl, 'getProgramInfoLog', onSubProgramCompile);
	}

	public function reset() {
		times = {
			textureUploadTime_ms: 0.0,
			textureUploadCallCount: 0,
			programCompileTime_ms: 0.0,
			programCompileCallCount: 0,
			longestFrameTime_ms: 0.0,
			longestFrameChangeCount: 0,
		};
	}

}

private function monitorFunction(obj: Any, functionName: String, onCalled: (functionName: String, dt_ms: Float) -> Void) {
	var obj: haxe.DynamicAccess<js.lib.Function> = obj;

	/** @type {Function} */
	var original = obj[functionName];

	obj[functionName] = cast function() {
		var t0 = js.Browser.window.performance.now();
		var ret = original.apply(Lib.nativeThis, js.Syntax.code('arguments'));
		var dt_ms = js.Browser.window.performance.now() - t0;
		onCalled(functionName, dt_ms);
		return ret;
	}
}