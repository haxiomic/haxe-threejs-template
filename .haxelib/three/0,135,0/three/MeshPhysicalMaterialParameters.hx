package three;

typedef MeshPhysicalMaterialParameters = {
	@:optional
	var clearcoat : Float;
	@:optional
	var clearcoatMap : Texture;
	@:optional
	var clearcoatRoughness : Float;
	@:optional
	var clearcoatRoughnessMap : Texture;
	@:optional
	var clearcoatNormalScale : Vector2;
	@:optional
	var clearcoatNormalMap : Texture;
	@:optional
	var reflectivity : Float;
	@:optional
	var ior : Float;
	@:optional
	var sheen : Float;
	@:optional
	var sheenColor : Color;
	@:optional
	var sheenRoughness : Float;
	@:optional
	var transmission : Float;
	@:optional
	var transmissionMap : Texture;
	@:optional
	var attenuationDistance : Float;
	@:optional
	var attenuationColor : Color;
	@:optional
	var specularIntensity : Float;
	@:optional
	var specularColor : Color;
	@:optional
	var specularIntensityMap : Texture;
	@:optional
	var specularColorMap : Texture;
	@:optional
	var color : ColorRepresentation;
	@:optional
	var roughness : Float;
	@:optional
	var metalness : Float;
	@:optional
	var map : Texture;
	@:optional
	var lightMap : Texture;
	@:optional
	var lightMapIntensity : Float;
	@:optional
	var aoMap : Texture;
	@:optional
	var aoMapIntensity : Float;
	@:optional
	var emissive : ColorRepresentation;
	@:optional
	var emissiveIntensity : Float;
	@:optional
	var emissiveMap : Texture;
	@:optional
	var bumpMap : Texture;
	@:optional
	var bumpScale : Float;
	@:optional
	var normalMap : Texture;
	@:optional
	var normalMapType : NormalMapTypes;
	@:optional
	var normalScale : Vector2;
	@:optional
	var displacementMap : Texture;
	@:optional
	var displacementScale : Float;
	@:optional
	var displacementBias : Float;
	@:optional
	var roughnessMap : Texture;
	@:optional
	var metalnessMap : Texture;
	@:optional
	var alphaMap : Texture;
	@:optional
	var envMap : Texture;
	@:optional
	var envMapIntensity : Float;
	@:optional
	var refractionRatio : Float;
	@:optional
	var wireframe : Bool;
	@:optional
	var wireframeLinewidth : Float;
	@:optional
	var flatShading : Bool;
	@:optional
	var alphaTest : Float;
	@:optional
	var alphaToCoverage : Bool;
	@:optional
	var blendDst : BlendingDstFactor;
	@:optional
	var blendDstAlpha : Float;
	@:optional
	var blendEquation : BlendingEquation;
	@:optional
	var blendEquationAlpha : Float;
	@:optional
	var blending : Blending;
	@:optional
	var blendSrc : ts.AnyOf2<BlendingDstFactor, BlendingSrcFactor>;
	@:optional
	var blendSrcAlpha : Float;
	@:optional
	var clipIntersection : Bool;
	@:optional
	var clippingPlanes : Array<Plane>;
	@:optional
	var clipShadows : Bool;
	@:optional
	var colorWrite : Bool;
	@:optional
	var defines : Dynamic;
	@:optional
	var depthFunc : DepthModes;
	@:optional
	var depthTest : Bool;
	@:optional
	var depthWrite : Bool;
	@:optional
	var fog : Bool;
	@:optional
	var name : String;
	@:optional
	var opacity : Float;
	@:optional
	var polygonOffset : Bool;
	@:optional
	var polygonOffsetFactor : Float;
	@:optional
	var polygonOffsetUnits : Float;
	@:optional
	var precision : String;
	@:optional
	var premultipliedAlpha : Bool;
	@:optional
	var dithering : Bool;
	@:optional
	var side : Side;
	@:optional
	var shadowSide : Side;
	@:optional
	var toneMapped : Bool;
	@:optional
	var transparent : Bool;
	@:optional
	var vertexColors : Bool;
	@:optional
	var visible : Bool;
	@:optional
	var format : PixelFormat;
	@:optional
	var stencilWrite : Bool;
	@:optional
	var stencilFunc : StencilFunc;
	@:optional
	var stencilRef : Float;
	@:optional
	var stencilWriteMask : Float;
	@:optional
	var stencilFuncMask : Float;
	@:optional
	var stencilFail : StencilOp;
	@:optional
	var stencilZFail : StencilOp;
	@:optional
	var stencilZPass : StencilOp;
	@:optional
	var userData : Dynamic;
};