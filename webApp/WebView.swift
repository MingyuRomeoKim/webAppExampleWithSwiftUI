//
//  WebView.swift
//  webApp
//
//  Created by mingyukim on 10/30/23.
//

import SwiftUI
import WebKit

// 1. SwiftUI를 위한 WKWebView 래퍼
struct WebView: UIViewRepresentable {
    
    @ObservedObject private var webViewModel: WebViewModel
    private var request: URLRequest
    
    init(request: URLRequest,webViewModel: WebViewModel) {
        self.request = request
        self.webViewModel = webViewModel
    }
    
    func makeUIView(context: Context) -> WKWebView {
        // 여러 개의 WKWebView 에서 쿠키값을 공유하기 위해 WKProcessPool 코드 추가.
        let wKProcessPool = WKProcessPool()
        let wKPreferences = WKPreferences()
        let webConfiguration = WKWebViewConfiguration()
        if #available(iOS 14.0, *) {
            webConfiguration.defaultWebpagePreferences.allowsContentJavaScript = true
        } else {
            // Fallback on earlier versions
            wKPreferences.javaScriptEnabled = true
        }
        wKPreferences.javaScriptCanOpenWindowsAutomatically = true
        
        // 웹뷰 구성 설정        
        webConfiguration.processPool = wKProcessPool
        webConfiguration.preferences = wKPreferences
        
        let webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.navigationDelegate = context.coordinator
        webViewModel.webView = webView
        
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        if uiView.url?.absoluteString != self.request.url?.absoluteString {
            uiView.load(self.request)
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: WebView
        
        init(_ parent: WebView) {
            self.parent = parent
        }
        
        // 필요한 WKNavigationDelegate 메서드를 여기에 추가하세요.
    }
}
