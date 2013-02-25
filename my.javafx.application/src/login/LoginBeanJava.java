package login;

import javafx.beans.property.SimpleStringProperty;

class LoginBeanJava {

	private String userName = "";

	private SimpleStringProperty userNameProperty;

	public String getUserName() {
		return (this.userNameProperty != null) ? this.userNameProperty.get() : this.userName;
	}

	public void setUserName(final String userName) {
		if (userNameProperty != null) {
			this.userNameProperty.set(userName);
		} else {
			this.userName = userName;
		}
	}

	public SimpleStringProperty userNameProperty() {
		if (this.userNameProperty == null) {
			this.userNameProperty = new SimpleStringProperty(this, "userName", this.userName);
		}
		return this.userNameProperty;
	}
	
	private String password;

	private SimpleStringProperty passwordProperty;

	public String getPassword() {
		return (this.passwordProperty != null) ? this.passwordProperty.get() : this.password;
	}

	public void setPassword(final String password) {
		if (passwordProperty != null) {
			this.passwordProperty.set(password);
		} else {
			this.password = password;
		}
	}

	public SimpleStringProperty passwordProperty() {
		if (this.passwordProperty == null) {
			this.passwordProperty = new SimpleStringProperty(this, "password", this.password);
		}
		return this.passwordProperty;
	}
}