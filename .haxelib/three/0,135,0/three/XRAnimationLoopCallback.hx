package three;

typedef XRAnimationLoopCallback = ts.AnyOf2<(time:Float) -> Void, (time:Float, frame:XRFrame) -> Void>;