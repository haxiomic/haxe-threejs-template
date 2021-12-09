package three;

/**
	Overrides Uniform to give it a type parameter, which was removed from @types/three at one point
**/
@:jsRequire("three", "Uniform") extern class Uniform<T> {
	@:overload(function(type:String, value:T): Uniform<T> { })
	function new(value:T);
	var type : String;
	var value : T;
	@:native("dynamic")
	var dynamic_ : Bool;
	dynamic function onUpdateCallback():Void;
	function onUpdate(callback:haxe.Constraints.Function):Uniform<T>;
	static var prototype : Uniform<Any>;
}