//
//  YoutubeSearchResponse.swift
//  movieApp
//
//  Created by kareem mohamed  on 14/10/2026.
//

import Foundation

struct YoutubeSearchResponse: Codable{
    let items: [ItemProperties]?
}

struct ItemProperties:Codable{
    let id: IdProperties?
}

struct IdProperties: Codable{
    let videoId: String?
}
