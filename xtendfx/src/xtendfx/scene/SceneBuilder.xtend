package xtendfx.scene

import javafx.collections.ObservableList
import javafx.scene.Group
import javafx.scene.Node
import javafx.scene.Scene
import javafx.scene.layout.AnchorPane
import javafx.scene.layout.BorderPane
import javafx.scene.layout.FlowPane
import javafx.scene.layout.GridPane
import javafx.scene.layout.HBox
import javafx.scene.layout.Pane
import javafx.scene.layout.StackPane
import javafx.scene.layout.TilePane
import javafx.scene.layout.VBox
import javafx.stage.Stage

class SceneBuilder {
	
	def static Scene Scene(Stage parent, (Scene)=>void init) {
		val scene = new Scene(new Group) => init
		parent.scene = scene
		return scene
	}
	
	def static Scene AnchoredScene(Stage parent, (AnchorPane)=>void init) {
		val anchorPane = new AnchorPane
		val result = new Scene(anchorPane)
		init.apply(anchorPane)
		parent.scene = result
		return result
	}
	
	def static Scene BorderedScene(Stage parent, (BorderPane)=>void init) {
		val borderPane = new BorderPane
		val result = new Scene(borderPane)
		init.apply(borderPane)
		parent.scene = result
		return result
	}
	
	def static Scene FlowedScene(Stage parent, (FlowPane)=>void init) {
		val flowPane = new FlowPane
		val result = new Scene(flowPane)
		init.apply(flowPane)
		parent.scene = result
		return result
	}
	
	def static Scene GridedScene(Stage parent, (GridPane)=>void init) {
		val gridPane = new GridPane
		val result = new Scene(gridPane)
		init.apply(gridPane)
		parent.scene = result
		return result
	}
	
	def static Scene HBoxedScene(Stage parent, (HBox)=>void init) {
		val hbox = new HBox
		val result = new Scene(hbox)
		init.apply(hbox)
		parent.scene = result
		return result
	}
	
	def static Scene PanedScene(Stage parent, (Pane)=>void init) {
		val pane = new Pane
		val result = new Scene(pane)
		init.apply(pane)
		parent.scene = result
		return result
	}
	
	def static Scene StackedScene(Stage parent, (StackPane)=>void init) {
		val stackPane = new StackPane
		val result = new Scene(stackPane) 
		init.apply(stackPane)
		parent.scene = result
		return result
	}
	
	def static Scene TiledScene(Stage parent, (TilePane)=>void init) {
		val tilePane = new TilePane
		val result = new Scene(tilePane) 
		init.apply(tilePane)
		parent.scene = result
		return result
	}
	
	def static Scene VBoxedScene(Stage parent, (VBox)=>void init) {
		val vbox = new VBox
		val result = new Scene(vbox) 
		init.apply(vbox)
		parent.scene = result
		return result
	}

	def static ObservableList<Node> getChildren(Scene it) {
		switch r:it.root {
			Group : r.children
			Pane  : r.children
			default : throw new IllegalStateException("no root set")
		}
	}
}