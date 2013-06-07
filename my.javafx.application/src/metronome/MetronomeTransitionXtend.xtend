package metronome

import javafx.animation.Interpolator
import javafx.animation.Timeline
import javafx.animation.TranslateTransition
import javafx.scene.Group
import javafx.scene.Scene
import javafx.scene.control.Button
import javafx.scene.layout.HBox
import javafx.scene.shape.Circle
import javafx.stage.Stage
import javafx.util.Duration
import xtendfx.FXApp

import static javafx.animation.Animation.Status.*
import static javafx.scene.paint.Color.*

import static extension xtendfx.beans.binding.BindingExtensions.*

@FXApp class MetronomeTransitionXtend {

	Button startButton;
	Button pauseButton;
	Button resumeButton;
	Button stopButton;

	Circle circle = new Circle => [
		centerX = 100
		centerY = 50
		radius = 4
		fill = BLUE
	]

	TranslateTransition anim = new TranslateTransition => [
		duration = new Duration(1000.0)
		node = circle
		fromX = 0
		toX = 200
		interpolator = Interpolator.LINEAR
		autoReverse = true
		cycleCount = Timeline.INDEFINITE
	]

	override void start(Stage it) {
		title = "Metronome with Xtend"
		width = 400
		height = 500
		scene = new Scene(new Group => [
			children += circle
			children += new HBox => [
				layoutX = 60
				layoutY = 420
				children += startButton = new Button("Start") => [
					onAction = [
						anim.playFromStart
					]
				]
				children += pauseButton = new Button("Pause") => [
					onAction = [
						anim.pause
					]
				]
				children += resumeButton = new Button("Resume") => [
					onAction = [
						anim.play
					]
				]
				children += stopButton = new Button("Stop") => [
					onAction = [
						anim.stop
					]
				]
			]
		])
			
		startButton.disableProperty  -> (anim.statusProperty != STOPPED)
		pauseButton.disableProperty  -> (anim.statusProperty != RUNNING)
		resumeButton.disableProperty -> (anim.statusProperty != PAUSED)
		stopButton.disableProperty   -> (anim.statusProperty == STOPPED)

		show
	}

}
