package ds;

class Watchable<T> {

	@:isVar public var value(get, set): T;
	final callbacks = new Array<(v:T) -> Void>();

	public inline function new(v: T) {
		this.value = v;
	}

	public inline function watch(cb: (v: T) -> Void) {
		callbacks.push(cb);
		cb(value);
		return { unwatch: () -> unwatch(cb) };
	}

	public inline function unwatch(cb: (v: T) -> Void) {
		return callbacks.remove(cb);
	}

	inline function set_value(v: T) {
		this.value = v;
		for (cb in callbacks) cb(v);
		return v;
	}

	inline function get_value() {
		return this.value;
	}

}