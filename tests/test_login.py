from pages.login_page import LoginPage
from appium.webdriver.common.appiumby import AppiumBy


class TestLogin:

    def test_valid_login(self, driver):
        login_page = LoginPage(driver)
        login_page.login("ash", "pikachu")

        assert login_page.is_displayed((AppiumBy.ACCESSIBILITY_ID, "search-field"))

    def test_invalid_login(self, driver):
        login_page = LoginPage(driver)
        login_page.login("FGFKNF", "SDFDSIFJOS")

        assert login_page.is_displayed((AppiumBy.ACCESSIBILITY_ID, "error-label"))

        error_text = login_page.get_text((AppiumBy.ACCESSIBILITY_ID, "error-label"))
        assert "Invalid" in error_text
