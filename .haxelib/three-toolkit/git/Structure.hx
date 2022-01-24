#if macro
import haxe.macro.Type.ClassType;
import haxe.macro.Type.ClassField;
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
	var fieldNames =
		getPublicReadableFields(Context.typeof(from), from.pos)
		.map(f -> f.name);
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

/**
 * Copies fields from a structure to a target, for example
 * ```haxe
 * apply(canvas.style, {
 * 	position: 'absolute',
 * 	zIndex: '0',
 * 	top: '0',
 * 	left: '0',
 * 	width: '100%',
 * 	height: '100%',
 * });
 * ```
 */
macro function apply(target, objectDeclaration) {
	var targetFields = getFields(Context.typeof(target), target.pos);

	targetFields = targetFields.filter(f -> f.isPublic && switch f.kind {
		case FVar(_, _) | FMethod(MethDynamic): true;
		case FMethod(_): false;
	});

	var expectedStructure: ComplexType = TAnonymous(targetFields.map(f -> ({
		name: f.name,
		meta: [{name: ':optional', pos: f.pos}],
		doc: f.doc,
		pos: f.pos,
		kind: FVar(Context.toComplexType(f.type)),
	}: Field)));

	// make the compiler type objectDeclaration as expected structure so we get completion
	getPublicReadableFields(Context.typeof(macro ($objectDeclaration: $expectedStructure)), objectDeclaration.pos);

	var assignmentExprs: Array<Expr> =
		(switch objectDeclaration.expr {
			case EObjectDecl(fields): fields;
			default: Context.error('Expected object declaration', objectDeclaration.pos);
		})
		.map(f -> {
			var name = f.field;
			var requiresReflection = switch f.quotes {
				case Unquoted: false;
				case Quoted: !~/^[a-z]\w*$/i.match(f.field);
			}
			if (requiresReflection) {
				macro Reflect.setField(target, $v{name}, Reflect.getField(objectDeclaration, $v{name}));
			} else {
				macro target.$name = objectDeclaration.$name;
			}
		}
	);

	return macro {
		var objectDeclaration: $expectedStructure = $objectDeclaration;
		var target = $target;
		$b{assignmentExprs};
		target;
	};
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
function unwrapNull(complexType: ComplexType) {
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

function getFields(type: haxe.macro.Type, pos: Position) {
	return switch Context.follow(type, false) {
		case TAnonymous(_.get() => anon):
			anon.fields;
		case TInst(_.get() => classType, _):
			getAllClassFields(classType);
		case TAbstract(_.get() => abst, _):
			abst.impl.get().fields.get();
		case TMono(_) | TDynamic(_):
			[];
		case TLazy(f): getFields(f(), pos);
		case TEnum(_, _) | TFun(_, _) | TType(_, _):
			Context.error('Type must be a structure, class or abstract', pos);
	}
}

function getPublicWritableFields(type: haxe.macro.Type, pos: Position) {
	return getFields(type, pos)
		.filter(f -> f.isPublic && isWritableField(f));
}

function getPublicReadableFields(type: haxe.macro.Type, pos: Position) {
	return getFields(type, pos)
		.filter(f -> f.isPublic && isReadableField(f));
}

/**
 * Concatenates all fields including super types
 * @param classType 
 */
function getAllClassFields(classType: ClassType) {
	var fields = if (classType.superClass != null) {
		getAllClassFields(classType.superClass.t.get());
	} else [];
	return fields.concat(classType.fields.get());
}

function isWritableField(field: ClassField) {
	return switch field.kind {
		case 
			FVar(_, AccNormal | AccCall ) |
			FMethod(MethDynamic):
			true;
		default:
			false;
	}
}

function isReadableField(field: ClassField) {
	return switch field.kind {
		case
			FVar(AccNormal | AccCall | AccInline, _) |
			FMethod(MethNormal | MethInline | MethDynamic):
			true;
		default:
			false;
	}
}

#end