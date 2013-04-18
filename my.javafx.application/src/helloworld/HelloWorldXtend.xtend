package helloworld

import javafx.scene.control.Button
import javafx.stage.Stage
import xtendfx.FXApp

import static extension xtendfx.scene.SceneBuilder.*

@FXApp class HelloWorldXtend {
	
	override start(Stage it) throws Exception {
		title = "Hello World!"
		width = 300
		height = 250
		scene = Scene [
			children += new Button => [
				text = "Say 'Hello'"
				onAction = [
					println("Hello World")
				]
			]
		]
		show
	}
	
}