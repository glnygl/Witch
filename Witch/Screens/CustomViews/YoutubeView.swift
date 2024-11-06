//
//  YoutubeView.swift
//  Witch
//
//  Created by Glny Gl on 06/11/2024.
//

import SwiftUI
import WebKit

struct YoutubeVideoView: UIViewRepresentable {
    
    var videoId: String
    
    func makeUIView(context: Context) -> WKWebView  {
        let configuration = WKWebViewConfiguration()
        configuration.allowsPictureInPictureMediaPlayback = true
        configuration.allowsInlineMediaPlayback = false
        return WKWebView(frame: .zero, configuration: configuration)
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
        let path = "https://www.youtube.com/embed/\(videoId)"
        guard let url = URL(string: path) else { return }
        let request = URLRequest(url: url)
        webView.scrollView.isScrollEnabled = false
        webView.load(request)
    }
}
