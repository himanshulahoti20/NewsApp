//
//  WebViewController.swift
//  News
//
//  Created by Himanshu Lahoti on 06/07/22.
//

import Foundation
import UIKit
import WebKit
class WebViewController : UIViewController, WKNavigationDelegate{
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var progressBar: UIProgressView!
    var UrlString : String?
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.navigationDelegate = self
        let url = URL(string: UrlString!)
        self.webView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
        webView.load(URLRequest(url: url!))
        self.view.addSubview(webView!)
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        progressBar.isHidden = true
    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            self.progressBar.progress = Float(self.webView.estimatedProgress)
        }
    }
}
