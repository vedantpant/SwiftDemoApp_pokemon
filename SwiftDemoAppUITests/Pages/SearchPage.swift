import XCTest

class SearchPage {
    let app: XCUIApplication
    
    init(app: XCUIApplication) {
        self.app = app
    }
    
    var searchField: XCUIElement {
        app.textFields["search-field"]
    }
    
    var searchButton: XCUIElement {
        app.buttons["search-button"]
    }
    
    var resultLabel: XCUIElement {
        app.staticTexts["result-label"]
    }
    
    var typeBadge: XCUIElement {
        app.staticTexts["type-badge"]
    }
    
    @discardableResult func search(pokemon: String) -> SearchPage {
        searchField.tap()
        searchField.typeText(pokemon)
        searchButton.tap()
        return self
    }
    
    func assertResultContains(_ name: String) {
        XCTAssertTrue(resultLabel.waitForExistence(timeout: 10))
        XCTAssertTrue(resultLabel.label.contains(name), "Expected result for \(name) but got : \(resultLabel.label)")
    }
    
    func assertTypeBadge(_ type: String) {
        XCTAssertTrue(typeBadge.waitForExistence(timeout: 10))
        XCTAssertTrue(typeBadge.label.contains(type), "Expected type \(type) but got : \(typeBadge.label)")
    }
    
}

