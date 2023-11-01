//
//  WebViewModel.swift
//  webApp
//
//  Created by mingyukim on 10/31/23.
//

import SwiftUI
import WebKit
import Foundation

class WebViewModel: ObservableObject {
    // 여기에 WebView의 참조를 저장한다. 이를 통해 외부에서 WebView의 메서드를 호출할 수 있다.
    var webView: WKWebView?

    func goBack() -> Void {
        if ((webView?.canGoBack) != nil) {
            webView?.goBack()
        }
    }

    func goForward() -> Void {
        if ((webView?.canGoForward) != nil) {
            webView?.goForward()
        }
    }

    func goHome() -> Void {
        let homeURL = Constants.DOMAIN_PATH
        
        if let url = URL(string: homeURL) {
            let request = URLRequest(url: url)
            webView?.load(request)
        }
    }
    
    func showSetting() -> Void {
        // 추후 기능 구현
    }
}
