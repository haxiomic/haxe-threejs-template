package three;

@:jsRequire("three", "PropertyBinding") extern class PropertyBinding {
	function new(rootNode:Dynamic, path:String, ?parsedPath:Dynamic);
	var path : String;
	var parsedPath : Dynamic;
	var node : Dynamic;
	var rootNode : Dynamic;
	function getValue(targetArray:Dynamic, offset:Float):Dynamic;
	function setValue(sourceArray:Dynamic, offset:Float):Void;
	function bind():Void;
	function unbind():Void;
	var BindingType : { };
	var Versioning : { };
	var GetterByBindingType : Array<() -> Void>;
	var SetterByBindingTypeAndVersioning : Array<Array<() -> Void>>;
	static var prototype : PropertyBinding;
	static function create(root:Dynamic, path:Dynamic, ?parsedPath:Dynamic):ts.AnyOf2<PropertyBinding, three.propertybinding.Composite>;
	static function sanitizeNodeName(name:String):String;
	static function parseTrackName(trackName:String):ParseTrackNameResults;
	static function findNode(root:Dynamic, nodeName:String):Dynamic;
}