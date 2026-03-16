def get_capabilities():
    return {
        "platformName": "iOS",
        "appium:platformVersion": "26.0",
        "appium:deviceName": "iPhone 17",
        "appium:automationName": "XCUITest",
        "appium:bundleId": "com.vedant.SwiftDemoApp",
        "appium:noReset": False,
        "appium:newCommandTimeout": 120,
        "appium:webviewConnectTimeout": 20000,  # ← add this
        "appium:includeSafariInWebviews": True,  # ← add this
    }