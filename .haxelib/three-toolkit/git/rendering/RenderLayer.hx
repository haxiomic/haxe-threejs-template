package rendering;

enum abstract RenderLayer(Int) {
	var Main = 0;
	var Blended;
	var DepthPrepass;
	var WorldPosition;
	var UVPosition;
	@:to inline function toFloat(): Float return this;
}