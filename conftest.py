import pytest
from appium.options.ios.xcuitest.base import XCUITestOptions
from appium import webdriver
from appium.webdriver.common.appiumby import AppiumBy
from config.capabilities import get_capabilities


@pytest.fixture(scope="function")
def driver():
    options = XCUITestOptions()
    caps = get_capabilities()
    for key, value in caps.items():
        options.set_capability(key, value)

    driver = webdriver.Remote("http://localhost:4723", options=options)
    driver.implicitly_wait(10)
    yield driver
    driver.quit()


@pytest.fixture(scope="function")
def logged_in_driver(driver):
    from pages.login_page import LoginPage
    login_page = LoginPage(driver)
    login_page.login("ash", "pikachu")
    yield driver