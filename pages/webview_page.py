from appium.webdriver.common.appiumby import AppiumBy
from selenium.webdriver.common.by import By
from pages.base_page import BasePage
from appium.webdriver.webdriver import WebDriver

class WebViewPage(BasePage):
    def __init__(self, driver: WebDriver):
        super().__init__(driver)

    WEBVIEW_TAB = (AppiumBy.ACCESSIBILITY_ID, "PokéAPI")
    PAGE_TITLE = (By.TAG_NAME, "h1")

    def tap_webview_tab(self):
        self.tap(self.WEBVIEW_TAB)

    def enter_webview(self) -> bool:
        return self.switch_to_webview(timeout=20)

    def return_to_native(self):
        self.switch_to_native()

    def get_page_headline(self) -> str:
        return self.get_text(self.PAGE_TITLE)

    def get_current_context(self) -> str:
        return self.driver.current_context
