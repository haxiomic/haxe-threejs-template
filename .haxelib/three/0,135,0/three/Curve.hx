package three;

/**
	An extensible curve object which contains methods for interpolation
	class Curve<T extends Vector>
**/
@:jsRequire("three", "Curve") extern class Curve<T> {
	function new();
	var type : String;
	/**
		This value determines the amount of divisions when calculating the cumulative segment lengths of a curve via .getLengths.
		To ensure precision when using methods like .getSpacedPoints, it is recommended to increase .arcLengthDivisions if the curve is very large.
	**/
	var arcLengthDivisions : Float;
	/**
		Returns a vector for point t of the curve where t is between 0 and 1
		getPoint(t: number, optionalTarget?: T): T;
	**/
	function getPoint(t:Float, ?optionalTarget:T):T;
	/**
		Returns a vector for point at relative position in curve according to arc length
		getPointAt(u: number, optionalTarget?: T): T;
	**/
	function getPointAt(u:Float, ?optionalTarget:T):T;
	/**
		Get sequence of points using getPoint( t )
		getPoints(divisions?: number): T[];
	**/
	function getPoints(?divisions:Float):Array<T>;
	/**
		Get sequence of equi-spaced points using getPointAt( u )
		getSpacedPoints(divisions?: number): T[];
	**/
	function getSpacedPoints(?divisions:Float):Array<T>;
	/**
		Get total curve arc length
	**/
	function getLength():Float;
	/**
		Get list of cumulative segment lengths
	**/
	function getLengths(?divisions:Float):Array<Float>;
	/**
		Update the cumlative segment distance cache
	**/
	function updateArcLengths():Void;
	/**
		Given u ( 0 .. 1 ), get a t to find p. This gives you points which are equi distance
	**/
	function getUtoTmapping(u:Float, distance:Float):Float;
	/**
		Returns a unit vector tangent at t. If the subclassed curve do not implement its tangent derivation, 2 points a
		small delta apart will be used to find its gradient which seems to give a reasonable approximation
		getTangent(t: number, optionalTarget?: T): T;
	**/
	function getTangent(t:Float, ?optionalTarget:T):T;
	/**
		Returns tangent at equidistance point u on the curve
		getTangentAt(u: number, optionalTarget?: T): T;
	**/
	function getTangentAt(u:Float, ?optionalTarget:T):T;
	/**
		Generate Frenet frames of the curve
	**/
	function computeFrenetFrames(segments:Float, ?closed:Bool):{
		var tangents : Array<Vector3>;
		var normals : Array<Vector3>;
		var binormals : Array<Vector3>;
	};
	function clone():Curve<T>;
	function copy(source:Curve<T>):Curve<T>;
	function toJSON():Dynamic;
	function fromJSON(json:Dynamic):Curve<T>;
	static var prototype : Curve<Dynamic>;
	static function create(constructorFunc:() -> Void, getPointFunc:() -> Void):() -> Void;
}