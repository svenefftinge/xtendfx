package xtendfx.properties

import java.util.List
import javafx.beans.property.SimpleObjectProperty
import javafx.beans.property.SimpleBooleanProperty
import javafx.beans.property.SimpleDoubleProperty
import javafx.beans.property.SimpleFloatProperty
import javafx.beans.property.SimpleIntegerProperty
import javafx.beans.property.SimpleListProperty
import javafx.beans.property.SimpleLongProperty
import javafx.beans.property.SimpleStringProperty
import org.eclipse.xtend.lib.macro.Active
import org.eclipse.xtend.lib.macro.TransformationContext
import org.eclipse.xtend.lib.macro.TransformationParticipant
import org.eclipse.xtend.lib.macro.declaration.MutableClassDeclaration
import org.eclipse.xtend.lib.macro.declaration.TypeReference
import org.eclipse.xtend.lib.macro.declaration.MutableFieldDeclaration
import javafx.beans.property.BooleanProperty
import javafx.beans.property.DoubleProperty
import javafx.beans.property.FloatProperty
import javafx.beans.property.LongProperty
import javafx.beans.property.StringProperty
import javafx.beans.property.IntegerProperty
import javafx.beans.property.ListProperty
import javafx.beans.property.ObjectProperty

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
	
	override doTransform(List<? extends MutableClassDeclaration> classes, extension TransformationContext context) {
		for (clazz : classes) {
			for (f : clazz.declaredFields) {
				val fieldName = f.simpleName
				val fieldType = f.type
				val propName = f.simpleName+'Property'
				val propType = f.type.toPropertyType(context)
				val propTypeAPI = f.type.toPropertyType_API(context)
				val immutableType = f.type.immutableType
				val readonly = f.readonly(context)
				
				if( immutableType ) {
					if( f.initializer == null ) {
						clazz.addField("DEFAULT_" + f.simpleName.toUpperCase) [
							type = f.type 
							initializer = [f.type.defaultValue]
							final = true
							static = true
						]
					} else {
						clazz.addField("DEFAULT_" + f.simpleName.toUpperCase) [
							type = f.type 
							initializer = f.initializer
							final = true
							static = true
						]
					}
				}
				
				// add the property field
				clazz.addField(propName) [
					type = propType	
				]
				
				// add the getter
				clazz.addMethod('get'+fieldName.toFirstUpper) [
					returnType = fieldType
					body = ['''
						return (this.«propName» != null)? this.«propName».get() : «IF immutableType»DEFAULT_«fieldName.toUpperCase»«ELSE»this.«fieldName»«ENDIF»;
					''']
				]
				
				if( ! readonly ) {
					// add the setter
					clazz.addMethod('set'+fieldName.toFirstUpper) [
						addParameter(fieldName, fieldType)
						body = ['''
							«IF immutableType»
								this.«propName»().set(«fieldName»);
							«ELSE»
							if («propName» != null) {
								this.«propName».set(«fieldName»);
							} else {
								this.«fieldName» = «fieldName»;
							}
							«ENDIF»
						''']
					]					
				}
				
				// add the property accessor
				clazz.addMethod(fieldName+'Property') [
					returnType = propTypeAPI
					body = ['''
						if (this.«propName» == null) { 
							this.«propName» = new «toJavaCode(propType)»(this, "«fieldName»", «IF immutableType»DEFAULT_«fieldName.toUpperCase»«ELSE»this.«fieldName»«ENDIF»);
						}
						return this.«propName»;
					''']
				]
				
				// remove the property if it is immutable
				if( immutableType ) {
					f.remove
				}
			}
		}
	}
	
	def boolean readonly(MutableFieldDeclaration field, extension TransformationContext context) {
		val a = field.findAnnotation(typeof(FXProperty).findTypeGlobally);
		
		if( a != null ) {
			return a.getValue("readonly") as Boolean;	
		}
		
		return false;
	}
	
	def boolean immutableType (TypeReference ref) {
		/*
		 * we could be more clever here e.g. java.lang.Integer is also immutable 
		 * and maybe support custom types who are annotated with @Immutable
		 */
		switch ref.toString {
			case 'boolean' : true
			case 'double' : true
			case 'float' : true
			case 'long' : true
			case 'String' : true  
			case 'int' : true
			case 'javafx.collections.ObservableList' :  false
			default : false
		}
	}
	
	def String defaultValue(TypeReference ref) {
		switch ref.toString {
			case 'boolean' : "false"
			case 'double' : "0d"
			case 'float' : "0f"
			case 'long' : "0"
			case 'int' : "0"
			default : "null"
		}
	}
	
	def TypeReference toPropertyType_API(TypeReference ref, extension TransformationContext context) {
		switch ref.toString {
			case 'boolean' : typeof(BooleanProperty).newTypeReference
			case 'double' : typeof(DoubleProperty).newTypeReference
			case 'float' : typeof(FloatProperty).newTypeReference
			case 'long' : typeof(LongProperty).newTypeReference
			case 'String' : typeof(StringProperty).newTypeReference  
			case 'int' : typeof(IntegerProperty).newTypeReference
			case 'javafx.collections.ObservableList' :  typeof(ListProperty).newTypeReference(ref.actualTypeArguments.head)
			default : typeof(ObjectProperty).newTypeReference(ref)
		}
	}
	
	def TypeReference toPropertyType(TypeReference ref, extension TransformationContext context) {
		switch ref.toString {
			case 'boolean' : typeof(SimpleBooleanProperty).newTypeReference
			case 'double' : typeof(SimpleDoubleProperty).newTypeReference
			case 'float' : typeof(SimpleFloatProperty).newTypeReference
			case 'long' : typeof(SimpleLongProperty).newTypeReference
			case 'String' : typeof(SimpleStringProperty).newTypeReference  
			case 'int' : typeof(SimpleIntegerProperty).newTypeReference
			case 'javafx.collections.ObservableList' :  typeof(SimpleListProperty).newTypeReference(ref.actualTypeArguments.head)
			default : typeof(SimpleObjectProperty).newTypeReference(ref)
		}
	}
	
}