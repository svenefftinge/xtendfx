package xtendfx.animation

import javafx.animation.Timeline
import javafx.util.Duration
import javafx.animation.KeyFrame
import javafx.event.EventHandler
import javafx.event.ActionEvent

class TimelineExtensions {
	
	def static Timeline((Timeline)=>void init) {
		new Timeline => init
	}	
	
	def static at(Timeline timeLine, Duration time, EventHandler<ActionEvent> action) {
		timeLine.keyFrames.add(new KeyFrame(time, action))
	}
}