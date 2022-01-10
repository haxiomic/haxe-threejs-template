# Haxe Three.js starter project

This is a batteries-include template project using three.js with the [haxe](https://haxe.org) language. [Main.hx](src/Main.hx) sets up a physically based rendering pipeline and some optimized HDR lighting environments are included [assets](assets/).

[See live](https://haxiomic.github.io/haxe-threejs-template)

## Building and running

- Download [haxe 4.2](https://haxe.org/download/version/4.2.4/)
- `cd` into this directory and install node modules with `npm install`
- Start an live server with `npm start`
- run `haxe build.hxml` to recompile the project into [bin/](bin/)

## Editing

[VSCode](https://code.visualstudio.com/) has great haxe IDE support with the haxe [extension](https://marketplace.visualstudio.com/items?itemName=nadako.vshaxe&ssr=false#review-details)

I recommend installing the [trigger task on save](https://marketplace.visualstudio.com/items?itemName=Gruntfuggly.triggertaskonsave) extension – this will trigger the project to recompile when you save haxe files, which is helpful for live editing

## Overview

We can interact with three.js through externs generated from the typescript type definitions using the [dts2hx](https://github.com/haxiomic/dts2hx) tool. The generated externs are include in this repository in the [.haxelib](.haxelib/) directory. To regenerate these files you can call `npm run externs`

three.js is as a module by using `require()`, since browsers don't have `require` we use a bundler ([esbuild](https://github.com/evanw/esbuild)) so we generate a single file. This is called by 