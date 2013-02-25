package login;

import javafx.application.Application;
import javafx.beans.binding.StringExpression;
import javafx.beans.property.SimpleStringProperty;
import javafx.event.ActionEvent;
import javafx.event.EventHandler;
import javafx.geometry.Insets;
import javafx.geometry.Pos;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.scene.control.PasswordField;
import javafx.scene.control.TextField;
import javafx.scene.layout.GridPane;
import javafx.scene.layout.HBox;
import javafx.scene.paint.Color;
import javafx.scene.text.Font;
import javafx.scene.text.FontWeight;
import javafx.scene.text.Text;
import javafx.stage.Stage;

public class LoginScreenJava extends Application {

	private final LoginBeanXtend login = new LoginBeanXtend();

	private final StringExpression welcomeMessage = 
			new SimpleStringProperty("Welcome ").concat(login.userNameProperty()).concat("!");

	/**
	 * http://docs.oracle.com/javafx/2/get_started/form.htm
	 */
	@Override
	public void start(final Stage stage) throws Exception {
		stage.setTitle("JavaFX Welcome");

		GridPane grid = new GridPane();
		grid.setAlignment(Pos.CENTER);
		grid.setHgap(10);
		grid.setVgap(10);
		grid.setPadding(new Insets(25, 25, 25, 25));

		Scene scene = new Scene(grid, 300, 275);
		stage.setScene(scene);

		Text scenetitle = new Text();
		scenetitle.setFont(Font.font("Tahoma", FontWeight.NORMAL, 20));
		scenetitle.textProperty().bind(welcomeMessage);
		grid.add(scenetitle, 0, 0, 2, 1);

		grid.add(new Label("User Name:"), 0, 1);

		TextField userTextField = new TextField();
		grid.add(userTextField, 1, 1);
		userTextField.textProperty().bindBidirectional(login.userNameProperty());

		grid.add(new Label("Password:"), 0, 2);

		PasswordField pwBox = new PasswordField();
		grid.add(pwBox, 1, 2);
		pwBox.textProperty().bindBidirectional(login.passwordProperty());

		Button btn = new Button("Sign in");
		HBox hbBtn = new HBox(10);
		hbBtn.setAlignment(Pos.BOTTOM_RIGHT);
		hbBtn.getChildren().add(btn);
		grid.add(hbBtn, 1, 4);

		final Text actiontarget = new Text();
		grid.add(actiontarget, 1, 6);

		btn.setOnAction(new EventHandler<ActionEvent>() {
			@Override
			public void handle(ActionEvent e) {
				actiontarget.setFill(Color.FIREBRICK);
				actiontarget.setText("Sign in button pressed");
			}
		});

		stage.show();
	}

	public static void main(String[] args) {
		launch(args);
	}

}
