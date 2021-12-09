package three;

@:enum @:jsRequire("three") extern abstract ToneMapping(Int) from Int to Int {
	final NoToneMapping : ToneMapping;
	final LinearToneMapping : ToneMapping;
	final ReinhardToneMapping : ToneMapping;
	final CineonToneMapping : ToneMapping;
	final ACESFilmicToneMapping : ToneMapping;
}