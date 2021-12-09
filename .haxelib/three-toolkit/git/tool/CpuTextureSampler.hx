package tool;

import js.lib.Float32Array;

enum abstract WrapMode(Int) {
	var REPEAT;
	var CLAMP;
}

class CpuTextureSampler {

	public var width: Int;
	public var height: Int;
	public var pixels: Float32Array;
	public var wrapS: WrapMode;
	public var wrapT: WrapMode;

	public function new(tightlyPackedPixels: Float32Array, width: Int, height: Int, wrapS = CLAMP, wrapT = CLAMP) {
		this.pixels = tightlyPackedPixels;
		this.width = width;
		this.height = height;
		this.wrapS = wrapS;
		this.wrapT = wrapT;
	}

	public function sampleLinear(uvX: Float, uvY: Float) {
		// repeat wrapping
		var x = uvX * width + 0.5;
		var y = uvY * height + 0.5;
		var i = Math.floor(x);
		var j = Math.floor(y);

		var fx = mod(x, 1.);
		var fy = mod(y, 1.);

		var tl = getPixel(i - 1, j);
		var tr = getPixel(i, j);
		var bl = getPixel(i - 1, j - 1);
		var br = getPixel(i, j - 1);

		var topRow = tl * (1.0 - fx) + tr * fx;
		var bottomRow = bl * (1.0 - fx) + br * fx;
		var bilerp = bottomRow * (1.0 - fy) + topRow * fy;

		return bilerp;
	}

	public function sampleNearest(uvX: Float, uvY: Float) {
		// repeat wrapping
		var i = Math.floor(uvX * width);
		var j = Math.floor(uvY * height);
		return getPixel(i, j);
	}

	public function getPixel(i: Int, j: Int) {
		// repeat wrapping
		i = switch wrapS {
			case REPEAT: Std.int(mod(i, width));
			case CLAMP: i < 0 ? 0 : (i >= width ? width - 1 : i);
		}
		j = switch wrapS {
			case REPEAT: Std.int(mod(j, height));
			case CLAMP: j < 0 ? 0 : (j >= height ? height - 1 : j);
		}
		return pixels[j * width + i];
	}

	inline function mod(n: Float, m: Float) {
		return ((n % m) + m) % m;
	}

}