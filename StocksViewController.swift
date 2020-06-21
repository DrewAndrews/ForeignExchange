//
//  StocksViewController.swift
//  ForeignExchange
//
//  Created by Andrey Rusinovich on 21.06.2020.
//  Copyright © 2020 Andrey Rusinovich. All rights reserved.
//

import UIKit
import WebKit

class StocksViewController: UIViewController, WKNavigationDelegate {
    var webView: WKWebView!
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let url = URL(string: "https://www.bloomberg.com/markets/stocks")!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }
}
