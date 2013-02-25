package xtendfx

import com.google.inject.Inject
import javafx.beans.property.SimpleStringProperty
import org.eclipse.xtend.core.tests.RuntimeInjectorProvider
import org.eclipse.xtext.junit4.InjectWith
import org.eclipse.xtext.junit4.XtextRunner
import org.eclipse.xtext.xbase.compiler.CompilationTestHelper
import org.junit.Before
import org.junit.Test
import org.junit.runner.RunWith

@RunWith(typeof(XtextRunner))
@InjectWith(typeof(RuntimeInjectorProvider))
class FXAppTest {

	@Inject extension CompilationTestHelper

	@Before
	def void initClassPath() {
		setJavaCompilerClassPath(typeof(FXApp), typeof(SimpleStringProperty))
	}

	@Test def testAgainstJavaCode() {
		'''
			import xtendfx.FXApp
			import javafx.stage.Stage
			
			@FXApp class MyFxApp {
				override start(Stage it) {
					//TODO
				}
			}
		'''.assertCompilesTo('''
			import javafx.application.Application;
			import javafx.stage.Stage;
			import xtendfx.FXApp;
			
			@FXApp
			@SuppressWarnings("all")
			public class MyFxApp extends Application {
			  public void start(final Stage it) {
			  }
			  
			  public static void main(final String[] args) {
			    Application.launch(args);
			    
			  }
			}
		''')
	}
}
