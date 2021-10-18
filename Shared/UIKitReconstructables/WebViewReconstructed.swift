//
//  WebViewReconstructed.swift
//  NewsApp
//
//  Created by Chris Guirguis on 10/12/21.
//

import SwiftUI
import WebKit

struct WebViewReconstructed: View {
    var htmlString:String
    
    @State var height: CGFloat = 0
     var body: some View {

         WebView(dynamicHeight: $height, htmlText: htmlString)
                 .frame(height: height)
                 .background(Color.green)
     }
   }
   

struct WebView : UIViewRepresentable {
    @Binding var dynamicHeight: CGFloat
    
    var webview: WKWebView = WKWebView()
    var htmlText: String

    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: WebView

        init(_ parent: WebView) {
            self.parent = parent
        }
        
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.parent.dynamicHeight = webView.scrollView.contentSize.height
                if self.parent.htmlText.contains("vimeo") {
                    print("content size = \(webView.scrollView.contentSize)")
                    print("intrinsic size = \(webView.intrinsicContentSize)")
                    print("SV_intrinsic size = \(webView.scrollView.intrinsicContentSize)")
                    print("visible size = \(webView.scrollView.visibleSize)")
                    print("webview size = \(webView.frame)")
                }
                
                
            }
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIView(context: Context) -> WKWebView  {
        webview.scrollView.bounces = false
        webview.navigationDelegate = context.coordinator
        
        let htmlStart = """
        <HTML>
        <HEAD>
        
        <style>
                iframe {
                width: 100%;
                height: 100%;

                }
                .iframe-wrapper {
                width: 100vw;
                height: 56.25vw
                }
                
        </style>
        <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">
        </HEAD>
        <BODY  style=\"margin:0\"><div class="iframe-wrapper">
"""
        let htmlEnd = "</div></BODY></HTML>"
//        let metaContent = "<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">"
        let htmlString = "\(htmlStart)\(htmlText)\(htmlEnd)"
//        let trialString = "<html><head><meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no'></head><body><div id='wrapper'>\(htmlText)</div></body></html>"
        webview.loadHTMLString(htmlString, baseURL:  nil)
        
        return webview
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        DispatchQueue.main.async {
            self.dynamicHeight = uiView.scrollView.contentSize.height
        }
        
    }
}


