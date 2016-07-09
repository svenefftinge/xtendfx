package xtendfx.control

import javafx.scene.control.Accordion
import javafx.scene.control.Button
import javafx.scene.control.CheckBox
import javafx.scene.control.ColorPicker
import javafx.scene.control.ComboBox
import javafx.scene.control.Label
import javafx.scene.control.ListView
import javafx.scene.control.MenuBar
import javafx.scene.control.PasswordField
import javafx.scene.control.ProgressIndicator
import javafx.scene.control.RadioButton
import javafx.scene.control.ScrollBar
import javafx.scene.control.ScrollPane
import javafx.scene.control.Separator
import javafx.scene.control.Slider
import javafx.scene.control.SplitPane
import javafx.scene.control.TabPane
import javafx.scene.control.TableView
import javafx.scene.control.TextArea
import javafx.scene.control.TextField
import javafx.scene.control.TitledPane
import javafx.scene.control.ToggleButton
import javafx.scene.control.ToolBar
import javafx.scene.control.TreeView
import javafx.scene.layout.Pane

class ControlBuilder {
	
	def static Accordion Accordion(Pane parent, (Accordion)=>void init) {
		val accordion = new Accordion() => init
		parent.children += accordion
		return accordion
	}
	
	def static Button Button(Pane parent, (Button)=>void init) {
		val button = new Button() => init
		parent.children += button
		return button
	}
	
	def static CheckBox CheckBox(Pane parent, (CheckBox)=>void init) {
		val checkBox = new CheckBox() => init
		parent.children += checkBox
		return checkBox
	}
	
	def static ColorPicker ColorPicker(Pane parent, (ColorPicker)=>void init) {
		val colorPicker = new ColorPicker() => init
		parent.children += colorPicker
		return colorPicker
	}
	
	def static <T> ComboBox<T> ComboBox(Pane parent, (ComboBox<T>)=>void init) {
		val comboBox = new ComboBox<T>() => init
		parent.children += comboBox
		return comboBox
	}
	
	def static Label Label(Pane parent, (Label)=>void init) {
		val label = new Label() => init
		parent.children += label
		return label
	}
	
	def static <T> ListView<T> ListView(Pane parent, (ListView<T>)=>void init) {
		val listView = new ListView<T>() => init
		parent.children += listView
		return listView
	}
	
	def static MenuBar MenuBar(Pane parent, (MenuBar)=>void init) {
		val menuBar = new MenuBar() => init
		parent.children += menuBar
		return menuBar
	}
	
	def static PasswordField PasswordField(Pane parent, (PasswordField)=>void init) {
		val passwordField = new PasswordField() => init
		parent.children += passwordField
		return passwordField
	}
	
	def static ProgressIndicator ProgressIndicator(Pane parent, (ProgressIndicator)=>void init) {
		val progressIndicator = new ProgressIndicator() => init
		parent.children += progressIndicator
		return progressIndicator
	}
	
	def static RadioButton RadioButton(Pane parent, (RadioButton)=>void init) {
		val radioButton = new RadioButton() => init
		parent.children += radioButton
		return radioButton
	}
	
	def static ScrollBar ScrollBar(Pane parent, (ScrollBar)=>void init) {
		val scrollBar = new ScrollBar() => init
		parent.children += scrollBar
		return scrollBar
	}
	
	def static ScrollPane ScrollPane(Pane parent, (ScrollPane)=>void init) {
		val scrollPane = new ScrollPane() => init
		parent.children += scrollPane
		return scrollPane
	}
	
	def static Separator Separator(Pane parent, (Separator)=>void init) {
		val separator = new Separator() => init
		parent.children += separator
		return separator
	}
	
	def static Slider Slider(Pane parent, (Slider)=>void init) {
		val slider = new Slider() => init
		parent.children += slider
		return slider
	}
	
	def static SplitPane SplitPane(Pane parent, (SplitPane)=>void init) {
		val splitPane = new SplitPane() => init
		parent.children += splitPane
		return splitPane
	}
	
	def static TabPane TabPane(Pane parent, (TabPane)=>void init) {
		val tabPane = new TabPane() => init
		parent.children += tabPane
		return tabPane
	}
	
	def static <S> TableView<S> TableView(Pane parent, (TableView<S>)=>void init) {
		val tableView = new TableView<S>() => init
		parent.children += tableView
		return tableView
	}
	
	def static TextArea TextArea(Pane parent, (TextArea)=>void init) {
		val textArea = new TextArea() => init
		parent.children += textArea
		return textArea
	}
	
	def static TextField TextField(Pane parent, (TextField)=>void init) {
		val textField = new TextField() => init
		parent.children += textField
		return textField
	}
	
	def static TitledPane TitledPane(Pane parent, (TitledPane)=>void init) {
		val titledPane = new TitledPane() => init
		parent.children += titledPane
		return titledPane
	}
	
	def static ToggleButton ToggleButton(Pane parent, (ToggleButton)=>void init) {
		val toggleButton = new ToggleButton() => init
		parent.children += toggleButton
		return toggleButton
	}
	
	def static ToolBar ToolBar(Pane parent, (ToolBar)=>void init) {
		val toolBar = new ToolBar() => init
		parent.children += toolBar
		return toolBar
	}
	
	def static <T> TreeView<T> TreeView(Pane parent, (TreeView<T>)=>void init) {
		val treeView = new TreeView<T>() => init
		parent.children += treeView
		return treeView
	}
}