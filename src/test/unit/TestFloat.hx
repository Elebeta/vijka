package test.unit;

class TestFloat extends TestCase {
	public function testPosInf() {
		// In comparison operations, positive infinity is larger than all values except itself and NaN
		// (http://www.gnu.org/software/libc/manual/html_node/Infinity-and-NaN.html)
		// comparissn with zero
		assertTrue( 0. < Math.POSITIVE_INFINITY );
		assertTrue( Math.POSITIVE_INFINITY > 0. );
		// comparissn with itself
		assertFalse( Math.POSITIVE_INFINITY < Math.POSITIVE_INFINITY );
		assertFalse( Math.POSITIVE_INFINITY > Math.POSITIVE_INFINITY );
		// comparison with NaN
		assertFalse( Math.NaN < Math.POSITIVE_INFINITY );
		#if ( !neko || debug ) // testBugHaxeNeko0001
		assertFalse( Math.POSITIVE_INFINITY > Math.NaN );
		#end
		// more complex comparisons with itself
		assertFalse( Math.POSITIVE_INFINITY - 1. < Math.POSITIVE_INFINITY );
		assertFalse( Math.POSITIVE_INFINITY > Math.POSITIVE_INFINITY - 1. );
		assertFalse( Math.POSITIVE_INFINITY/2. < Math.POSITIVE_INFINITY );
		assertFalse( Math.POSITIVE_INFINITY > Math.POSITIVE_INFINITY/2. );
		assertFalse( Math.POSITIVE_INFINITY/2. < Math.POSITIVE_INFINITY );
		assertFalse( Math.POSITIVE_INFINITY > Math.POSITIVE_INFINITY/2. );
	}

	public function testIdeterminateInfTimesZero() {
		// 0 * +-oo = NaN
		// (http://en.wikipedia.org/wiki/Indeterminate_forms)
		assertNaN( 0.*Math.POSITIVE_INFINITY );
		assertNaN( Math.POSITIVE_INFINITY*0. );
	}

	#if neko
	public function testBugHaxeNeko0001() {
		assertFalse( Math.POSITIVE_INFINITY > Math.NaN ); // fails on neko!
	}
	#end
	
}