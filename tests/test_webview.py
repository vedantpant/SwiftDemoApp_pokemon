from pages.login_page import LoginPage
from pages.webview_page import WebViewPage


class TestWebView:

    def test_switch_to_webview_context(self, logged_in_driver):
        webview_page = WebViewPage(logged_in_driver)
        webview_page.tap_webview_tab()
        assert webview_page.enter_webview()
        assert "WEBVIEW" in webview_page.get_current_context()

    def test_return_to_native_context(self, logged_in_driver):
        webpage_view = WebViewPage(logged_in_driver)
        webpage_view.tap_webview_tab()
        assert webpage_view.enter_webview()
        webpage_view.return_to_native()
        assert webpage_view.get_current_context() == "NATIVE_APP"

    def test_all_context_available(self, logged_in_driver):
        webview_page = WebViewPage(logged_in_driver)
        webview_page.tap_webview_tab()
        contexts = webview_page.get_all_contexts()
        assert "NATIVE_APP" in contexts
        webview_contexts = [c for c in contexts if "WEBVIEW" in c]
        assert len(webview_contexts) > 0