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
import javafx.beans.property.ReadOnlyBooleanProperty
import javafx.beans.property.ReadOnlyDoubleProperty
import javafx.beans.property.ReadOnlyFloatProperty
import javafx.beans.property.ReadOnlyLongProperty
import javafx.beans.property.ReadOnlyStringProperty
import javafx.beans.property.ReadOnlyIntegerProperty
import javafx.beans.property.ReadOnlyBooleanWrapper
import javafx.beans.property.ReadOnlyListProperty
import javafx.beans.property.ReadOnlyObjectProperty
import javafx.beans.property.ReadOnlyDoubleWrapper
import javafx.beans.property.ReadOnlyFloatWrapper
import javafx.beans.property.ReadOnlyLongWrapper
import javafx.beans.property.ReadOnlyStringWrapper
import javafx.beans.property.ReadOnlyIntegerWrapper
import javafx.beans.property.ReadOnlyListWrapper
import javafx.beans.property.ReadOnlyObjectWrapper
import org.eclipse.xtend.lib.macro.declaration.Visibility
import org.eclipse.xtend.lib.macro.declaration.Type
import org.eclipse.xtend.lib.macro.declaration.TypeDeclaration

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
		val fxImmutableAnnotation = typeof(Immutable).findTypeGlobally
		val dataAnnotation = typeof(Data).findTypeGlobally
		val fxReadonlyAnnotation = typeof(Readonly).findTypeGlobally
		val fxNoneLazyAnnotation = typeof(NoneLazy).findTypeGlobally
		
		for (clazz : classes) {
			for (f : clazz.declaredFields) {
				val readonly = f.readonly(fxReadonlyAnnotation)
				val lazy = f.lazy(fxNoneLazyAnnotation)
				val immutableType = f.immutableType(fxImmutableAnnotation, dataAnnotation)
				
				val fieldName = f.simpleName
				val fieldType = f.type
				val propName = f.simpleName+'Property'
				val propType = f.type.toPropertyType(readonly,context)
				val propTypeAPI = f.type.toPropertyType_API(readonly, context)
				
				if( lazy ) {
					createLazyField(immutableType, f, clazz, propName, propType, fieldName, fieldType, readonly, propTypeAPI)	
				} else {
					createNoneLazyField(immutableType, f, clazz, propName, propType, fieldName, fieldType, readonly, propTypeAPI)
				}
			}
		}
	}
	
	def createNoneLazyField(boolean immutableType, MutableFieldDeclaration f, MutableClassDeclaration clazz, String propName, TypeReference propType, String fieldName, TypeReference fieldType, boolean readonly, TypeReference propTypeAPI) {
		if( f.initializer == null ) {
			clazz.addField(propName) [
				type = propType	
				initializer = ['''new «toJavaCode(propType)»(this, "«fieldName»")''']
			]	
		} else {
			clazz.addField(propName) [
				type = propType	
				initializer = ['''new «toJavaCode(propType)»(this, "«fieldName»",_init«fieldName.toFirstUpper»())''']
			]
			
			clazz.addMethod("_init"+fieldName.toFirstUpper) [
				returnType = fieldType
				visibility = Visibility::PRIVATE
				static = true
				final = true
				body = f.initializer
			]
		}
		
		
		clazz.addMethod('get'+fieldName.toFirstUpper) [
			returnType = fieldType
			body = ['''
				return this.«propName».get();
			''']
		]
		
		if( ! readonly ) {
			clazz.addMethod('set'+fieldName.toFirstUpper) [
				addParameter(fieldName, fieldType)
				body = ['''
					this.«propName».set(«fieldName»);
				''']
			]	
		}
		
		clazz.addMethod(fieldName+'Property') [
			returnType = propTypeAPI
			body = ['''
				return «IF readonly»this.«propName».getReadOnlyProperty()«ELSE»this.«propName»«ENDIF»;
			''']
		]
		
		f.remove
	}

	def createLazyField(boolean immutableType, MutableFieldDeclaration f, MutableClassDeclaration clazz, String propName, TypeReference propType, String fieldName, TypeReference fieldType, boolean readonly, TypeReference propTypeAPI) {
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
				return «IF readonly»this.«propName».getReadOnlyProperty()«ELSE»this.«propName»«ENDIF»;
			''']
		]
		
		// remove the property if it is immutable
		if( immutableType ) {
			f.remove
		}
	}
	
	def boolean readonly(MutableFieldDeclaration field, Type readonlyAnnotation) {
		return field.findAnnotation(readonlyAnnotation) != null
	}
	
	def boolean lazy(MutableFieldDeclaration field, Type noneLazyAnnotation) {
		return field.findAnnotation(noneLazyAnnotation) == null;
	}
	
	def boolean immutableType (MutableFieldDeclaration field, Type fxImmutableAnnotation, Type dataAnnotation) {
		/*
		 * we could be more clever here e.g. java.lang.Integer is also immutable 
		 * and maybe support custom types who are annotated with @Immutable
		 */
		switch field.type.toString {
			case 'boolean' : true
			case 'double' : true
			case 'float' : true
			case 'long' : true
			case 'String' : true  
			case 'int' : true
			case 'javafx.collections.ObservableList' :  false
			default : 
				if( field.findAnnotation(fxImmutableAnnotation) != null ) {
					return true;
				} else if( field.type.type instanceof TypeDeclaration ) {
					val t = field.type.type as TypeDeclaration
					val rv = t.findAnnotation(fxImmutableAnnotation) != null || t.findAnnotation(dataAnnotation) != null;
					return rv;
				} else {
					return false;
				}
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
	
	def TypeReference toPropertyType_API(TypeReference ref, boolean readonly, extension TransformationContext context) {
		if( readonly ) {
			switch ref.toString {
				case 'boolean' : typeof(ReadOnlyBooleanProperty).newTypeReference
				case 'double' : typeof(ReadOnlyDoubleProperty).newTypeReference
				case 'float' : typeof(ReadOnlyFloatProperty).newTypeReference
				case 'long' : typeof(ReadOnlyLongProperty).newTypeReference
				case 'String' : typeof(ReadOnlyStringProperty).newTypeReference  
				case 'int' : typeof(ReadOnlyIntegerProperty).newTypeReference
				case 'javafx.collections.ObservableList' :  typeof(ReadOnlyListProperty).newTypeReference(ref.actualTypeArguments.head)
				default : typeof(ReadOnlyObjectProperty).newTypeReference(ref)
			}
		} else {
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
	}
	
	def TypeReference toPropertyType(TypeReference ref, boolean readonly, extension TransformationContext context) {
		if( readonly ) {
			switch ref.toString {
				case 'boolean' : typeof(ReadOnlyBooleanWrapper).newTypeReference
				case 'double' : typeof(ReadOnlyDoubleWrapper).newTypeReference
				case 'float' : typeof(ReadOnlyFloatWrapper).newTypeReference
				case 'long' : typeof(ReadOnlyLongWrapper).newTypeReference
				case 'String' : typeof(ReadOnlyStringWrapper).newTypeReference  
				case 'int' : typeof(ReadOnlyIntegerWrapper).newTypeReference
				case 'javafx.collections.ObservableList' :  typeof(ReadOnlyListWrapper).newTypeReference(ref.actualTypeArguments.head)
				default : typeof(ReadOnlyObjectWrapper).newTypeReference(ref)
			}
		} else {
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
	
}