//
//  BaseLocalHTMLController.swift
//  Gimmi
//
//  Created by hule on 2024/4/26.
//

import UIKit
import WebKit
class GMBaseLocalHTMLController: GMBaseViewController , WKNavigationDelegate {
    
    var navTitle: String?
    var webView: WKWebView!
    var htmlPath: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = navTitle
        webView = WKWebView(frame: CGRectMake(0, navigationBarHeight, ScreenWidth, ScreenHeight - navigationBarHeight))
        webView.navigationDelegate = self
        view.addSubview(webView)
        let url = URL(fileURLWithPath: htmlPath ?? "")
        webView.loadFileURL(url, allowingReadAccessTo: url.deletingLastPathComponent())
    }
}

