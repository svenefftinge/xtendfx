package xtendfx

import java.util.List
import javafx.application.Application
import org.eclipse.xtend.lib.macro.Active
import org.eclipse.xtend.lib.macro.TransformationContext
import org.eclipse.xtend.lib.macro.TransformationParticipant
import org.eclipse.xtend.lib.macro.declaration.MutableClassDeclaration

@Active(typeof(FXAppCompilationParticipant))
annotation FXApp {
}

class FXAppCompilationParticipant implements TransformationParticipant<MutableClassDeclaration> {
	
	override doTransform(List<? extends MutableClassDeclaration> annotatedTargetElements, TransformationContext ctx) {
		for (clazz : annotatedTargetElements) {
			// extends Application
			val applicationType = ctx.newTypeReference(typeof(Application).name)
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