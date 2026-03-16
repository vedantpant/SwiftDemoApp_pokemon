from pages.base_page import BasePage
from appium.webdriver.webdriver import WebDriver
from appium.webdriver.common.appiumby import AppiumBy

class LoginPage(BasePage):

    def __init__(self, driver: WebDriver):
        super().__init__(driver)

    USERNAME_FIELD = (AppiumBy.ACCESSIBILITY_ID, "username-field")
    PASSWORD_FIELD = (AppiumBy.ACCESSIBILITY_ID, "password-field")
    LOGIN_BUTTON = (AppiumBy.ACCESSIBILITY_ID, "login-button")
    ERROR_LABEL = (AppiumBy.ACCESSIBILITY_ID, "error-label")

    def enter_username(self, username: str):
        self.type_text(self.USERNAME_FIELD, username)

    def enter_password(self, password: str):
        self.type_text(self.PASSWORD_FIELD, password)

    def click_login(self):
        self.tap(self.LOGIN_BUTTON)

    def login(self,username: str, password: str):
        self.enter_username(username)
        self.enter_password(password)
        self.click_login()
