# Haxe + three.js starter project

This is a batteries-included template project using three.js with the [haxe](https://haxe.org) language. [Main.hx](src/Main.hx) sets up a physically based rendering pipeline and some optimized HDR lighting environments are include in [assets/env](assets/env)

[See live](https://haxiomic.github.io/haxe-threejs-template)

[<img width="954" alt="Screenshot 2022-01-10 at 15 43 34" src="https://user-images.githubusercontent.com/3742992/148794626-7e7b98c8-6519-444d-97e7-d0b588349c50.png">](https://haxiomic.github.io/haxe-threejs-template)

## Building and running

- Download [haxe 4.2](https://haxe.org/download/version/4.2.4/)
- `cd` into this directory and install node modules with `npm install`
- Start an live server with `npm start`
- run `haxe build.hxml` to recompile the project into [bin/](bin/)

## Editing

[VSCode](https://code.visualstudio.com/) has great haxe IDE support with the haxe [extension](https://marketplace.visualstudio.com/items?itemName=nadako.vshaxe&ssr=false#review-details)

I recommend installing the [trigger task on save](https://marketplace.visualstudio.com/items?itemName=Gruntfuggly.triggertaskonsave) extension – this will trigger the project to recompile when you save haxe files, which is helpful for live editing

## Project Overview

We can interact with three.js through externs generated from the typescript type definitions using the [dts2hx](https://github.com/haxiomic/dts2hx) tool. The generated externs are included in this repository in the [.haxelib](.haxelib/) directory. To regenerate these files you can call `npm run externs`

three.js is included as a module by using `require()`, since browsers don't have `require` we use a bundler ([esbuild](https://github.com/evanw/esbuild)) so we generate a single file – this is called by [build.hxml](build.hxml). Alternatively we could have used three.js globally via a script tag if we generated the externs with [`--global`](https://github.com/haxiomic/dts2hx#faq)

A haxe library, [three-toolkit](https://github.com/haxiomic/three-toolkit) is included, which provides useful utilities for working with three.js and haxe, including
- Post processing pipeline tools
- A dat.gui extension: [DevUI](.haxelib/three-toolkit/git/ui/DevUI.hx)
- [CustomPhysicalMaterial](.haxelib/three-toolkit/git/material/CustomPhysicalMaterial.hx) for making pbr materials with custom shaders
- Objects such as a soft mirror plane
- Spring physics animation tooling

## Why haxe not TypeScript?
Where TypeScript improves on JavaScript by adding types, haxe asks how could we build a better language from ECMAScript foundations, without maintaining the warts from js. On the surface syntactically it's similar to TS but differs in a few key ways:
- metaprogrammig: you can mark functions for compile-time execution
- there's only one way import code, simply `import Module;`
- `this` only refers to the current type and does not change on context at runtime
- it supports functional programming patterns inspired my meta languages like OCaml:
    - [everything is an expression](https://code.haxe.org/category/principles/everything-is-an-expression.html)
    - [pattern matching switch expression](https://haxe.org/manual/lf-pattern-matching-structure.html)
- significantly faster compile-times
- zero-cost abstraction types with [`abstracts`](https://haxe.org/blog/zero-cost-abstracts/)

Have fun :D, feel free to open issues if you have questions
