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
        let loginPage = LoginPage(app: app)
        loginPage.assertLoginScreenVisible()
        loginPage.login(username: "ash", password: "pikachu")
        
        let searchPage = SearchPage(app: app)
        XCTAssertTrue(searchPage.searchField.waitForExistence(timeout: 5),"Should navigate to search screen after valid login")
    }
    
    func testInvalidLogin() {
        let loginPage = LoginPage(app: app)
        loginPage.assertLoginScreenVisible()
        loginPage.login(username: "wrongUser", password: "wrongPassword")
        
        loginPage.assertErrormessage("Invalid trainer Credentials")
    }
    
    func testEmptyLoginShowsError() {
        
        let loginPage = LoginPage(app: app)
        loginPage.assertLoginScreenVisible()
        loginPage.tapLogin()
        
        loginPage.assertErrormessage("Invalid trainer Credentials")
    }
    
    func testSearchPokemon() {
        let loginPage = LoginPage(app: app)
        loginPage.assertLoginScreenVisible()
        loginPage.login(username: "ash", password: "pikachu")
        
        let searchPage = SearchPage(app: app)
        searchPage.search(pokemon: "charizard")
        searchPage.assertTypeBadge("Fire")
    }
    
    func testInvalidPokemon() {
        let loginPage = LoginPage(app: app)
        loginPage.assertLoginScreenVisible()
        loginPage.login(username: "ash", password: "pikachu")
        
        let searchPage = SearchPage(app: app)
        searchPage.search(pokemon: "invalid")
        searchPage.assertResultContains("not found")
    }

}
