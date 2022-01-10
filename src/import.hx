// importing modules in import.hx enables these modules in all files

#if js
// import browser externs so we can use `window` and `document` everywhere
import js.Browser.*;
// import vector math so we can use vector expressions like `vec2()` `mat4()`
import VectorMath;
#end