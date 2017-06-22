package edu.kit.ipd.sdq.xocl.extensions

import java.math.BigDecimal
import java.math.BigInteger

/**
 * A utility class providing OCL-aligned extension methods for Numbers
 * 
 */
class NumberXOCLExtensions {
	/** Utility classes should not have a public or default constructor. */
	private new() {
	}
	
	def static dispatch operator_plus(Number n1, Number n2) {
		throw new UnsupportedOperationException()
	}
	
	def static dispatch operator_plus(BigDecimal n1, BigDecimal n2) {
		return BigDecimalExtensions.operator_plus(n1,n2)
	}
	
	def static dispatch operator_plus(BigInteger n1, BigInteger n2) {
		return BigIntegerExtensions.operator_plus(n1,n2)
	}

	def static dispatch operator_plus(Double n1, Double n2) {
		return DoubleExtensions.operator_plus(n1,n2)
	}
	
	def static dispatch operator_plus(Float n1, Double n2) {
		return DoubleExtensions.operator_plus(n1,n2)
	}
	
	def static dispatch operator_plus(Long n1, Double n2) {
		return DoubleExtensions.operator_plus(n1,n2)
	}
	
	def static dispatch operator_plus(Integer n1, Double n2) {
		return DoubleExtensions.operator_plus(n1,n2)
	}
	
	def static dispatch operator_plus(Short n1, Double n2) {
		return DoubleExtensions.operator_plus(n1,n2)
	}
	
	def static dispatch operator_plus(Byte n1, Double n2) {
		return DoubleExtensions.operator_plus(n1,n2)
	}
	
	def static dispatch operator_plus(Double n1, Float n2) {
		return DoubleExtensions.operator_plus(n1,n2)
	}
	
	def static dispatch operator_plus(Double n1, Long n2) {
		return DoubleExtensions.operator_plus(n1,n2)
	}
	
	def static dispatch operator_plus(Double n1, Integer n2) {
		return DoubleExtensions.operator_plus(n1,n2)
	}
	
	def static dispatch operator_plus(Double n1, Short n2) {
		return DoubleExtensions.operator_plus(n1,n2)
	}
	
	def static dispatch operator_plus(Double n1, Byte n2) {
		return DoubleExtensions.operator_plus(n1,n2)
	}

	def static dispatch operator_plus(Float n1, Float n2) {
		return FloatExtensions.operator_plus(n1,n2)
	}
	
	def static dispatch operator_plus(Long n1, Float n2) {
		return FloatExtensions.operator_plus(n1,n2)
	}
	
	def static dispatch operator_plus(Integer n1, Float n2) {
		return FloatExtensions.operator_plus(n1,n2)
	}
	
	def static dispatch operator_plus(Short n1, Float n2) {
		return FloatExtensions.operator_plus(n1,n2)
	}
	
	def static dispatch operator_plus(Byte n1, Float n2) {
		return FloatExtensions.operator_plus(n1,n2)
	}
	
	def static dispatch operator_plus(Float n1, Long n2) {
		return FloatExtensions.operator_plus(n1,n2)
	}
	
	def static dispatch operator_plus(Float n1, Integer n2) {
		return FloatExtensions.operator_plus(n1,n2)
	}
	
	def static dispatch operator_plus(Float n1, Short n2) {
		return FloatExtensions.operator_plus(n1,n2)
	}
	
	def static dispatch operator_plus(Float n1, Byte n2) {
		return FloatExtensions.operator_plus(n1,n2)
	}
	
	def static dispatch operator_plus(Long n1, Long n2) {
		return LongExtensions.operator_plus(n1,n2)
	}
	
	def static dispatch operator_plus(Integer n1, Long n2) {
		return LongExtensions.operator_plus(n1,n2)
	}
	
	def static dispatch operator_plus(Short n1, Long n2) {
		return LongExtensions.operator_plus(n1,n2)
	}
	
	def static dispatch operator_plus(Byte n1, Long n2) {
		return LongExtensions.operator_plus(n1,n2)
	}
	
	def static dispatch operator_plus(Long n1, Integer n2) {
		return LongExtensions.operator_plus(n1,n2)
	}
	
	def static dispatch operator_plus(Long n1, Short n2) {
		return LongExtensions.operator_plus(n1,n2)
	}
	
	def static dispatch operator_plus(Long n1, Byte n2) {
		return LongExtensions.operator_plus(n1,n2)
	}

	def static dispatch operator_plus(Integer n1, Integer n2) {
		return IntegerExtensions.operator_plus(n1,n2)
	}

	def static dispatch operator_plus(Short n1, Integer n2) {
		return IntegerExtensions.operator_plus(n1,n2)
	}

	def static dispatch operator_plus(Byte n1, Integer n2) {
		return IntegerExtensions.operator_plus(n1,n2)
	}

	def static dispatch operator_plus(Integer n1, Short n2) {
		return IntegerExtensions.operator_plus(n1,n2)
	}

	def static dispatch operator_plus(Integer n1, Byte n2) {
		return IntegerExtensions.operator_plus(n1,n2)
	}

	def static dispatch operator_plus(Short n1, Short n2) {
		return ShortExtensions.operator_plus(n1,n2)
	}

	def static dispatch operator_plus(Byte n1, Short n2) {
		return ShortExtensions.operator_plus(n1,n2)
	}

	def static dispatch operator_plus(Short n1, Byte n2) {
		return ShortExtensions.operator_plus(n1,n2)
	}
	
	def static dispatch operator_plus(Byte n1, Byte n2) {
		return ByteExtensions.operator_plus(n1,n2)
	}
}