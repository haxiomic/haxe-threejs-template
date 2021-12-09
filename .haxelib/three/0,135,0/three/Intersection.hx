package three;

typedef Intersection<TIntersected> = {
	var distance : Float;
	@:optional
	var distanceToRay : Float;
	var point : Vector3;
	@:optional
	var index : Float;
	@:optional
	var face : Face;
	@:optional
	var faceIndex : Float;
	var object : TIntersected;
	@:optional
	var uv : Vector2;
	@:optional
	var instanceId : Float;
};