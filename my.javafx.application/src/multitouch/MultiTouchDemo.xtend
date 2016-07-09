package multitouch

import xtendfx.FXApp
import javafx.stage.Stage
import static extension xtendfx.scene.SceneBuilder.*
import static extension xtendfx.control.ControlBuilder.*
import xtendfx.scene.MultiTouchSceneBehavior

@FXApp class MultiTouchDemo {

	override start(Stage it) {
		new MultiTouchSceneBehavior(StackedScene [
			Label [
				text = '''
					Try some multitouch gestures like
					- scroll
					- zoom
					- rotate
				'''
			]
		])
		width = 640
		height = 480
		show
	}
}