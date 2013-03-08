package helloworld

import javafx.scene.Scene
import javafx.scene.control.Button
import javafx.scene.layout.StackPane
import javafx.stage.Stage
import xtendfx.FXApp

@FXApp class HelloWorldXtend {
	
	override start(Stage it) throws Exception {
		title = "Hello World!"
		scene = new Scene(new StackPane => [
			children += new Button => [
				text = "Say 'Hello'"
				onAction = [
					println("Hello World")
				]
			]
		], 300, 250)
		show
	}
	
}