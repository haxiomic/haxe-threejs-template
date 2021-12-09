package math;

/**
	Quaternion implementation extending VectorMath Vec4
**/
@:forward
abstract Quat(Vec4) to Vec4 from Vec4 {

	public inline function new(x: Float, y: Float, z: Float, w: Float){
		this = new Vec4(x, y, z, w);
	}

	public inline function inverse():Quat{
		return new Quat(-this.x, -this.y, -this.z, this.w);
	}
	
	/**
		Efficiently rotate a vector by this quaternion
	**/
	public inline function transform(v: Vec3): Vec3 {
		// https://gamedev.stackexchange.com/a/50545
		var u = this.xyz;
		var s = this.w;
		return
			2 * u.dot(v) * u
			+ (s*s - u.dot(u)) * v
			+ 2 * s * u.cross(v);
	}

	@:op(a * b)
	static inline function mul(lhs: Quat, rhs: Quat): Quat {
		return new Quat(
			 lhs.x * rhs.w + lhs.y * rhs.z - lhs.z * rhs.y + lhs.w * rhs.x,
			-lhs.x * rhs.z + lhs.y * rhs.w + lhs.z * rhs.x + lhs.w * rhs.y,
			 lhs.x * rhs.y - lhs.y * rhs.x + lhs.z * rhs.w + lhs.w * rhs.z,
			-lhs.x * rhs.x - lhs.y * rhs.y - lhs.z * rhs.z + lhs.w * rhs.w
		);
	}

	static public inline function fromAxisAngle(axis:Vec3, angle:Float) {
		var sa = Math.sin(angle * 0.5);
		return new Quat(
			axis.x * sa,
			axis.y * sa,
			axis.z * sa,
			Math.cos(angle * 0.5)
		);
	}

}