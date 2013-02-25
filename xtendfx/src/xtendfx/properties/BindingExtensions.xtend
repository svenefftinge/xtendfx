package xtendfx.properties

import javafx.beans.binding.Bindings
import javafx.beans.binding.BooleanBinding
import javafx.beans.binding.ObjectExpression
import javafx.beans.binding.StringExpression
import javafx.beans.property.Property
import javafx.beans.property.SimpleStringProperty
import javafx.beans.property.StringProperty
import javafx.beans.value.ObservableObjectValue
import javafx.beans.value.ObservableValue

class BindingExtensions {
	
	def static <T> void operator_mappedTo(Property<T> left, ObservableValue<? extends T> right) {
		left.bind(right)
	}
	
	def static <T> void operator_diamond(Property<T> left, Property<T> right) {
		left.bindBidirectional(right)
	}
	
	def static BooleanBinding operator_equals(ObjectExpression<?> left, Object right) {
		left.isEqualTo(right)
	}
	
	def static BooleanBinding operator_equals(ObjectExpression<?> left, ObservableObjectValue<?> right) {
		left.isEqualTo(right)
	}
	
	def static BooleanBinding operator_notEquals(ObjectExpression<?> left, Object right) {
		left.isNotEqualTo(right)
	}
	
	def static BooleanBinding operator_notEquals(ObjectExpression<?> left, ObservableObjectValue<?> right) {
		left.isNotEqualTo(right)
	}
	
	def static StringProperty asProperty(String someString) {
		new SimpleStringProperty(someString)
	}
	
	def static StringExpression operator_plus(StringExpression left, Object right) {
		return Bindings::concat(left, right)
	}
}