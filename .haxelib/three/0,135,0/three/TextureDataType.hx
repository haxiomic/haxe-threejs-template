package three;

@:enum @:jsRequire("three") extern abstract TextureDataType(Int) from Int to Int {
	final UnsignedByteType : TextureDataType;
	final ByteType : TextureDataType;
	final ShortType : TextureDataType;
	final UnsignedShortType : TextureDataType;
	final IntType : TextureDataType;
	final UnsignedIntType : TextureDataType;
	final FloatType : TextureDataType;
	final HalfFloatType : TextureDataType;
	final UnsignedShort4444Type : TextureDataType;
	final UnsignedShort5551Type : TextureDataType;
	final UnsignedShort565Type : TextureDataType;
	final UnsignedInt248Type : TextureDataType;
}