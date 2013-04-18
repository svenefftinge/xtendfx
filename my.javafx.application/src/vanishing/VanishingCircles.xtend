package vanishing

import javafx.animation.Timeline
import javafx.scene.effect.BoxBlur
import javafx.scene.shape.Circle
import javafx.stage.Stage
import xtendfx.FXApp

import static java.lang.Math.*
import static javafx.scene.paint.Color.*

import static extension xtendfx.scene.SceneBuilder.*
import static extension xtendfx.util.DurationExtensions.*
import static extension javafx.beans.binding.Bindings.*
import static extension xtendfx.beans.binding.BindingExtensions.*
import static extension xtendfx.beans.binding.NumberExpressionExtensions.*
import static extension xtendfx.animation.TimelineExtensions.*

@FXApp class VanishingCircles {

	override start(Stage it) {
		val stage = it
		title = "Vanishing Circles"
		width = 800
		height = 600
		scene = Scene [
			fill = BLACK
			children += (0 .. 50).map [
				new Circle => [
					centerXProperty -> stage.widthProperty * random
					centerYProperty -> stage.heightProperty * random
					radius = 150
					fill = color(random, random, random, 0.2)
					effect = new BoxBlur(10, 10, 3)
					// add this for binding:
					strokeWidthProperty -> when(hoverProperty).then(4).otherwise(0)
					stroke = WHITE
					// add this for event listeners:
					val circle = it
					onMouseClicked = [
						circle.radius = 0
					]
				]
			]
		]

		Timeline [
			cycleCount = Timeline::INDEFINITE
			autoReverse = true
			at(4.seconds) [
				stage.scene.children.filter(typeof(Circle)).forEach [
					centerXProperty -> stage.widthProperty * random
					centerYProperty -> stage.heightProperty * random
				]
			]
		].play

		show
	}

}
