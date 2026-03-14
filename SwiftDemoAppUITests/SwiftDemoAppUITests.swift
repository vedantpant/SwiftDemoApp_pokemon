import XCTest

@MainActor
class SwiftDemoAppUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    override func tearDownWithError() throws {
        app.terminate()
        app = nil
    }
    
    func testValidLogin() {
        let userNameField = app.textFields["username-field"]
        let passwordField = app.secureTextFields["password-field"]
        let loginButton = app.buttons["login-button"]
        
        XCTAssertTrue(userNameField.waitForExistence(timeout: 5))
        userNameField.tap()
        userNameField.typeText("ash")
        
        passwordField.tap()
        passwordField.typeText("pikachu")
        
        loginButton.tap()
        
        let searchTitle = app.staticTexts["search-title"]
        XCTAssertTrue(searchTitle.waitForExistence(timeout: 5), "should navigate to search screen after valid login")
    }
    
    func testInvalidLogin() {
        let userNameField = app.textFields["username-field"]
        let passwordField = app.secureTextFields["password-field"]
        let loginButton = app.buttons["login-button"]
        
        let errorLabel = app.staticTexts["error-label"]
        
        XCTAssertTrue(userNameField.waitForExistence(timeout: 5))
        userNameField.tap()
        userNameField.typeText("wrongUser")
        
        passwordField.tap()
        passwordField.typeText("wrongpassword")
        
        loginButton.tap()
    
        sleep(2)
        XCTAssertTrue(errorLabel.waitForExistence(timeout: 5))
        XCTAssertEqual(errorLabel.label, "Invalid trainer Credentials")
    }
    
    func testEmptyLoginShowsError() {
        
        let loginButton = app.buttons["login-button"]
        
        let errorLabel = app.staticTexts["error-label"]
        
        loginButton.tap()
        
        XCTAssertTrue(errorLabel.waitForExistence(timeout: 5))
        XCTAssertEqual(errorLabel.label, "Invalid trainer Credentials")
    }
    
    func testSearchPokemon() {
        let userNameField = app.textFields["username-field"]
        let passwordField = app.secureTextFields["password-field"]
        let loginButton = app.buttons["login-button"]
        let searchButton = app.buttons["search-button"]
        
        XCTAssertTrue(userNameField.waitForExistence(timeout: 5))
        userNameField.tap()
        userNameField.typeText("ash")
        
        passwordField.tap()
        passwordField.typeText("pikachu")
        
        loginButton.tap()
        
        let searchBar = app.textFields["search-field"]
        
        XCTAssertTrue(searchBar.waitForExistence(timeout: 5))
        searchBar.tap()
        searchBar.typeText("pikachu")
        searchButton.tap()
        
        let resultLabel = app.staticTexts["result-label"]
        
        XCTAssertTrue(resultLabel.waitForExistence(timeout: 10))
        XCTAssertTrue(resultLabel.label.contains("Pikachu"))
        
    }
    
    func testInvalidPokemon() {
        let userNameField = app.textFields["username-field"]
        let passwordField = app.secureTextFields["password-field"]
        let loginButton = app.buttons["login-button"]
        let searchButton = app.buttons["search-button"]
        
        XCTAssertTrue(userNameField.waitForExistence(timeout: 5))
        userNameField.tap()
        userNameField.typeText("ash")
        
        passwordField.tap()
        passwordField.typeText("pikachu")
        
        loginButton.tap()
        
        let searchBar = app.textFields["search-field"]
        
        XCTAssertTrue(searchBar.waitForExistence(timeout: 5))
        searchBar.tap()
        searchBar.typeText("xyzabc123")
        searchButton.tap()
        
        let resultLabel = app.staticTexts["result-label"]
        
        XCTAssertTrue(resultLabel.waitForExistence(timeout: 10))
        XCTAssertTrue(resultLabel.label.contains("not found!"))
        
    }

}
