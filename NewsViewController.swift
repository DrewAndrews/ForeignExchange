//
//  NewsViewController.swift
//  ForeignExchange
//
//  Created by Andrey Rusinovich on 08.09.2020.
//  Copyright © 2020 Andrey Rusinovich. All rights reserved.
//

import UIKit
import WebKit

class NewsViewController: UIViewController, WKNavigationDelegate, UIScrollViewDelegate {
    var webView: WKWebView!
    
    override func loadView() {
        webView = WKWebView()
        
        webView.navigationDelegate = self
        webView.scrollView.delegate = self
        webView.translatesAutoresizingMaskIntoConstraints = false
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let url = URL(string: "https://www.bloomberg.com/quote/USDRUB:CUR")!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }
    
    func scrollViewWillBeginZooming(_ scrollView: UIScrollView, with view: UIView?) {
        scrollView.pinchGestureRecognizer?.isEnabled = false
    }
}
