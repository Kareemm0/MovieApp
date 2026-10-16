//
//  YoutubePlayer.swift
//  movieApp
//
//  Created by kareem mohamed  on 14/10/2026.
//

import SwiftUI
import WebKit

struct YoutubePlayer: UIViewRepresentable{
    let webView = WKWebView()
    let videoId: String
    let youtubeBaseUrl = ApiConfig.shared?.youtubeBaseURL
    
    func makeUIView(context: Context) -> some UIView {
        webView
    }
    func updateUIView(_ uiView: UIViewType, context: Context) {
            guard let baseURLString = youtubeBaseUrl,
                  let baseURL = URL(string: baseURLString) else {return}
            let fullURL = baseURL.appending(path: videoId)
            webView.load(URLRequest(url: fullURL))
        }
}
