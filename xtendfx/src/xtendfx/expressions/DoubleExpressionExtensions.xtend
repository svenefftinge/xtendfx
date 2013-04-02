package xtendfx.expressions

import javafx.beans.binding.DoubleExpression
import org.eclipse.xtext.xbase.lib.Pure
import javafx.beans.value.ObservableNumberValue
import javafx.beans.binding.DoubleBinding

/** 
 * Extension methods for {@link DoubleExpression}s. 
 * Allow to use operators instead of fluent API.
 * 
 * @author koehnlein
 */
class DoubleExpressionExtensions {
	
	@Pure
	def static operator_plus(DoubleExpression a, ObservableNumberValue b) {
		a.add(b)	
	}

	@Pure
	def static operator_minus(DoubleExpression a) {
		a.negate()	
	}
	
	@Pure
	def static operator_minus(DoubleExpression a, ObservableNumberValue b) {
		a.subtract(b)	
	}
	
	@Pure
	def static operator_multiply(DoubleExpression a, ObservableNumberValue b) {
		a.multiply(b)	
	}
	
	@Pure
	def static operator_divide(DoubleExpression a, ObservableNumberValue b) {
		a.divide(b)	
	}


	@Pure
	def static operator_plus(double a, DoubleExpression b) {
		new DoubleConstant(a).add(b)	
	}
	
	@Pure
	def static operator_minus(double a, DoubleExpression b) {
		new DoubleConstant(a).subtract(b)	
	}
	
	@Pure
	def static operator_multiply(double a, DoubleExpression b) {
		new DoubleConstant(a).multiply(b)	
	}
	
	@Pure
	def static operator_divide(double a, DoubleExpression b) {
		new DoubleConstant(a).divide(b)	
	}
	

	@Pure
	def static operator_plus(DoubleExpression a, double b) {
		a.add(b)	
	}

	@Pure
	def static operator_minus(DoubleExpression a, double b) {
		a.subtract(b)	
	}
	
	@Pure
	def static operator_multiply(DoubleExpression a, double b) {
		a.multiply(b)	
	}
	
	@Pure
	def static operator_divide(DoubleExpression a, double b) {
		a.divide(b)	
	}
}

class DoubleConstant extends DoubleBinding {

	double value 
	
	new(double value) {
		this.value = value
	}

	override protected computeValue() {
		value	
	}
}