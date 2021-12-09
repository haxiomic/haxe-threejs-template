# Three.js Toolkit

This is an assortment of classes I use when developing three.js haxe projects. Feel free to use them too, however, it's not designed to be a user-friendly library and code here is likely to change frequently. To use it, it's best to link to a specific commit to avoid troubles building in the future

Happy to accept PRs and issues!

## Requirements
- I use three.js r133 via dts2hx, other version may work
- three.js r133 requires `-D js-es=6` (however three.js r121 does not)

```
npm install three@0.133.0 @types/three@0.133.0 dts2hx
npx dts2hx three
```

Some types rely on [VectorMath](https://github.com/haxiomic/vector-math), install with `haxelib install vector-math`
