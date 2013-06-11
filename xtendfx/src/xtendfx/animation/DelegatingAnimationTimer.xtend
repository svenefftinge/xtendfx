package xtendfx.animation

import javafx.animation.AnimationTimer

class DelegatingAnimationTimer extends AnimationTimer {
	LongCallback callback;
	
	new(LongCallback callback) {
		this.callback = callback;
	}
	
	override handle(long now) {
		callback.call(now);
	}
	
}