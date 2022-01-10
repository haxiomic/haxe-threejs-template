# Three.js Toolkit

This is an assortment of classes I use when developing three.js haxe projects. Feel free to use them too, however, it's not designed to be a user-friendly library and code here is likely to change frequently. To use it, it's best to link to a specific commit to avoid troubles building in the future

Happy to accept PRs and issues!

## Requirements
- I use three.js r135 via dts2hx, other version may work
- Newer versions of three.js require `-D js-es=6` (however three.js and earlier r121 does not)

To generate the required three.js types:
```
npm install three@0.135.0 @types/three@0.135.0 dts2hx
dts2hx three three/examples/jsm/loaders/RGBELoader three/examples/jsm/loaders/GLTFLoader three/examples/jsm/objects/Reflector -m
```

Some types rely on [VectorMath](https://github.com/haxiomic/vector-math), install with `haxelib install vector-math`

See [haxiomic/haxe-threejs-template](https://github.com/haxiomic/haxe-threejs-template) for an example on usage
