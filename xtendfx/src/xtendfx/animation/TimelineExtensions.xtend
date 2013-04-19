package xtendfx.animation

import javafx.animation.Timeline
import javafx.util.Duration
import javafx.animation.KeyFrame
import javafx.event.EventHandler
import javafx.event.ActionEvent
import javafx.animation.KeyValue
import javafx.beans.value.WritableValue

class TimelineExtensions {
	
	def static Timeline((Timeline)=>void init) {
		new Timeline => init
	}	
	
	def static at(Timeline timeLine, Duration time, EventHandler<ActionEvent> action) {
		timeLine.keyFrames.add(new KeyFrame(time, action))
	}
	
	def static at(Timeline timeLine, Duration time, KeyValue... keyValues) {
		timeLine.keyFrames.add(new KeyFrame(time, keyValues))
	}
	
	def static <T> KeyValue operator_spaceship(WritableValue<T> left, T right) {
		new KeyValue<T>(left,right)
	}
}