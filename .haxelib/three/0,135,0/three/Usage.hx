package three;

@:enum @:jsRequire("three") extern abstract Usage(Int) from Int to Int {
	final StaticDrawUsage : Usage;
	final DynamicDrawUsage : Usage;
	final StreamDrawUsage : Usage;
	final StaticReadUsage : Usage;
	final DynamicReadUsage : Usage;
	final StreamReadUsage : Usage;
	final StaticCopyUsage : Usage;
	final DynamicCopyUsage : Usage;
	final StreamCopyUsage : Usage;
}