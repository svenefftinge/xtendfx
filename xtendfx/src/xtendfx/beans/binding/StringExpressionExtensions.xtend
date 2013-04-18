package xtendfx.beans.binding

import javafx.beans.binding.Bindings
import javafx.beans.binding.StringExpression
import javafx.beans.property.SimpleStringProperty
import javafx.beans.property.StringProperty

class StringExpressionExtensions {
	
	def static StringProperty asProperty(String someString) {
		new SimpleStringProperty(someString)
	}
	
	def static StringExpression operator_plus(StringExpression left, Object right) {
		return Bindings::concat(left, right)
	}
}