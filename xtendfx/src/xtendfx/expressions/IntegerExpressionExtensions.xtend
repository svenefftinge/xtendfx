package xtendfx.expressions

import javafx.beans.binding.IntegerBinding
import javafx.beans.binding.IntegerExpression
import javafx.beans.value.ObservableNumberValue
import org.eclipse.xtext.xbase.lib.Pure

/** 
 * Extension methods for {@link IntegerExpression}s. 
 * Allow to use operators instead of fluent API.
 * 
 * @author koehnlein
 */
class IntegerExpressionExtensions {
	
	@Pure
	def static operator_plus(IntegerExpression a, ObservableNumberValue b) {
		a.add(b)	
	}

	@Pure
	def static operator_minus(IntegerExpression a) {
		a.negate()	
	}
	
	@Pure
	def static operator_minus(IntegerExpression a, ObservableNumberValue b) {
		a.subtract(b)	
	}
	
	@Pure
	def static operator_multiply(IntegerExpression a, ObservableNumberValue b) {
		a.multiply(b)	
	}
	
	@Pure
	def static operator_divide(IntegerExpression a, ObservableNumberValue b) {
		a.divide(b)	
	}

	@Pure
	def static operator_plus(int a, IntegerExpression b) {
		new IntegerConstant(a).add(b)	
	}
	
	@Pure
	def static operator_minus(int a, IntegerExpression b) {
		new IntegerConstant(a).subtract(b)	
	}
	
	@Pure
	def static operator_multiply(int a, IntegerExpression b) {
		new IntegerConstant(a).multiply(b)	
	}
	
	@Pure
	def static operator_divide(int a, IntegerExpression b) {
		new IntegerConstant(a).divide(b)	
	}
	

	@Pure
	def static operator_plus(IntegerExpression a, int b) {
		a.add(b)	
	}

	@Pure
	def static operator_minus(IntegerExpression a, int b) {
		a.subtract(b)	
	}
	
	@Pure
	def static operator_multiply(IntegerExpression a, int b) {
		a.multiply(b)	
	}
	
	@Pure
	def static operator_divide(IntegerExpression a, int b) {
		a.divide(b)	
	}
}

class IntegerConstant extends IntegerBinding {

	int value 
	
	new(int value) {
		this.value = value
	}

	override protected computeValue() {
		value	
	}
}