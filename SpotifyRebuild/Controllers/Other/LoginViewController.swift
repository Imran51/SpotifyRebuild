//
//  LoginViewController.swift
//  SpotifyRebuild
//
//  Created by Imran Sayeed on 10/3/21.
//

import UIKit
import WebKit

class LoginViewController: UIViewController, WKNavigationDelegate {
    private let webView: WKWebView = {
        let pref = WKWebpagePreferences()
        pref.allowsContentJavaScript = true
        let config = WKWebViewConfiguration()
        config.defaultWebpagePreferences = pref
        let webView = WKWebView(frame: .zero, configuration: config)

        return webView
    }()

    public var completionHandler: ((Bool) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Sign In"
        self.view.backgroundColor = .systemBackground
        webView.navigationDelegate = self
        self.view.addSubview(self.webView)
        guard let url = AuthManager.shared.signInURL else { return }
        webView.load(URLRequest(url: url))
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webView.frame = view.bounds
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        guard let url = webView.url else { return }

        guard let code = URLComponents(string: url.absoluteString)?.queryItems?.first(where: {$0.name == "code"})?.value else { return }
        webView.isHidden = true
        AuthManager.shared.exchangeCodeForToken(code: code, completion: { [weak self] success in
            DispatchQueue.main.async {
                self?.navigationController?.popViewController(animated: true)
                self?.completionHandler?(success)
            }
        })
    }
}
