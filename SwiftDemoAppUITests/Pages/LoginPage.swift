import XCTest

class LoginPage {
    
    let app: XCUIApplication
    
    init(app: XCUIApplication) {
        self.app = app
    }
    
    var usernameField: XCUIElement { app.textFields["username-field"]}
    var passwordField: XCUIElement { app.secureTextFields["password-field"]}
    var loginButton: XCUIElement { app.buttons["login-button"]}
    var errorLabel: XCUIElement { app.staticTexts["error-label"]}
    
    @discardableResult func enterUsername(_ username: String) -> LoginPage{
        usernameField.tap()
        usernameField.typeText(username)
        return self
    }
    
    @discardableResult func enterPassword(_ password: String) -> LoginPage{
        passwordField.tap()
        passwordField.typeText(password)
        return self
    }
    
    @discardableResult func tapLogin() -> LoginPage{
        loginButton.tap()
        return self
    }
    
    func login(username: String, password: String) {
        enterUsername(username)
        enterPassword(password)
        tapLogin()
    }
    
    func assertLoginScreenVisible() {
        XCTAssertTrue(loginButton.waitForExistence(timeout: 5), "Login screen should be visible")
    }
    
    func assertErrormessage(_ expected: String) {
        sleep(2)
        XCTAssertEqual(
            errorLabel.label,
            expected,
            "Error message mismatch"
        )
    }
}
