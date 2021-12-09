package three.examples.jsm.loaders.rgbeloader;

typedef RGBE = {
	var width : Float;
	var height : Float;
	var data : ts.AnyOf2<js.lib.Float32Array, js.lib.Uint8Array>;
	var header : String;
	var gamma : Float;
	var exposure : Float;
	var format : three.PixelFormat;
	var type : three.TextureDataType;
};