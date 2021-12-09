package tool;

#if macro
import haxe.io.Path;
import sys.io.File;
import haxe.macro.Context;
import haxe.crypto.Base64;
import haxe.macro.MacroStringTools;
import sys.FileSystem;
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