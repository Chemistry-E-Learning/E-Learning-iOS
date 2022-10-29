//
//  WebView.swift
//  ChemistryAR
//
//  Created by NhatMinh on 25/10/2022.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    @Binding private var contentHeight: CGFloat
    @Binding private var isLoading: Bool

    private let type: WebViewType
    private let url: String

    init(
        contentHeight: Binding<CGFloat>,
        isLoading: Binding<Bool>,
        type: WebViewType,
        url: String
    ) {
        _contentHeight = contentHeight
        _isLoading = isLoading
        self.type = type
        self.url = url
    }

    /// Config display web view
    /// - Parameter context: context
    /// - Returns: WKWebView
    func makeUIView(context: Context) -> WKWebView {
        let config = WKWebViewConfiguration()
        config.allowsInlineMediaPlayback = true
        let webView = WKWebView(frame: .zero, configuration: config)
        webView.scrollView.delegate = context.coordinator
        if type == .normal {
            webView.navigationDelegate = context.coordinator
            webView.uiDelegate = context.coordinator
            webView.scrollView.contentInset.top = 0
            webView.scrollView.alwaysBounceHorizontal = false
            webView.scrollView.showsVerticalScrollIndicator = false
            webView.scrollView.showsHorizontalScrollIndicator = false
            webView.scrollView.isUserInteractionEnabled = false
            webView.scrollView.isScrollEnabled = false
            webView.loadHTMLString(url, baseURL: nil)
        } else {
            guard let url = URL(string: url) else {
                return webView
            }
            webView.load(URLRequest(url: url))
        }
        return webView
    }

    /// Update web view by WebViewType
    /// - Parameters:
    ///   - uiView: WKWebView
    ///   - context: Context
    func updateUIView(_ uiView: WKWebView, context: Context) {
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }

    class Coordinator: NSObject, WKNavigationDelegate, WKUIDelegate, UIScrollViewDelegate {
        var parent: WebView

        init(_ parent: WebView) {
            self.parent = parent
        }

        func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
            parent.isLoading = true
        }

        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            webView.evaluateJavaScript("document.documentElement.scrollHeight") { height, _ in
                DispatchQueue.main.async {
                    if let height = height as? CGFloat {
                        self.parent.contentHeight = height
                        self.parent.isLoading = false
                        webView.scrollView.isUserInteractionEnabled = true
                    }
                }
            }
        }

        func webView(
            _ webView: WKWebView,
            createWebViewWith configuration: WKWebViewConfiguration,
            for navigationAction: WKNavigationAction,
            windowFeatures: WKWindowFeatures
        ) -> WKWebView? {
            return nil
        }

        // disable zoom in/out event
        func scrollViewWillBeginZooming(_ scrollView: UIScrollView, with view: UIView?) {
            scrollView.pinchGestureRecognizer?.isEnabled = false
        }
    }
}

extension WebView {
    enum WebViewType {
        case normal
        case external
    }
}
