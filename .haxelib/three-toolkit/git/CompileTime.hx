#if macro
import haxe.crypto.Base64;
import haxe.io.Path;
import haxe.macro.Context;
import haxe.macro.Expr;
import haxe.macro.ExprTools;
import haxe.macro.MacroStringTools;
import sys.FileSystem;
import sys.io.File;
#end

class CompileTime {

	static public macro function embedString(path: String) {
		var resolvedPath = resolvePath(path);
		Context.registerModuleDependency(Context.getLocalModule(), resolvedPath);
		return macro $v{File.getContent(resolvedPath)};
	}

	static public macro function embedShader(path: String) {
		var resolvedPath = resolvePath(path);
		Context.registerModuleDependency(Context.getLocalModule(), resolvedPath);
		var content = File.getContent(resolvedPath);
		return macro ${MacroStringTools.formatString(content, Context.currentPos())};
	}

	static public macro function embedBase64(path: String) {
		var resolvedPath =  resolvePath(path);
		Context.registerModuleDependency(Context.getLocalModule(), resolvedPath);
		return macro $v{Base64.encode(File.getBytes(resolvedPath))};
	}

	static public macro function embedImageDataUri(path: String, ?mimeType: String) {
		var resolvedPath =  resolvePath(path);
		Context.registerModuleDependency(Context.getLocalModule(), resolvedPath);
		if (mimeType == null) {
			mimeType = switch Path.extension(path).toLowerCase() {
				case 'bmp': 'image/bmp';
				case 'gif': 'image/gif';
				case 'ico': 'image/vnd.microsoft.icon';
				case 'png': 'image/png';
				case 'svg': 'image/svg+xml';
				case 'webp': 'image/webp';
				case 'jpeg', 'jpg': 'image/jpeg';
				case 'tif', 'tiff': 'image/tiff';
				default: 'image/xyz'; // let the browser figure it out
			}
		}
		return macro 'data:image/' + $v{mimeType} + ';base64,' + $v{Base64.encode(File.getBytes(resolvedPath))};
	}

	static public macro function embed3dModelDataUri(path: String, ?mimeType: String) {
		var resolvedPath =  resolvePath(path);
		Context.registerModuleDependency(Context.getLocalModule(), resolvedPath);
		if (mimeType == null) {
			mimeType = switch Path.extension(path).toLowerCase() {
				case 'glb': 'model/gltf-binary';
				case 'gltf': 'model/gltf+json';
				case 'stl': 'model/stl';
				case 'obj': 'model/obj';
				case 'mtl': 'model/mtl';
				case 'wrl' | 'wrz': 'model/vrml';
				default: 'application/octet-stream';
			}
		}
		return macro 'data:image/' + $v{mimeType} + ';base64,' + $v{Base64.encode(File.getBytes(resolvedPath))};
	}

	static public macro function embedJson(path:String) {
		var resolvedPath =  resolvePath(path);
		return try {
			var json = haxe.Json.parse(sys.io.File.getContent(resolvedPath));
			macro $v{json};
		} catch (e) {
			haxe.macro.Context.error('Failed to load json: $e', haxe.macro.Context.currentPos());
		}
	}

	static public macro function getPathsInDirectory(directoryPath: String, ?matching: ExprOf<EReg>) {
		var resolvedPath =  resolvePath(directoryPath);
		var filenames = sys.FileSystem.readDirectory(resolvedPath);
		var paths = filenames.map(filename -> Path.join([directoryPath, filename]));
		
		switch matching.expr {
			case EConst(CIdent("null")): // no filtering
			case EConst(CRegexp(reg, opt)):
				var pattern = new EReg(reg, opt);
				paths = paths.filter(path -> pattern.match(path));
			default:
				Context.error("\"matching\" must be a regex expression or null", matching.pos);
		}
		return macro $v{paths};
	}

	static public macro function haxeVersion() {
		return macro $v{Context.definedValue('haxe')};
	}

	#if macro
	static function resolvePath(path: String) {
		if (!Path.isAbsolute(path)) {
			var pos = haxe.macro.PositionTools.toLocation(Context.currentPos());
			var directory = Path.directory(pos.file.toString());
			var localPath = Path.join([directory, path]);

			if (FileSystem.exists(localPath)) {
				return localPath;
			}
		}
		return Context.resolvePath(path);
	}
	#end

}