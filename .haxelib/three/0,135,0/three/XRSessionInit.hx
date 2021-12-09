package three;

typedef XRSessionInit = {
	@:optional
	var optionalFeatures : Array<String>;
	@:optional
	var requiredFeatures : Array<String>;
};