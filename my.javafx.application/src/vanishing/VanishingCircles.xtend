package vanishing

import javafx.animation.Timeline
import javafx.scene.effect.BoxBlur
import javafx.scene.shape.Circle
import javafx.stage.Stage
import xtendfx.FXApp

import static java.lang.Math.*
import static javafx.beans.binding.Bindings.*
import static javafx.scene.paint.Color.*

import static extension xtendfx.animation.TimelineExtensions.*
import static extension xtendfx.beans.binding.BindingExtensions.*
import static extension xtendfx.scene.SceneBuilder.*
import static extension xtendfx.util.DurationExtensions.*

@FXApp class VanishingCircles { 
	override start(Stage it) {
		val stage = it
		title = "Vanishing Circles"
		width = 800
		height = 600
		Scene [
			fill = BLACK
			children += (0 .. 10).map [
				new Circle => [
					centerX = stage.width * random
					centerY = stage.height * random
					radius = 150
					fill = color(random, random, random, 0.2)
					effect = new BoxBlur(10, 10, 3)
					// add this for binding:
					strokeWidthProperty -> when(hoverProperty).then(4).otherwise(0)
					stroke = WHITE
					// add this for event listeners:
					val circle = it
					onMouseClicked = [
						Timeline [
							at(3.seconds, circle.radiusProperty <=> 0)
						]
					]
				]
			]
		]
		Timeline [
			cycleCount = Timeline.INDEFINITE
			autoReverse = true
			at(40.seconds,
				stage.scene.children.filter(Circle).map[#[
					centerXProperty <=> stage.width * random,
					centerYProperty <=> stage.height * random
				]].flatten
			)
		].play
		show
	}
}
