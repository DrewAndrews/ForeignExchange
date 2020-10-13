//
//  StocksViewController.swift
//  ForeignExchange
//
//  Created by Andrey Rusinovich on 21.06.2020.
//  Copyright © 2020 Andrey Rusinovich. All rights reserved.
//

import UIKit
import WebKit

class StocksViewController: UIViewController, WKNavigationDelegate, UIScrollViewDelegate {
    var webView: WKWebView!
    
    let url = URL(string: "https://www.bloomberg.com/markets/stocks")!
    
    override func loadView() {
        webView = WKWebView()
        
        webView.navigationDelegate = self
        webView.scrollView.delegate = self
        webView.translatesAutoresizingMaskIntoConstraints = false
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }
    
    func scrollViewWillBeginZooming(_ scrollView: UIScrollView, with view: UIView?) {
        scrollView.pinchGestureRecognizer?.isEnabled = false
    }
    
    @IBAction func reloadStocksPage(_ sender: UIBarButtonItem) {
        webView.load(URLRequest(url: url))
    }
}
