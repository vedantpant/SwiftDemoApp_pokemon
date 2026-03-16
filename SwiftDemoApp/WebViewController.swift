import UIKit
import WebKit

class WebViewController: UIViewController {

    // MARK: - UI Elements
    let webView: WKWebView = {
        let webView = WKWebView()
        webView.accessibilityIdentifier = "pokeapi-webview"
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()

    let activityIndicator: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.accessibilityIdentifier = "webview-spinner"
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "PokéAPI Docs"
        setupUI()
        loadPage()
    }

    // MARK: - Setup
    func setupUI() {
        view.addSubview(webView)
        view.addSubview(activityIndicator)

        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])

        webView.navigationDelegate = self
        if #available(iOS 16.4, *) {
            webView.isInspectable = true
        }
    }

    // MARK: - Load
    func loadPage() {
        activityIndicator.startAnimating()
        if let url = URL(string: "https://pokeapi.co") {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
}

// MARK: - WKNavigationDelegate
extension WebViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView,
                 didReceive challenge: URLAuthenticationChallenge,
                 completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        if let trust = challenge.protectionSpace.serverTrust {
            completionHandler(.useCredential, URLCredential(trust: trust))
        } else {
            completionHandler(.cancelAuthenticationChallenge, nil)
        }
    }

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        activityIndicator.stopAnimating()
    }
}
