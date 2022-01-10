# Haxe Three.js starter project

This is a batteries-include template project using three.js with the [haxe](https://haxe.org) language. [Main.hx](src/Main.hx) sets up a physically based rendering pipeline and some optimized HDR lighting environments are include in [assets/](https://github.com/haxiomic/haxe-threejs-template/blob/master/assets/)

[See live](https://haxiomic.github.io/haxe-threejs-template)

<img width="957" alt="Screenshot 2022-01-10 at 12 52 07" src="https://user-images.githubusercontent.com/3742992/148768898-74beacc4-0358-49c5-bdf7-86c981b6cbd6.png">

## Building and running

- Download [haxe 4.2](https://haxe.org/download/version/4.2.4/)
- `cd` into this directory and install node modules with `npm install`
- Start an live server with `npm start`
- run `haxe build.hxml` to recompile the project into [bin/](https://github.com/haxiomic/haxe-threejs-template/blob/master/bin/)

## Editing

[VSCode](https://code.visualstudio.com/) has great haxe IDE support with the haxe [extension](https://marketplace.visualstudio.com/items?itemName=nadako.vshaxe&ssr=false#review-details)

I recommend installing the [trigger task on save](https://marketplace.visualstudio.com/items?itemName=Gruntfuggly.triggertaskonsave) extension – this will trigger the project to recompile when you save haxe files, which is helpful for live editing

## Project Overview

We can interact with three.js through externs generated from the typescript type definitions using the [dts2hx](https://github.com/haxiomic/dts2hx) tool. The generated externs are include in this repository in the [.haxelib](https://github.com/haxiomic/haxe-threejs-template/blob/master/.haxelib/) directory. To regenerate these files you can call `npm run externs`

three.js is included as a module by using `require()`, since browsers don't have `require` we use a bundler ([esbuild](https://github.com/evanw/esbuild)) so we generate a single file – this is called by [build.hxml](https://github.com/haxiomic/haxe-threejs-template/blob/master/build.hxml). Alternatively we could have used three.js globally via a script tag if we generated the externs with [`--global`](https://github.com/haxiomic/dts2hx#faq)

A haxe library, [three-toolkit](https://github.com/haxiomic/three-toolkit) is included, which provides useful utilities for working with three.js and haxe, including
- Post processing pipeline tools
- A dat.gui extension: [DevUI](https://github.com/haxiomic/haxe-threejs-template/blob/master/.haxelib/three-toolkit/git/ui/DevUI.hx)
- [CustomPhysicalMaterial](https://github.com/haxiomic/haxe-threejs-template/blob/master/.haxelib/three-toolkit/git/material/CustomPhysicalMaterial.hx) for making pbr materials with custom shaders
- Objects such as a soft mirror plane
- Spring physics animation tooling

Have fun :D, feel free to open issues if you have questions