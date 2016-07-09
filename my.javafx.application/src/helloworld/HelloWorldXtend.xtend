package helloworld

import xtendfx.FXApp
import javafx.stage.Stage

import static extension xtendfx.scene.SceneBuilder.*
import static extension xtendfx.control.ControlBuilder.*

@FXApp class HelloWorldXtend {
	
	override start(Stage it) {
		StackedScene[
			Button[
				text = '''Say "Hello World"'''
				onAction = [println("Hello World!")]
			]
		]
		title = "Hello World!"
		width = 300
		height = 250
		show
	}
}