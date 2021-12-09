package tool;

private typedef Listener<T> = {
	var callback: T -> Void;
	var once: Bool;
}

class EventEmitter {

	final listeners = new Map<String, Array<Listener<Any>>>();

	public function dispatchEvent(name: String, data: Dynamic = null) {
		var array = listeners.get(name);
		if (array != null) {
			var i = array.length - 1;
			while (i >= 0) {
				var listener = array[i];
				var callback = listener.callback;
				callback(data);
				if (listener.once) {
					array.splice(i, 1);
				}
				i--;
			}
		}
	}

	public function addEventListener(name: String, callback: (data: Null<Dynamic>) -> Void, once: Bool = false) {
		var array = listeners.get(name);
		if (array == null) {
			array = [];
			listeners.set(name, array);
		}
		array.push({
			callback: callback,
			once: once,
		});
	}

	public function removeEventListener(name: String, callback: (data: Null<Dynamic>) -> Void) {
		var array = listeners.get(name);
		if (array != null) {
			var i = array.length - 1;
			while (i >= 0) {
				if (array[i].callback == callback) {
					array.splice(i, 1);
				}
				i--;
			}
		}
		if (array.length == 0) {
			listeners.remove(name);
		}
	}

}