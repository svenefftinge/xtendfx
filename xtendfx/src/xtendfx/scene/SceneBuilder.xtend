package xtendfx.scene

import javafx.collections.ObservableList
import javafx.scene.Group
import javafx.scene.Node
import javafx.scene.Scene
import javafx.scene.control.Button
import javafx.scene.control.Label
import javafx.scene.layout.GridPane
import javafx.scene.layout.Pane
import javafx.scene.layout.StackPane
import javafx.stage.Stage

class SceneBuilder {
	
	def static Scene Scene((Scene)=>void init) {
		new Scene(new Group) => init
	}
	
	def static Scene StackedScene(Stage parent, (StackPane)=>void init) {
		val stackPane = new StackPane
		val result = new Scene(stackPane) 
		init.apply(stackPane)
		parent.scene = result
		return result
	}
	
	def static Button Button(Pane parent, (Button)=>void init) {
		val button = new Button() => init
		parent.children += button
		return button
	}
	
	def static Label Label(Pane parent, (Label)=>void init) {
		val label = new Label() => init
		parent.children += label
		return label
	}
	
	def static Scene GridPaneScene((GridPane)=>void init) {
		val gridPane = new GridPane
		val result = new Scene(gridPane) 
		init.apply(gridPane)
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