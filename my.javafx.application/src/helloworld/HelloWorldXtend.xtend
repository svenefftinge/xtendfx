package helloworld

import javafx.stage.Stage
import xtendfx.FXApp

import static extension xtendfx.scene.SceneBuilder.*

@FXApp class HelloWorldXtend {
	
    override void start(Stage it) {
        title = "Hello World!"
        width = 300
        height = 250 
        StackedScene [
			Button [
		        text = 'Say "Hello World"'
		        onAction = [ 
		        	println("Hello World!")
		        ]
	        ]  	
        ]
        show
    }
	
}