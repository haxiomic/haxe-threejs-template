import haxe.macro.Context;
import haxe.macro.Expr;
import haxe.macro.TypeTools;

#if !macro
@:genericBuild(PartialMacro.build())
#end
class Partial<T> {}

class PartialMacro {
	#if macro
	@:access(haxe.macro.TypeTools)
	static function build()
	{
		switch Context.getLocalType()
		{
			// Match when class's type parameter leads to an anonymous type (we convert to a complex type in the process to make it easier to work with)
			case TInst(_, [Context.followWithAbstracts(_) => TypeTools.toComplexType(_) => TAnonymous(fields)]):
				// Add @:optional meta to all fields
				var newFields = fields.map(addMeta);
				return TAnonymous(newFields);
			
			// Match when type parameter leads to a class instance
			case TInst(_, [Context.followWithAbstracts(_) => TInst(_.get() => _.fields.get() => classFields, params)]):
				// Convert all fields to anon fields and then add @:optional to each
				var anonFields: Array<Field> = classFields.map(TypeTools.toField);
				var newFields = anonFields.map(addMeta);
				return TAnonymous(newFields);

			default:
				Context.fatalError('Type parameter should be an anonymous structure', Context.currentPos());
		}

		return null;
	}

	static function addMeta(field: Field): Field
	{
		// Handle Null<T> and optional fields already parsed by the compiler
		var kind = switch (field.kind) {
			case FVar(TPath({
					name: 'StdTypes',
					sub: 'Null',
					params: [TPType(TPath(tpath))]
				}), write):
				FVar(TPath(tpath), write);

			default:
				field.kind;
		}

		return {
			name: field.name,
			kind: kind,
			access: field.access,
			meta: field.meta.concat([{
				name: ':optional',
				params: [],
				pos: Context.currentPos()
			}]),
			pos: field.pos
		};
	}
	#end
}