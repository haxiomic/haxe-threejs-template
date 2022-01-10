package three.examples.jsm.loaders.gltfloader;

@:jsRequire("three/examples/jsm/loaders/GLTFLoader", "GLTFParser") extern class GLTFParser {
	function new();
	var json : Dynamic;
	var options : {
		var path : String;
		var manager : three.LoadingManager;
		var ktx2Loader : three.examples.jsm.loaders.ktx2loader.KTX2Loader;
		var meshoptDecoder : Dynamic;
		var crossOrigin : String;
		var requestHeader : { };
	};
	var fileLoader : three.FileLoader;
	var textureLoader : ts.AnyOf2<three.TextureLoader, three.ImageBitmapLoader>;
	var plugins : GLTFLoaderPlugin;
	var extensions : { };
	var associations : js.lib.Map<ts.AnyOf3<three.Object3D<three.Event>, three.Material, three.Texture>, GLTFReference>;
	dynamic function getDependency(type:String, index:Float):js.lib.Promise<Dynamic>;
	dynamic function getDependencies(type:String):js.lib.Promise<Array<Dynamic>>;
	dynamic function loadBuffer(bufferIndex:Float):js.lib.Promise<js.lib.ArrayBuffer>;
	dynamic function loadBufferView(bufferViewIndex:Float):js.lib.Promise<js.lib.ArrayBuffer>;
	dynamic function loadAccessor(accessorIndex:Float):js.lib.Promise<ts.AnyOf2<three.BufferAttribute, three.InterleavedBufferAttribute>>;
	dynamic function loadTexture(textureIndex:Float):js.lib.Promise<three.Texture>;
	dynamic function loadTextureImage(textureIndex:Float, source:{ }, loader:three.Loader):js.lib.Promise<three.Texture>;
	dynamic function assignTexture(materialParams:{ }, mapName:String, mapDef:{ var index : Float; @:optional var texCoord : Float; @:optional var extensions : Dynamic; }):js.lib.Promise<ts.Undefined>;
	dynamic function assignFinalMaterial(object:three.Mesh<three.BufferGeometry, ts.AnyOf2<three.Material, Array<three.Material>>>):Void;
	dynamic function getMaterialType():{
		var prototype : three.MeshStandardMaterial;
	};
	dynamic function loadMaterial(materialIndex:Float):js.lib.Promise<three.Material>;
	dynamic function createUniqueName(originalName:String):String;
	dynamic function createNodeMesh(nodeIndex:Float):js.lib.Promise<ts.AnyOf3<three.Group, three.Mesh<three.BufferGeometry, ts.AnyOf2<three.Material, Array<three.Material>>>, three.SkinnedMesh<three.BufferGeometry, ts.AnyOf2<three.Material, Array<three.Material>>>>>;
	dynamic function loadGeometries(primitives:Array<{ }>):js.lib.Promise<Array<three.BufferGeometry>>;
	dynamic function loadMesh(meshIndex:Float):js.lib.Promise<ts.AnyOf3<three.Group, three.Mesh<three.BufferGeometry, ts.AnyOf2<three.Material, Array<three.Material>>>, three.SkinnedMesh<three.BufferGeometry, ts.AnyOf2<three.Material, Array<three.Material>>>>>;
	dynamic function loadCamera(cameraIndex:Float):js.lib.Promise<three.Camera>;
	dynamic function loadSkin(skinIndex:Float):js.lib.Promise<{
		var joints : Array<Float>;
		@:optional
		var inverseBindMatrices : ts.AnyOf2<three.BufferAttribute, three.InterleavedBufferAttribute>;
	}>;
	dynamic function loadAnimation(animationIndex:Float):js.lib.Promise<three.AnimationClip>;
	dynamic function loadNode(nodeIndex:Float):js.lib.Promise<three.Object3D<three.Event>>;
	dynamic function loadScene():js.lib.Promise<three.Group>;
	static var prototype : GLTFParser;
}