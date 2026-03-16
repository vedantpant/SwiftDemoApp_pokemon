from appium.webdriver.webdriver import WebDriver
from appium.webdriver.common.appiumby import AppiumBy
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from selenium.common.exceptions import TimeoutException
import logging

logger = logging.getLogger(__name__)

class BasePage:
    DEFAULT_TIMEOUT = 10

    def __init__(self, driver: WebDriver):
        self.driver = driver
        self.wait = WebDriverWait(self.driver, self.DEFAULT_TIMEOUT)

    def find_element(self, locator: tuple, timeout: int = DEFAULT_TIMEOUT):
        try:
            return WebDriverWait(self.driver, timeout).until(
                EC.visibility_of_element_located(locator)
            )
        except Exception as e:
            logger.error(f"Element not found: {locator}")
            raise e

    def tap(self, locator: tuple):
        element = self.find_element(locator)
        element.click()

    def type_text(self, locator: tuple, text: str):
        element = self.find_element(locator)
        element.clear()
        element.send_keys(text)

    def get_text(self, locator: tuple):
        return self.find_element(locator).text

    def is_displayed(self, locator: tuple, timeout: int=5) -> bool:
        try:
            WebDriverWait(self.driver, timeout).until(
                EC.visibility_of_element_located(locator)
            )
            return True
        except TimeoutException:
            return False

    def switch_to_webview(self, timeout: int = 20) -> bool:
        import time
        time.sleep(3)  # Wait for WebView to load
        deadline = time.time() + timeout
        while time.time() < deadline:
            contexts = self.driver.contexts
            print(f"Available contexts: {contexts}")  # Debug
            webview_contexts = [c for c in contexts if "WEBVIEW" in c]
            if webview_contexts:
                self.driver.switch_to.context(webview_contexts[0])
                return True
            time.sleep(1)
        return False

    def switch_to_native(self):
        self.driver.switch_to.context("NATIVE_APP")
        logger.info("Switched to native context")

    def get_all_contexts(self):
        return self.driver.contexts
