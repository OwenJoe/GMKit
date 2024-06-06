//
//  GMBaseWebViewController.swift
//  Gimmi
//
//  Created by hule on 2024/4/25.
//

import UIKit
import WebKit
class GMBaseWebViewController: GMBaseViewController, WKNavigationDelegate {

    var webView: WKWebView?
    var urlStr: String?
    var bgView:  UIView?
    override func viewDidLoad() {
        super.viewDidLoad()

        // 创建 wkwebView 案例
        webView = WKWebView(frame: CGRectMake(0, navigationBarHeight, ScreenWidth, ScreenHeight - navigationBarHeight))
        webView?.navigationDelegate = self  // 设置navigationDelegate
        webView?.backgroundColor = HexString("#101123")
        webView?.allowsBackForwardNavigationGestures = false //禁止webView侧滑
        view.addSubview(webView!)
        //加载网页内容
        if let url = URL(string: self.urlStr ?? "") {
            let request = URLRequest(url: url)
            self.webView?.load(request)
           
        }

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        GMProgressHUD.dismiss()
    }
    
    // 页面开始加载时调用
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("准备加载")
        GMProgressHUD.show()
    }

    // 页面加载完成时调用
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        // 页面加载完成后的操作
        print("加载完成")
        GMProgressHUD.dismiss()
    }

    // 页面加载失败时调用
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        // 页面加载失败时的操作
        GMProgressHUD.dismiss()
    }

}
