package xtendfx.scene

import javafx.event.EventHandler
import javafx.geometry.Point2D
import javafx.scene.Scene
import javafx.scene.input.RotateEvent
import javafx.scene.input.ScrollEvent
import javafx.scene.input.ZoomEvent
import javafx.scene.transform.Affine

import static extension xtendfx.scene.transform.TransformExtensions.*

/**
 * Adds the corresponding effects for the following multi-touch gestures to a scene.
 * <ul>
 * <li>scrolling
 * <li>zooming to a certain position
 * <li>rotating
 * </ul>
 */
class MultiTouchSceneBehavior {

	Scene scene

	ZoomContext zoomContext

	Affine paneTransform

	EventHandler<ZoomEvent> zoomStartHandler

	EventHandler<ZoomEvent> zoomHandler

	EventHandler<ScrollEvent> scrollHandler

	EventHandler<RotateEvent> rotateHandler

	new(Scene scene) {
		this.scene = scene
		val root = scene.root
		paneTransform = new Affine
		root.transforms.clear
		root.transforms += paneTransform
		zoomStartHandler = [
			zoomContext = new ZoomContext(root.sceneToLocal(sceneX, sceneY))
		]
		zoomHandler = [
			val scale = totalZoomFactor / zoomContext.previousScale
			paneTransform.scale(scale, scale)
			val pivotInScene = root.localToScene(zoomContext.pivotInpane)
			paneTransform.translate(sceneX - pivotInScene.x, sceneY - pivotInScene.y)
			zoomContext.previousScale = totalZoomFactor
		]
		scrollHandler = [
			paneTransform.translate(deltaX, deltaY)
		]
		rotateHandler = [
			paneTransform.rotate(angle, sceneX, sceneY)
		]
		scene.addEventHandler(ZoomEvent::ZOOM_STARTED, zoomStartHandler)
		scene.addEventHandler(ZoomEvent::ZOOM, zoomHandler)
		scene.addEventHandler(ZoomEvent::ZOOM_FINISHED, zoomHandler)
		scene.addEventHandler(ScrollEvent::SCROLL, scrollHandler)
		scene.addEventHandler(ScrollEvent::SCROLL_FINISHED, scrollHandler)
		scene.addEventHandler(RotateEvent::ROTATION_STARTED, rotateHandler)
		scene.addEventHandler(RotateEvent::ROTATE, rotateHandler)
		scene.addEventHandler(RotateEvent::ROTATION_FINISHED, rotateHandler)
	}
}

class ZoomContext {
	@Property double previousScale = 1
	@Property Point2D pivotInpane

	new(Point2D pivotInpane) {
		this.pivotInpane = pivotInpane
	}
}
