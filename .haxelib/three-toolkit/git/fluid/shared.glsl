vec2 clipToSimSpace(vec2 clipSpace){
    return vec2(clipSpace.x / invResolution.z, clipSpace.y);
}

vec2 simToTexelSpace(vec2 simSpace){
    return vec2(simSpace.x * invResolution.z + 1.0 , simSpace.y + 1.0)*.5;
}

// pure Neumann boundary conditions: 0 pressure gradient across the boundary
// dP/dx = 0
// this is implict applied with CLAMP_TO_EDGE when reading from the pressure texture so we don't actually need to to anything in the shader
// #define PRESSURE_BOUNDARY

// free-slip boundary: the average flow across the boundary is restricted to 0
// avg(uA.xy, uB.xy) dot (boundary normal).xy = 0
// this is applied by reflecting the velocity across the boundary (i.e, multipling the boundary velocity by -1 when reading outside)

// must not make any changes to coord after it arrives from vertex shader (including no swizzle) to enable inter-stage texture prefetching
#define samplePressure(texture, coord) ( texture2D(pressure, coord).x )
#define outOfBoundsVelocityMultiplier(coord) (velocityBoundaryEnabled ? (step(vec2(0.), coord) * step(coord, vec2(1.)) * 2. - 1. ) : vec2(1.0))

#define sampleVelocity(texture, coord) ( outOfBoundsVelocityMultiplier(coord) * texture2D(velocity, coord).xy )