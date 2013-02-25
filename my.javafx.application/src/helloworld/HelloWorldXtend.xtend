package helloworld

import javafx.scene.Scene
import javafx.scene.control.Button
import javafx.scene.layout.StackPane
import javafx.stage.Stage
import xtendfx.FXApp

@FXApp class HelloWorldXtend {
	
	override start(Stage it) throws Exception {
		title = "Hello World!"
		scene = new Scene(new StackPane => [it|
			children += new Button => [it|
				text = "Say 'Hello'"
				onAction = [it|
					println("Hello World")
				]
			]
		], 300, 250)
		show
	}
	
}