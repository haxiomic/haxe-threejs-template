package shaders;

class SignedDistances {

	public static final sdSegment = '
		// generalizes to n dimensions
		float sdSegment(vec2 x, vec2 a, vec2 b, out float alpha) {
			vec2 ab = b - a;
			vec2 ax = x - a;
			alpha = dot(ab, ax) / dot(ab, ab);
			vec2 d = ax - clamp(alpha, 0., 1.) * ab;
			return length(d);
		}

		float sdSegment(vec2 x, vec2 a, vec2 b) {
			float alpha;
			return sdSegment(x, a, b, alpha);
		}
	';

}