// clip-space
attribute vec2 position;

uniform vec3 invResolution; // (1/w, 1/h, h/w)

#ifdef UV
varying vec2 vUv;
#endif

#ifdef FINITE_DIFFERENCE
// precomute texel offsets as varyings to enable texture prefetching
varying vec2 vL;
varying vec2 vR;
varying vec2 vB;
varying vec2 vT;
#endif

#ifdef SIMULATION_POSITION
// clip-space where aspect ratio is maintained and height is fixed at 1
varying vec2 p;
#endif

void main() {
	vec2 texelCoord = position * 0.5 + 0.5;
	
	#ifdef FINITE_DIFFERENCE
	vL = texelCoord - vec2(invResolution.x,0);
	vR = texelCoord + vec2(invResolution.x,0);
	vB = texelCoord - vec2(0,invResolution.y);
	vT = texelCoord + vec2(0,invResolution.y);
	#endif

	#ifdef UV
	vUv = texelCoord;
	#endif
	
	#ifdef SIMULATION_POSITION
	p = vec2(position.x / invResolution.z, position.y);
	#endif

	gl_Position = vec4(position, 0.0, 1.0 );	
}
