# PokéTrainer iOS Automation Framework

A production-grade iOS test automation framework built on a custom PokéTrainer app integrating with PokéAPI.

## Architecture
cd ~/xcuitest_project/AppiumTests
cat > README.md << 'EOF'
# PokéTrainer iOS Automation Framework

A production-grade iOS test automation framework built on a custom PokéTrainer app integrating with PokéAPI.

## Architecture
```
├── SwiftDemoApp/           # iOS app (UIKit + PokéAPI)
├── SwiftDemoAppUITests/    # XCUITest suite (Swift)
│   └── Pages/              # Page Object Model
└── AppiumTests/            # Appium suite (Python)
    ├── pages/              # Page Object Model
    ├── tests/              # Test cases
    └── config/             # Capabilities
```

## Tech Stack

| Layer | Tool | Language |
|-------|------|----------|
| Native UI Tests | XCUITest | Swift |
| Hybrid/WebView Tests | Appium + XCUITest Driver | Python |
| Reporting | xcresult | Xcode |

## Test Coverage

### XCUITest (5 tests, 91% code coverage)
- Valid login navigation
- Invalid login error message
- Empty login validation
- Pokémon search by name
- Invalid Pokémon search

### Appium (5 tests)
- Valid login
- Invalid login
- Native to WebView context switch
- WebView to native context return
- All contexts detection

## Key Features
- Page Object Model with computed properties (Swift)
- Native to WebView context switching (Appium)
- Launch Arguments for animation disabling in tests
- XCTestPlan with retry on failure (count: 2)
- xcodebuild CLI for CI/CD integration
- 91% code coverage

## Running Tests

### XCUITest
```bash
xcodebuild -project SwiftDemoApp/SwiftDemoApp.xcodeproj \
  -scheme SwiftDemoApp \
  -destination 'platform=iOS Simulator,name=iPhone 17' \
  test
```

### Appium
```bash
appium --port 4723 &
cd AppiumTests
pip install -r requirements.txt
pytest tests/ -v --html=report.html
```

## Credentials
- Username: ash
- Password: pikachu
