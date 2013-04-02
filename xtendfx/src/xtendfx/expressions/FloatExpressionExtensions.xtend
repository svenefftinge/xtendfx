package xtendfx.expressions

import javafx.beans.binding.FloatBinding
import javafx.beans.binding.FloatExpression
import javafx.beans.value.ObservableNumberValue
import org.eclipse.xtext.xbase.lib.Pure

/** 
 * Extension methods for {@link FloatExpression}s. 
 * Allow to use operators instead of fluent API.
 * 
 * @author koehnlein
 */
class FloatExpressionExtensions {
	
	@Pure
	def static operator_plus(FloatExpression a, ObservableNumberValue b) {
		a.add(b)	
	}

	@Pure
	def static operator_minus(FloatExpression a) {
		a.negate()	
	}
	
	@Pure
	def static operator_minus(FloatExpression a, ObservableNumberValue b) {
		a.subtract(b)	
	}
	
	@Pure
	def static operator_multiply(FloatExpression a, ObservableNumberValue b) {
		a.multiply(b)	
	}
	
	@Pure
	def static operator_divide(FloatExpression a, ObservableNumberValue b) {
		a.divide(b)	
	}

	@Pure
	def static operator_plus(float a, FloatExpression b) {
		new FloatConstant(a).add(b)	
	}
	
	@Pure
	def static operator_minus(float a, FloatExpression b) {
		new FloatConstant(a).subtract(b)	
	}
	
	@Pure
	def static operator_multiply(float a, FloatExpression b) {
		new FloatConstant(a).multiply(b)	
	}
	
	@Pure
	def static operator_divide(float a, FloatExpression b) {
		new FloatConstant(a).divide(b)	
	}
	

	@Pure
	def static operator_plus(FloatExpression a, float b) {
		a.add(b)	
	}

	@Pure
	def static operator_minus(FloatExpression a, float b) {
		a.subtract(b)	
	}
	
	@Pure
	def static operator_multiply(FloatExpression a, float b) {
		a.multiply(b)	
	}
	
	@Pure
	def static operator_divide(FloatExpression a, float b) {
		a.divide(b)	
	}
}

class FloatConstant extends FloatBinding {

	float value 
	
	new(float value) {
		this.value = value
	}

	override protected computeValue() {
		value	
	}
}