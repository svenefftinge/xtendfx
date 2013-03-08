package xtendfx

import java.util.List
import javafx.application.Application
import org.eclipse.xtend.lib.macro.Active
import org.eclipse.xtend.lib.macro.TransformationContext
import org.eclipse.xtend.lib.macro.TransformationParticipant
import org.eclipse.xtend.lib.macro.declaration.MutableClassDeclaration

/**
 * Lets a class extend {@link javafx.application.Application} and
 * adds a main method calling Application#launch
 */
@Active(typeof(FXAppCompilationParticipant))
annotation FXApp {
}

class FXAppCompilationParticipant implements TransformationParticipant<MutableClassDeclaration> {
	
	override doTransform(List<? extends MutableClassDeclaration> annotatedTargetElements, extension TransformationContext ctx) {
		for (clazz : annotatedTargetElements) {
			
			val applicationType = typeof(Application).newTypeReference
			
			// extends Application
			clazz.superclass = applicationType
			
			// add main
			clazz.addMethod("main") [
				static = true
				addParameter("args", ctx.newArrayTypeReference(ctx.string))
				body = ['''
					«toJavaCode(applicationType)».launch(args);
				''']
			]
		}
	}
	
	
}