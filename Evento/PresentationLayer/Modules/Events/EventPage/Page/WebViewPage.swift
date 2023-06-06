//
//  WebViewPage.swift
//  Evento
//
//  Created by Ramir Amrayev on 01.06.2023.
//

import SwiftUI
import WebKit
 
struct WebViewPage: UIViewRepresentable {
 
    var url: URL
 
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
 
    func updateUIView(_ webView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        webView.load(request)
    }
}
