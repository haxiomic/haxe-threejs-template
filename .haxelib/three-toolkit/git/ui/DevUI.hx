package ui;

import haxe.macro.Printer;
#if (!macro)
import ui.dat_gui.GUIParams;
import ui.dat_gui.GUIController;
import ui.dat_gui.GUI;
import three.Material;
import three.MeshPhysicalMaterial;
import haxe.extern.EitherType;
import haxe.Constraints.Function;

/**
 * Extends dat.GUI with functions better suited for three.js and haxe
 * 
 * Built using dat.gui 0.7.7
 */
class DevUI extends ExposedGUI {

	public function new(options) {
		super(options);
		var styleEl = js.Browser.document.createStyleElement();
		styleEl.innerHTML = '
		.dg .title {
			overflow: hidden;
			white-space: nowrap;
		}
		/** allow function buttons to use all space **/
		.dg .function .property-name {
			width: auto;
			white-space: nowrap;
		}
		';
		js.Browser.document.head.appendChild(styleEl);
	}

	public var internal(get, null): GUI;
	inline function get_internal() return cast this;

	public override function addFolder(name:String): DevUI {
		return patchFolder(cast super.addFolder(name));
	}

	// implementation provided below in macro section
	public macro function addFunction(fn: ExprOf<Function>): ExprOf<GUIController> { }
	public macro function addMaterial(material: ExprOf<Material>): ExprOf<GUIController> { }
	public macro function addColor(color: ExprOf<three.Color>): ExprOf<GUIController> { }
	public macro function addDropdown<T>(self: Expr, target:ExprOf<T>, ?values: ExprOf< EitherType<Array<T>, Map<String, T>> > ): ExprOf<GUIController> { }
	public macro function addNumeric(self: Expr, numberExpr:ExprOf<Float>, ?min: ExprOf<Float>, ?max: ExprOf<Float>): ExprOf<GUIController> { }
	public macro function add<T>(g: Expr, prop: ExprOf<T>, ?min: ExprOf<Float>, ?max: ExprOf<Float>): ExprOf<GUIController> {}

	static function patchController(g: GUIController, getAssignSyntax: () -> Null<String>) {
		var e = g.domElement.closest('li');
		e.addEventListener('click', (e:js.html.MouseEvent) -> {
			if (e.getModifierState('Alt')) {
				e.preventDefault();
				e.stopImmediatePropagation();
			}
		}, true);
		untyped g.getAssignSyntax = getAssignSyntax;
		return g;
	}
	
	static function patchFolder(g: DevUI) {
		var e = g.domElement.closest('li');
		e.addEventListener('click', (e:js.html.MouseEvent) -> {
			if (e.getModifierState('Alt')) {
				var lines = [for (controller in g.internal.__controllers) {
					if (untyped controller.getAssignSyntax != null) {
						(untyped controller.getAssignSyntax(): String);
					} else {
						'// missing .getAssignSyntax() for ${controller.property}'; 
					}
				}];
				lines.filter(line -> line != null);
				
				js.Browser.console.log('// ${g.name}\n' + lines.join('\n'));
				e.preventDefault();
				e.stopImmediatePropagation();
			}
		}, true);
		return g;
	}

	static function internalAddMaterial(g: DevUI, material: Material, ?fallbackName: String): DevUI {
		var name = if (material.name == null || material.name == "") {
			fallbackName;
		} else {
			material.name;
		}

		// deduplicate folder names (disallowed by dat.GUI)
		while (Reflect.hasField(g.internal.__folders, name)) {
			var endNumReg = ~/(\d)+$/;
			name = if (endNumReg.match(name)) {
				var num = Std.parseInt(endNumReg.matched(1));
				endNumReg.matchedRight() + Std.string(num + 1);
			} else {
				name + '2';
			}
		}
		var g = g.addFolder(name);
		var m = material;

		var type = 'Material';

		g.add(m.visible);
		g.add(m.transparent);
		g.add(m.opacity, 0, 1);
		g.add(m.colorWrite);
		g.add(m.depthWrite);
		g.add(m.depthTest);

		if (m is three.MeshBasicMaterial) {
			var m: three.MeshBasicMaterial = cast m;
			g.add(m.color);
		}

		if (m is three.MeshStandardMaterial || m is material.CustomPhysicalMaterial) {
			type = 'MeshStandardMaterial';
			var m: three.MeshStandardMaterial = cast m;
			g.add(m.flatShading, 0, 1).onChange(_ -> m.needsUpdate = true);
			g.add(m.roughness, 0, 1);
			g.add(m.metalness, 0, 1);
			// g.add(m.refractionRatio, 0, 1);
			g.add(m.emissiveIntensity, 0, 20);
			g.add(m.color);
			g.add(m.emissive);
			g.add(m.side).onChange(_ -> m.needsUpdate = true);
			g.add(m.envMapIntensity, 0, 4);
			g.add(m.aoMapIntensity, 0, 4);
		}

		if (m is MeshPhysicalMaterial) {
			type = 'MeshPhysicalMaterial';
			var m: MeshPhysicalMaterial = cast m;
			g.add(m.clearcoat, 0, 1);
			g.add(m.clearcoatRoughness, 0, 1);
			g.add(m.transmission, 0, 1);
			g.add(m.ior, 0, 3);
			g.add(m.thickness, 0, 3);
			#if (three < "0.135.0")
			g.add(m.attenuationTint);
			#else
			g.add(m.attenuationColor);
			#end
			g.add(m.attenuationDistance, 0, 10);
			g.add(m.sheen, 0, 1);
			g.add(m.sheenRoughness, 0, 1);
			#if (three < "0.135.0")
			g.add(m.sheenTint);
			#else
			g.add(m.sheenColor);
			#end
		} else if (m is material.CustomPhysicalMaterial) {
			// repeat so than haxe properties are used
			type = 'CustomPhysicalMaterial';
			var m: material.CustomPhysicalMaterial = cast m;
			g.add(m.clearcoat, 0, 1);
			g.add(m.clearcoatRoughness, 0, 1);
			g.add(m.transmission, 0, 1);
			g.add(m.ior, 0, 3);
			g.add(m.thickness, 0, 4);
			#if (three < "0.135.0")
			g.add(m.attenuationTint);
			#else
			g.add(m.attenuationColor);
			#end
			g.add(m.attenuationDistance, 0, 10);
			g.add(m.sheen, 0, 1);
			g.add(m.sheenRoughness, 0, 1);
			#if (three < "0.135.0")
			g.add(m.sheenTint);
			#else
			g.add(m.sheenColor);
			#end
		}

		g.name = '$name :$type';

		return g;
	}

}

/**
 * Subset of dat.GUI we want to expose
 */
@:jsRequire("dat.gui", "GUI")
extern class ExposedGUI {
	var domElement: js.html.Element;
	var name: String;
	function new(?option:GUIParams);
	function addFolder(propName:String):ExposedGUI;
}

#else // if macro

import haxe.macro.Expr;
import haxe.macro.Context;
import haxe.macro.ExprTools;

class DevUI {

	public macro function addDropdown<T>(self: Expr, target:ExprOf<T>, ?options: ExprOf< EitherType<Array<T>, Map<String, T>> >): ExprOf<GUIController> {
		var name = expressionName(target);

		var targetType = Context.typeof(target);
		var optionsType = Context.typeof(options);

		var isOptionsNull = try ExprTools.getValue(options) == null catch(e: Any) false;

		var namesValues = if (!isOptionsNull) {
			if (Context.unify(optionsType, Context.getType('haxe.ds.StringMap'))) {
				names: macro [for(k => v in options) k],
				values: macro [for(k => v in options) v],
			} else if (Context.unify(optionsType, Context.getType('Array'))) {
				names: macro (options: Array<Any>).map(v -> Std.string(v)),
				values: macro options,
			} else {
				Context.error("options must be an Array or String Map", options.pos);
			}
		} else switch targetType {
			// enum abstract
			case TAbstract(_.get() => t, params) if (t.meta.has(':enum')):
				var enumFields = t.impl.get().statics.get().map(f -> f.name);
				var typePath = t.pack.concat([t.name]);
				var enumValues = enumFields
					.map(field -> typePath.concat([field]))
					.map(path -> macro $p{path});
				{
					names: macro $v{enumFields},
					values: macro $a{enumValues}
				}
			default:
				Context.error("Could not determine dropdown options", target.pos);
		}

		return macro @:privateAccess {
			var options = $options;
			var names = ${namesValues.names};
			var values = ${namesValues.values};
			var obj = {};
			for (i in 0...names.length) {
				Reflect.setField(obj, names[i], values[i]);
			}
			var g = $self;

			{
				var o = {};
				// use native javascript setter as a proxy
				js.lib.Object.defineProperty(o, $v{name}, {
					set: (__strValue) -> {
						// dat.gui makes all values a string, which is insane
						// let's search values and find the first with a matching string
						for(value in values) {
							if (Std.string(value) == __strValue) {
								$target = value;
								break;
							}
						}
					}, 
					get: () -> $target,
				});
				ui.DevUI.patchController(
					g.internal.add(o, $v{name}, obj).name($v{name}),
					() -> $v{new Printer().printExpr(target) + ' = '} + names[values.indexOf($target)] + ';'
				);
			}
		}
	}

	public macro function addColor(self: Expr, color: ExprOf<three.Color>) {
		var name = expressionName(color);

		return macro @:privateAccess {
			var g = $self;
			var color: three.Color = $color;
			if (color == null) {
				color = new three.Color();
				$color = color;
			}
			ui.DevUI.patchController(
				g.internal.addColor({c: color.getHex()}, 'c')
				.name($v{name})
				.onChange((hex) -> {
					color.setHex(hex);
				}),
				() -> $v{new Printer().printExpr(color)}+'.setHex(0x' + color.getHexString() + ');'
			);
		}
	}

	public macro function addFunction(self: Expr, fn: ExprOf<Function>) {
		var name = expressionName(fn);
		return macro @:privateAccess {
			ui.DevUI.patchController(
				$self.internal.add({'fn': $fn}, 'fn').name($v{name}),
				() -> $v{new Printer().printExpr(fn)} + ';'
			);
		};
	}

	public macro function addMaterial(self: Expr, material: ExprOf<Material>): ExprOf<GUIController> {
		var fallbackName = expressionName(material);
		return macro @:privateAccess {
			ui.DevUI.patchFolder(
				ui.DevUI.internalAddMaterial($self, $material, $v{fallbackName})
			);
		}
	}

	public macro function addNumeric(self: Expr, expr: ExprOf<Float>, ?min: ExprOf<Float>, ?max: ExprOf<Float>): ExprOf<GUIController> {
		var name = expressionName(expr);

		var type = Context.typeof(expr);

		var ret = macro {
			var o = {};
			// use native javascript setter as a proxy
			js.lib.Object.defineProperty(o, $v{name}, {
				set: (__value) -> $expr = __value,
				get: () -> $expr,
			});
			$self.internal.add(o, $v{name})
				.name($v{name});
		}

		// numeric min/max
		if (Context.unify(type, Context.getType('Float'))) { // is numeric
			ret = macro {
				var c = $ret;
				var min = $min;
				var max = $max;
				if (min != null) {
					c = c.min(min);
				}
				if (max != null) {
					c = c.max(max);
				}
				c;
			}

			// step(1) if Int
			var isInt = Context.unify(type, Context.getType('Int'));
			if (isInt) {
				ret = macro $ret.step(1);
			}
		}

		ret = macro @:privateAccess ui.DevUI.patchController(
			$ret,
			() -> $v{new Printer().printExpr(expr)} + ' = ' + $expr + ';'
		);

		return ret;
	}

	/**
		Little utility to better integrate with more advanced properties.

		Supports
		- Uniforms
		- three.Color
		- haxe get/set
	**/
	public macro function add<T>(g: Expr, expr: ExprOf<T>, ?min: ExprOf<Float>, ?max: ExprOf<Float>): ExprOf<GUIController> {
		var name = expressionName(expr);

		var type = Context.typeof(expr);
		
		// assume Float if type is unknown
		var isMonomorph = switch type {
			case TMono(t): true;
			default: false;
		}
		if (isMonomorph) {
			return macro $g.addNumeric($expr, $min, $max);
		}

		// unwrap Uniform<T> and Watchable<T>
		if (Context.unify(type, Context.getType('three.Uniform')) || Context.unify(type, Context.getType('ds.Watchable'))) {
			var typeParam = switch type {
				case TInst(_, [t]): t;
				default: Context.error('Expected single type parameter', Context.currentPos());
			}

			expr = macro $expr.value;
			type = typeParam;
		}

		return if (Context.unify(type, Context.getType('haxe.Constraints.Function'))) {
			macro $g.addFunction($expr);
		} else if (Context.unify(type, Context.getType('three.Color'))) {
			macro $g.addColor($expr);
		} else if (Context.unify(type, Context.getType('three.Material'))) {
			macro $g.addMaterial($expr);
		} else if (isEnumAbstract(type)) {
			macro $g.addDropdown($expr);
		} else {
			macro $g.addNumeric($expr, $min, $max).name($v{name});
		}
	}

	static function expressionName(expr: Expr) return switch expr.expr {
		case EField(e, field): field;
		case EConst(CIdent(ident)): ident;
		default: new haxe.macro.Printer().printExpr(expr);
	}

	static function isEnumAbstract(type: haxe.macro.Type) {
		return switch type {
			// enum abstract
			case TAbstract(_.get() => t, params) if (t.meta.has(':enum')): true;
			default: false;
		}
	}

}

#end