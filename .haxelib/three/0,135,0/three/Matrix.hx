package three;

/**
	( interface Matrix<T> )
**/
typedef Matrix = {
	/**
		Array with matrix values.
	**/
	var elements : Array<Float>;
	/**
		identity():T;
	**/
	function identity():Matrix;
	/**
		copy(m:T):T;
	**/
	function copy(m:Matrix):Matrix;
	/**
		multiplyScalar(s:number):T;
	**/
	function multiplyScalar(s:Float):Matrix;
	function determinant():Float;
	/**
		transpose():T;
	**/
	function transpose():Matrix;
	/**
		invert():T;
	**/
	function invert():Matrix;
	/**
		clone():T;
	**/
	function clone():Matrix;
};