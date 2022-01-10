package three.examples.jsm.loaders.gltfloader;

typedef GLTFLoaderPlugin = {
	@:optional
	dynamic function beforeRoot():Null<js.lib.Promise<ts.Undefined>>;
	@:optional
	dynamic function afterRoot(result:GLTF):Null<js.lib.Promise<ts.Undefined>>;
	@:optional
	dynamic function loadMesh(meshIndex:Float):Null<js.lib.Promise<ts.AnyOf3<three.Group, three.Mesh<three.BufferGeometry, ts.AnyOf2<three.Material, Array<three.Material>>>, three.SkinnedMesh<three.BufferGeometry, ts.AnyOf2<three.Material, Array<three.Material>>>>>>;
	@:optional
	dynamic function loadBufferView(bufferViewIndex:Float):Null<js.lib.Promise<js.lib.ArrayBuffer>>;
	@:optional
	dynamic function loadMaterial(materialIndex:Float):Null<js.lib.Promise<three.Material>>;
	@:optional
	dynamic function loadTexture(textureIndex:Float):Null<js.lib.Promise<three.Texture>>;
	@:optional
	dynamic function getMaterialType(materialIndex:Float):Null<{
		var prototype : three.Material;
	}>;
	@:optional
	dynamic function extendMaterialParams(materialIndex:Float, materialParams:{ }):Null<js.lib.Promise<Dynamic>>;
	@:optional
	dynamic function createNodeMesh(nodeIndex:Float):Null<js.lib.Promise<ts.AnyOf3<three.Group, three.Mesh<three.BufferGeometry, ts.AnyOf2<three.Material, Array<three.Material>>>, three.SkinnedMesh<three.BufferGeometry, ts.AnyOf2<three.Material, Array<three.Material>>>>>>;
	@:optional
	dynamic function createNodeAttachment(nodeIndex:Float):Null<js.lib.Promise<three.Object3D<three.Event>>>;
};