#if macro
import haxe.macro.Type.ClassType;
import haxe.macro.Context;
import haxe.macro.Expr;
#end

/**
	Extend a structure with another

	If the extending structure has `@:optional` fields, these are skipped if `null`
**/
macro function extend(a, b) {
	var aType = Context.followWithAbstracts(Context.typeof(a));
	var bType = Context.followWithAbstracts(Context.typeof(b));

	return switch [aType, bType] {
		case [TAnonymous(_.get() => aAnon), TAnonymous(_.get() => bAnon)]:

			var extendedFieldMap = new Map<String, Expr>();

			for (field in aAnon.fields) {
				var name = field.name;
				var isOptional = field.meta.has(':optional');

				extendedFieldMap.set(name, macro a.$name);
			}

			for (field in bAnon.fields) {
				var name = field.name;
				var isOptional = field.meta.has(':optional');

				var expr = if (isOptional) {

					// this block is just to improve on nullSafety which currently incorrectly infers Null<T>
					var baseField = Lambda.find(aAnon.fields, cf -> cf.name == name);
					if (baseField != null) {
						var e = macro b.$name != null ? b.$name : a.$name;

						var baseFieldIsOptional = baseField.meta.has(':optional');
						if (!baseFieldIsOptional) {
							var nonNullType = unwrapNull(Context.toComplexType(field.type));
							e = macro ($e : $nonNullType);
						}
						e;
					} else {
						macro b.$name;
					}
				} else {
					macro b.$name;
				}

				extendedFieldMap.set(name, expr);
			}

			var extendedFields: Array<ObjectField> = [
				for (name => expr in extendedFieldMap) { field: name, expr: expr }
			];

			var objExpr: Expr = {
				expr: EObjectDecl(extendedFields),
				pos: Context.currentPos()
			};

			return macro {
				var a = $a;
				var b = $b;
				$objExpr;
			};
		default:
			Context.fatalError('Can only extend structures', Context.currentPos());
	}
}

function extendAny<T>(base: T, extendWidth: Any): T {
	var extended = {};
	if (base != null) for (field in Reflect.fields(base)) {
		Reflect.setField(extended, field, Reflect.field(base, field));
	}
	if (extendWidth != null) for (field in Reflect.fields(extendWidth)) {
		Reflect.setField(extended, field, Reflect.field(extendWidth, field));
	}
	return cast extended;
}

/**
 * Copy fields from a structure or class to any other instance
 * @param from 
 * @param to 
 * @param options pass {excludes: [fields]} to exclude specific fields
 */
macro function copyFields(from: Expr, to: Expr, ?options: {exclude: Array<String>}) {
	var fieldNames = switch Context.followWithAbstracts(Context.typeof(from)) {
		case TAnonymous(_.get() => anon):
			anon.fields.map(f -> f.name);
		case TInst(_.get() => classType, _):
			// filter accessible class variables and dynamic functions
			getAllClassFields(classType)
			.filter(f -> f.isPublic && switch f.kind {
				case FMethod(MethDynamic): true;
				case FVar(AccNormal | AccCall, _): true;
				case FMethod(MethNormal | MethInline | MethMacro): false;
				case FVar(_, _): false;
			})
			.map(f -> f.name);
		default:
			Context.fatalError('Can only copy from structures and classes', Context.currentPos());
	}
	if (options != null) {
		fieldNames = fieldNames.filter(f -> !options.exclude.contains(f));
	}
	var exprs = [
		for (name in fieldNames) {
			macro to.$name = from.$name;
		}
	];
	return macro {
		var from = $from;
		var to = $to;
		$b{exprs};
	}
}

function copyFieldsAny(from: Any, to: Any) {
	var fieldNames = Reflect.fields(from);
	for (name in fieldNames) {
		Reflect.setField(to, name, Reflect.field(from, name));
	}
}

macro function duplicate(structure: Expr) {
	var fieldNames = switch Context.followWithAbstracts(Context.typeof(structure)) {
		case TAnonymous(_.get() => anon): anon.fields.map(f -> f.name);
		default:
			Context.fatalError('Can only duplicate structures', Context.currentPos());
	}
	
	var objExpr = {
		expr: EObjectDecl([
			for (name in fieldNames) {
				field: name,
				expr: macro obj.$name
			}
		]),
		pos: Context.currentPos(),
	};

	return macro {
		var obj = $structure;
		$objExpr;
	}
}

#if macro

/**
	Recursively unwraps Null<T> to T
**/
private function unwrapNull(complexType: ComplexType) {
	return switch complexType {
		case TPath({
			pack: [],
			name: 'StdTypes',
			sub: 'Null',
			params: [TPType(typeParam)],
		}):
			unwrapNull(typeParam);
		default: 
			complexType;
	}
}

/**
 * Concatenates all fields including super types
 * @param classType 
 */
private function getAllClassFields(classType: ClassType) {
	var fields = if (classType.superClass != null) {
		getAllClassFields(classType.superClass.t.get());
	} else [];
	return fields.concat(classType.fields.get());
}

#end