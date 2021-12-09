package math;

class ExponentialMovingAverage {

	// decay parameter
	public var alpha: Float;

	public var average (default, null): Float;
	public var variance (default, null): Float;
	public var stdDev (default, null): Float;

	/**
		Using an alpha value closer to 1 means rapid exponential decay (fast transition to new values)
	**/
	public function new(initialValue: Float, alpha: Float) {
		this.alpha = alpha;
		this.average = initialValue;
		addSample(initialValue);
	}

	public function addSample(v: Float) {
		var q = v - average;
		average = average + alpha * q;
		variance = (1.0 - alpha) * (variance + alpha * q * q);
		stdDev = Math.sqrt(variance);
	}
	
}