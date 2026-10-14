//
//  Constant.swift
//  movieApp
//
//  Created by kareem mohamed  on 08/10/2026.
//

import Foundation
import SwiftUI


struct Constant {
    static let homeString = "Home"
    static let upcomingString = "Upcoming"
    static let searchString = "Search"
    static let downloadString = "Download"
    static let playString = "Play"
    static let trendingMoviesString = "Trending Movies"
    static let trendingTVString = "Trending TV"
    static let topRatedMovieString = "Top Rated Movies"
    static let topRatedTVString = "Top Rated TV"

    
    static let homeIcon = "house"
    static let upconingIcon = "play.circle"
    static let searchIcon = "magnifyingglass"
    static let downloadIcon = "arrow.down.to.line"
    
    static let testTitleURL = "https://image.tmdb.org/t/p/w500/nnl6OWkyPpuMm595hmAxNW3rZFn.jpg"
    static let testTitleURL2 = "https://image.tmdb.org/t/p/w500/d5iIlFn5s0ImszYzBPb8JPIfbXD.jpg"
    static let testTitleURL3 = "https://image.tmdb.org/t/p/w500/qJ2tW6WMUDux911r6m7haRef0WH.jpg"
    
    static let posterURLStart = "https://image.tmdb.org/t/p/w500"
    
    
    static func addPostertoPath(to titles : inout[Title]){
        for index in titles.indices{
            if let path = titles[index].posterPath {
                titles[index].posterPath = Constant.posterURLStart + path
            }
        }
    }

    

}


extension Text {
    func ghostButton () -> some View{
        self
            .frame(width: 100 , height:  50)
            .foregroundStyle(.buttonText)
            .bold()
            .background{
                RoundedRectangle(cornerRadius: 20, style: RoundedCornerStyle.continuous).stroke(.border,lineWidth: 2)
            }
    }
}
