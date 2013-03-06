package xtendfx.properties

import java.util.List
import javafx.beans.property.ObjectProperty
import javafx.beans.property.SimpleBooleanProperty
import javafx.beans.property.SimpleDoubleProperty
import javafx.beans.property.SimpleFloatProperty
import javafx.beans.property.SimpleIntegerProperty
import javafx.beans.property.SimpleListProperty
import javafx.beans.property.SimpleLongProperty
import javafx.beans.property.SimpleStringProperty
import org.eclipse.xtend.lib.macro.TransformationContext
import org.eclipse.xtend.lib.macro.TransformationParticipant
import org.eclipse.xtend.lib.macro.declaration.MutableClassDeclaration
import org.eclipse.xtend.lib.macro.declaration.MutableFieldDeclaration
import org.eclipse.xtend.lib.macro.declaration.TypeReference
import org.eclipse.xtend.lib.macro.Active

/**
 * An active annotation which turns simple fields into
 * lazy JavaFX properties as described  
 * <a href="http://blog.netopyr.com/2011/05/19/creating-javafx-properties/">here</a>.
 * 
 * That is it 
 * <ul>
 *  <li> adds a field with the corresponding JavaFX property type,
 *  <li> a getter method
 *  <li> a setter method
 *  <li> and an accessor to the JavaFX property.
 * </ul>
 */
@Active(typeof(FxBeanCompilationParticipant))
annotation FXBean {
}

class FxBeanCompilationParticipant implements TransformationParticipant<MutableClassDeclaration> {
	
	extension TransformationContext ctx
	
	override doTransform(List<? extends MutableClassDeclaration> classes, TransformationContext context) {
		ctx = context
		for (clazz : classes) {
			for (f : clazz.members.filter(typeof(MutableFieldDeclaration))) {
				val fieldName = f.name
				val fieldType = f.type
				val propName = f.name+'Property'
				val propType = f.type.toPropertyType
				
				clazz.addField(propName) [
					type = propType	
				]
				
				clazz.addMethod('get'+fieldName.toFirstUpper) [
					returnType = fieldType
					body = ['''
						return (this.«propName» != null)? this.«propName».get() : this.«fieldName»;
					''']
				]
				
				clazz.addMethod('set'+fieldName.toFirstUpper) [
					addParameter(fieldName, fieldType)
					body = ['''
						if («propName» != null) {
							this.«propName».set(«fieldName»);
						} else {
							this.«fieldName» = «fieldName»;
						}
					''']
				]
				
				clazz.addMethod(fieldName+'Property') [
					returnType = propType
					body = ['''
						if ( this.«propName» == null) { 
							this.«propName» = new «toJavaCode(propType)»(this, "«fieldName»", this.«fieldName»);
						}
						return this.«propName»;
					''']
				]
			}

		}
	}
	
	def TypeReference toPropertyType(TypeReference ref) {
		switch ref.toString {
			case 'boolean' : newTypeReference(typeof(SimpleBooleanProperty).name)
			case 'double' : newTypeReference(typeof(SimpleDoubleProperty).name)
			case 'float' : newTypeReference(typeof(SimpleFloatProperty).name)
			case 'long' : newTypeReference(typeof(SimpleLongProperty).name)
			case 'String' : newTypeReference(typeof(SimpleStringProperty).name)  
			case 'int' : newTypeReference(typeof(SimpleIntegerProperty).name)
			case 'javafx.collections.ObservableList' :  newTypeReference(typeof(SimpleListProperty).name, ref.actualTypeArguments.head)
			default : newTypeReference(typeof(ObjectProperty).name)
		}
	}
	
}