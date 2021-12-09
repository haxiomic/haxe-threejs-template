package three;

@:jsRequire("three", "Spherical") extern class Spherical {
	function new(?radius:Float, ?phi:Float, ?theta:Float);
	var radius : Float;
	var phi : Float;
	var theta : Float;
	function set(radius:Float, phi:Float, theta:Float):Spherical;
	function clone():Spherical;
	function copy(other:Spherical):Spherical;
	function makeSafe():Spherical;
	function setFromVector3(v:Vector3):Spherical;
	function setFromCartesianCoords(x:Float, y:Float, z:Float):Spherical;
	static var prototype : Spherical;
}