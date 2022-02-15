package noise;

import VectorMath;

// translated from noise4Dgrad.glsl
//
// Description : Array and textureless GLSL 2D/3D/4D simplex 
//               noise functions.
//      Author : Ian McEwan, Ashima Arts.
//  Maintainer : stegu
//     Lastmod : 20110822 (ijm)
//     License : Copyright (C) 2011 Ashima Arts. All rights reserved.
//               Distributed under the MIT License. See LICENSE file.
//               https://github.com/ashima/webgl-noise
//               https://github.com/stegu/webgl-noise
// 
// Gradient Calculation extended from noise3Dgrad.glsl by Mark A. Ropper (@Markyparky56)

private overload extern inline function permute(x: Vec4): Vec4 return mod(((x*34.0)+1.0)*x, 289);
private overload extern inline function permute(x: Float): Float return mod(((x*34.0)+1.0)*x, 289);

private overload extern inline function taylorInvSqrt(r: Vec4): Vec4 return 1.79284291400159 - 0.85373472095314 * r;
private overload extern inline function taylorInvSqrt(r: Float): Float return 1.79284291400159 - 0.85373472095314 * r;

private inline function lessThan(a: Vec4, b: Vec4) {
	return vec4(
		a.x < b.x ? 1 : 0,
		a.y < b.y ? 1 : 0,
		a.z < b.z ? 1 : 0,
		a.w < b.w ? 1 : 0
	);
}

inline function grad4(j: Float, ip: Vec4) {
  final ones = vec4(1.0, 1.0, 1.0, -1.0);
  var p = vec4(0.);
  var s = vec4(0.);

  p.xyz = floor( fract (vec3(j) * ip.xyz) * 7.0) * ip.z - 1.0;
  p.w = 1.5 - dot(abs(p.xyz), ones.xyz);
  s = vec4(lessThan(p, vec4(0.0)));
  p.xyz = p.xyz + (s.xyz*2.0 - 1.0) * s.www; 

  return p;
}

// (sqrt(5) - 1)/4 = F4, used once below
private inline final F4 = 0.309016994374947451;

function snoise(v: Vec4, outGradient: Vec4) {
	final C = vec4(
		0.138196601125011,  // (5 - sqrt(5))/20  G4
		0.276393202250021,  // 2 * G4
		0.414589803375032,  // 3 * G4
		-0.447213595499958); // -1 + 4 * G4
	
	// First corner
	var i = floor(v + dot(v, vec4(F4)) );
	var x0 = v - i + dot(i, C.xxxx);

	// Other corners

	// Rank sorting originally contributed by Bill Licea-Kane, AMD (formerly ATI)
	var i0 = vec4(0.);
	var isX = step( x0.yzw, x0.xxx );
	var isYZ = step( x0.zww, x0.yyz );
//  i0.x = dot( isX, vec3( 1.0 ) );
	i0.x = isX.x + isX.y + isX.z;
	i0.yzw = 1.0 - isX;
//  i0.y += dot( isYZ.xy, vec2( 1.0 ) );
	i0.y += isYZ.x + isYZ.y;
	i0.zw += 1.0 - isYZ.xy;
	i0.z += isYZ.z;
	i0.w += 1.0 - isYZ.z;

	// i0 now contains the unique values 0,1,2,3 in each channel
	var i3 = clamp( i0, 0.0, 1.0 );
	var i2 = clamp( i0-1.0, 0.0, 1.0 );
	var i1 = clamp( i0-2.0, 0.0, 1.0 );
	
	//  x0 = x0 - 0.0 + 0.0 * C.xxxx
	//  x1 = x0 - i1  + 1.0 * C.xxxx
	//  x2 = x0 - i2  + 2.0 * C.xxxx
	//  x3 = x0 - i3  + 3.0 * C.xxxx
	//  x4 = x0 - 1.0 + 4.0 * C.xxxx
	var x1 = x0 - i1 + C.xxxx;
	var x2 = x0 - i2 + C.yyyy;
	var x3 = x0 - i3 + C.zzzz;
	var x4 = x0 + C.wwww;

	// Permutations
	i = mod(i, 289); 
	var j0 = permute( permute( permute( permute(i.w) + i.z) + i.y) + i.x);
	var j1 = permute( permute( permute( permute (
			  i.w + vec4(i1.w, i2.w, i3.w, 1.0 ))
			+ i.z + vec4(i1.z, i2.z, i3.z, 1.0 ))
			+ i.y + vec4(i1.y, i2.y, i3.y, 1.0 ))
			+ i.x + vec4(i1.x, i2.x, i3.x, 1.0 ));

	// Gradients: 7x7x6 points over a cube, mapped onto a 4-cross polytope
	// 7*7*6 = 294, which is close to the ring size 17*17 = 289.
	var ip = vec4(1.0/294.0, 1.0/49.0, 1.0/7.0, 0.0) ;

	var p0 = grad4(j0,   ip);
	var p1 = grad4(j1.x, ip);
	var p2 = grad4(j1.y, ip);
	var p3 = grad4(j1.z, ip);
	var p4 = grad4(j1.w, ip);

	// Normalise gradients
	var norm = taylorInvSqrt(vec4(dot(p0,p0), dot(p1,p1), dot(p2, p2), dot(p3,p3)));
	p0 *= norm.x; 
	p1 *= norm.y; 
	p2 *= norm.z;
	p3 *= norm.w;
	p4 *= taylorInvSqrt(dot(p4,p4));

	// Mix contributions from the five corners
	var m0 = max(0.5 - vec3(dot(x0,x0), dot(x1,x1), dot(x2,x2)), 0.0);
	var m1 = max(0.5 - vec2(dot(x3,x3), dot(x4,x4)            ), 0.0);
	var m02 = m0 * m0;
	var m12 = m1 * m1; 
	var m04 = m02 * m02;
	var m14 = m12 * m12; 
	var pdotx0 = vec3(dot(p0,x0), dot(p1,x1), dot(p2,x2));
	var pdotx1 = vec2(dot(p3,x3), dot(p4,x4));

	var temp0 = m02 * m0 * pdotx0;
	var temp1 = m12 * m1 * pdotx1;
	outGradient.copyFrom(-8.0 * (temp0.x * x0 + temp0.y * x1 + temp0.z * x2 + temp1.x * x3 + temp1.y * x4));
	outGradient += m04.x * p0 + m04  .y * p1 + m04.z * p2 + m14.x * p3 + m14.y * p4;
	outGradient *= 109.319;

	return 109.319 * (  dot(m02*m02, vec3( dot( p0, x0 ), dot( p1, x1 ), dot( p2, x2 )))
		+ dot(m12*m12, vec2( dot( p3, x3 ), dot( p4, x4 ) ) ) ) ;
}