package xtendfx.scene

import javafx.collections.ObservableList
import javafx.scene.Group
import javafx.scene.Node
import javafx.scene.Scene
import javafx.scene.layout.Pane
import javafx.scene.layout.GridPane

class SceneBuilder {
	
	def static Scene Scene((Scene)=>void init) {
		new Scene(new Group) => init
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