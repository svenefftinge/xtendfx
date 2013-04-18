package xtendfx.beans.binding

import javafx.beans.binding.LongBinding
import javafx.beans.binding.LongExpression
import javafx.beans.value.ObservableNumberValue
import org.eclipse.xtext.xbase.lib.Pure

/** 
 * Extension methods for {@link LongExpression}s. 
 * Allow to use operators instead of fluent API.
 * 
 * @author koehnlein
 */
class LongExpressionExtensions {
	
	@Pure
	def static operator_plus(LongExpression a, ObservableNumberValue b) {
		a.add(b)	
	}

	@Pure
	def static operator_minus(LongExpression a) {
		a.negate()	
	}
	
	@Pure
	def static operator_minus(LongExpression a, ObservableNumberValue b) {
		a.subtract(b)	
	}
	
	@Pure
	def static operator_multiply(LongExpression a, ObservableNumberValue b) {
		a.multiply(b)	
	}
	
	@Pure
	def static operator_divide(LongExpression a, ObservableNumberValue b) {
		a.divide(b)	
	}

	@Pure
	def static operator_plus(long a, LongExpression b) {
		new LongConstant(a).add(b)	
	}
	
	@Pure
	def static operator_minus(long a, LongExpression b) {
		new LongConstant(a).subtract(b)	
	}
	
	@Pure
	def static operator_multiply(long a, LongExpression b) {
		new LongConstant(a).multiply(b)	
	}
	
	@Pure
	def static operator_divide(long a, LongExpression b) {
		new LongConstant(a).divide(b)	
	}
	

	@Pure
	def static operator_plus(LongExpression a, long b) {
		a.add(b)	
	}

	@Pure
	def static operator_minus(LongExpression a, long b) {
		a.subtract(b)	
	}
	
	@Pure
	def static operator_multiply(LongExpression a, long b) {
		a.multiply(b)	
	}
	
	@Pure
	def static operator_divide(LongExpression a, long b) {
		a.divide(b)	
	}
}

class LongConstant extends LongBinding {

	long value 
	
	new(long value) {
		this.value = value
	}

	override protected computeValue() {
		value	
	}
}