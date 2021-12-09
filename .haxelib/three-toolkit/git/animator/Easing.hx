package animator;

typedef EasingFunction = (x0:Float, x1:Float, duration:Float, t:Float) -> Float;

class Easing {

	static public inline function linear(x0:Float, x1:Float, duration:Float, t:Float):Float
		return x0 + (x1 - x0)*(t / duration);

	static public inline function sineIn(x0:Float, x1:Float, duration:Float, t:Float):Float
		return x1 - (x1 - x0)*Math.cos((Math.PI/2)*(t/duration));

	static public inline function sineOut(x0:Float, x1:Float, duration:Float, t:Float):Float
		return x0 + (x1 - x0)*Math.sin((Math.PI/2)*(t/duration));

	static public inline function sineInOut(x0:Float, x1:Float, duration:Float, t:Float):Float
		return x0 - .5*(x1 - x0)*(Math.cos(Math.PI * (t / duration)) - 1);

	static public inline function quadIn(x0:Float, x1:Float, duration:Float, t:Float):Float{
		t /= duration;
		return (x1 - x0)*t*t + x0;
	}

	static public inline function quadOut(x0:Float, x1:Float, duration:Float, t:Float):Float{
		t /= duration;
		return -(x1 - x0)*t*(t-2) + x0;
	}

	static public inline function quadInOut(x0:Float, x1:Float, duration:Float, t:Float):Float{
		t *= 2/duration;
		if(t < 1) return (x1 - x0)*.5*t*t + x0;
		t--;
		return -(x1 - x0)*.5*(t*(t-2) - 1) + x0;
	}

	static public inline function cubicIn(x0:Float, x1:Float, duration:Float, t:Float):Float{
		t /= duration;
		return (x1 - x0)*t*t*t + x0;
	}

	static public inline function cubicOut(x0:Float, x1:Float, duration:Float, t:Float):Float{
		t = (t/duration) - 1;
		return (x1 - x0)*(t*t*t + 1) + x0;
	}

	static public inline function cubicInOut(x0:Float, x1:Float, duration:Float, t:Float):Float{
		t *= 2/duration;
		if(t < 1) return (x1 - x0)*.5*t*t*t + x0;
		t -= 2;
		return (x1 - x0)*.5*(t*t*t + 2) + x0;
	}

}