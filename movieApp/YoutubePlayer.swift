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
        guard let baseUrlString = youtubeBaseUrl,
              let baseUrl = URL(string: baseUrlString) else { return }
        
        // Trim any accidental whitespace from the video ID just in case
        let cleanVideoId = videoId.trimmingCharacters(in: .whitespacesAndNewlines)
        let fullURL = baseUrl.appending(path: cleanVideoId)
        
        // Check your Xcode console for this print statement!
        print("DEBUG: The exact URL loading is: \(fullURL.absoluteString)")
        
        webView.load(URLRequest(url: fullURL))
    }
}
