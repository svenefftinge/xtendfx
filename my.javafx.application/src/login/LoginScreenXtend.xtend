package login

import javafx.geometry.Insets
import javafx.geometry.Pos
import javafx.scene.control.Button
import javafx.scene.control.Label
import javafx.scene.control.PasswordField
import javafx.scene.control.TextField
import javafx.scene.layout.HBox
import javafx.scene.paint.Color
import javafx.scene.text.Font
import javafx.scene.text.FontWeight
import javafx.scene.text.Text
import javafx.stage.Stage
import xtendfx.FXApp

import static xtendfx.scene.SceneBuilder.*

import static extension xtendfx.beans.binding.BindingExtensions.*
import static extension xtendfx.beans.binding.StringExpressionExtensions.*

@FXApp class LoginScreenXtend {

	val login = new LoginBeanXtend
	val welcomeMessage = "Welcome ".asProperty + login.userNameProperty + "!"
	Text actiontarget	

	/**
	 * http://docs.oracle.com/javafx/2/get_started/form.htm
	 */
	override start(Stage it) throws Exception {
		title = "JavaFX Welcome"
		width = 300
		height = 250
		scene = GridPaneScene [
			alignment = Pos::CENTER
			hgap = 10
			vgap = 10
			padding = new Insets(25, 25, 25, 25)
			add(new Text => [
				font = Font::font("Tahoma", FontWeight::NORMAL, 20)
				textProperty -> welcomeMessage
			], 0, 0, 2, 1)
	
			add(new Label("User Name:"), 0, 1)
			add(new TextField => [
				textProperty <> login.userNameProperty
			], 1, 1)
	
			add(new Label("Password:"), 0, 2)
			add(new PasswordField => [
				textProperty <> login.passwordProperty
			], 1, 2)
	
			add(new HBox(10) => [
				alignment = Pos::BOTTOM_RIGHT
				children += new Button("Sign in") => [
					onAction = [
						actiontarget.fill = Color::FIREBRICK
						actiontarget.text = "Sign in button pressed"
					]
				]
			], 1, 4)
			add(actiontarget = new Text, 1, 6)
		]
		show
	}

}

