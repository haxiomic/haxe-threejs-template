package math;

import Math.*;

class Scalar {

	// GLSL style functions
	
	static public inline function mod(x: Float, m: Float) {
		return ( (x % m) + m ) % m;
	}

	static public inline function sign(x: Float) {
		return x >= 0 ? 1 : -1;
	}

	static public inline function fract(x: Float) {
		return abs(x % 1);
	}

	static public inline function mix(a: Float, b: Float, t: Float) {
		return a * (1.0  - t) + b * t;
	}

	static public inline function clamp(x: Float, min: Float, max: Float) {
		return x < min ? min : (x > max ? max : x);
	}

	static public inline function step(edge: Float, x: Float) {
		return x < edge ? 0.0 : 1.0;
	}

	static public inline function smoothstep(edge0: Float, edge1: Float, x: Float) {
		var t = clamp((x - edge0) / (edge1 - edge0), 0.0, 1.0);
		return t * t * (3.0 - 2.0 * t);
	}

	static public inline function linstep(edge0: Float, edge1: Float, x: Float) {
		return clamp((x - edge0) / (edge1 - edge0), 0.0, 1.0);
	}

	static public inline function int(?f: Float, ?b: Bool): Int {
		return if (f != null) Std.int(f);
		else if (b != null) b ? 1 : 0;
		else 0;
	}

	static public inline function float(?i: Int, ?b: Bool): Float {
		return if (i != null) i;
		else if (b != null) b ? 1.0 : 0.0;
		else 0.0;
	}

	static public inline function randomGaussian() {
		return sqrt(-2 * log(random())) * cos(2 * PI * random());
	}

	static public inline function randomGaussian2D() {
		// https://en.wikipedia.org/wiki/Box%E2%80%93Muller_transform
		var u1 = random();
		var u2 = random();
		return {
			x: sqrt(-2 * log(u1)) * cos(2 * PI * u2),
			y: sqrt(-2 * log(u2)) * cos(2 * PI * u1)
		}
	}

	static public inline function cubicPulse(c: Float, w: Float, x: Float){
		x = abs(x - c);
		if( x>w ) return 0.0;
		x /= w;
		return 1.0 - x*x*(3.0-2.0*x);
	}

	static public inline final LN2 = 0.6931471805599453;
	static public inline function floorPowerOfTwo(x: Float) {
		return Math.pow(2, Math.floor(Math.log(x) / LN2));
	}
	static public inline function ceilPowerOfTwo(x: Float) {
		return Math.pow(2, Math.ceil(Math.log(x) / LN2));
	}

}