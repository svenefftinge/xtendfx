package xtendfx

import org.eclipse.xtend.lib.macro.Active
import org.eclipse.xtend.lib.macro.TransformationContext
import org.eclipse.xtend.lib.macro.declaration.MutableClassDeclaration
import javafx.application.Application
import org.eclipse.xtend.lib.macro.AbstractClassProcessor

/**
 * Lets a class extend {@link javafx.application.Application} and
 * adds a main method calling Application#launch
 */
@Active(typeof(FXAppCompilationParticipant))
annotation FXApp {
}

class FXAppCompilationParticipant extends AbstractClassProcessor {

	override doTransform(MutableClassDeclaration annotatedClass, extension TransformationContext ctx) {

		val applicationType = typeof(Application).newTypeReference

		// extends Application
		annotatedClass.extendedClass = applicationType

		// add main
		annotatedClass.addMethod("main") [
			static = true
			addParameter("args", ctx.newArrayTypeReference(ctx.string))
			body = ['''
				«toJavaCode(applicationType)».launch(args);
			''']
		]
	}

}
