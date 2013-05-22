package brickbreaker

import javafx.application.Application
import javafx.stage.Stage
import javafx.scene.Group
import javafx.scene.Scene
import javafx.scene.paint.Color

class Main extends Application {
	private static MainFrame mainFrame

    def static MainFrame getMainFrame() {
        return mainFrame
    }
    
    override void start(Stage stage) {
        Config::initialize()
        val root = new Group()
        mainFrame = new MainFrame(root)
        stage.setTitle("Brick Breaker")
        stage.setResizable(false)
        root.setTranslateX(Config::WINDOW_BORDER_X)
        root.setTranslateY(Config::WINDOW_BORDER_Y)
        stage.setWidth(Config::SCREEN_WIDTH + 2*Config::WINDOW_BORDER_X)
        stage.setHeight(Config::SCREEN_HEIGHT+ 2*Config::WINDOW_BORDER_Y + Config::TITLE_BAR_HEIGHT)
        val scene = new Scene(root)
        scene.setFill(Color::BLACK)
        stage.setScene(scene)
        mainFrame.changeState(MainFrame::SPLASH)
        stage.show()
    }

    def static void main(String[] args) {
        Application::launch(args)
    }
}