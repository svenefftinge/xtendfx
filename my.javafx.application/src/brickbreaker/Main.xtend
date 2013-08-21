package brickbreaker

import javafx.scene.Group
import javafx.scene.Scene
import javafx.scene.paint.Color
import javafx.stage.Stage
import xtendfx.FXApp

import static brickbreaker.Config.*

@FXApp class Main {
	
	static MainFrame mainFrame
    
    def static getMainFrame() {
        return mainFrame
    }
    
    override void start(Stage it) {
        initialize
        val root = new Group => [
        	translateX = WINDOW_BORDER_X
        	translateY = WINDOW_BORDER_Y
        ]
        mainFrame = new MainFrame(root)
        title = "Brick Breaker"
        resizable = false
        width = SCREEN_WIDTH + 2 * WINDOW_BORDER_X
        height = SCREEN_HEIGHT+ 2 * WINDOW_BORDER_Y + TITLE_BAR_HEIGHT
        scene = new Scene(root)
        scene.fill = Color.BLACK
        mainFrame.changeState(MainFrame.SPLASH)
        show
    }

}