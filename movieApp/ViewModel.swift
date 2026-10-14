//
//  ViewModel.swift
//  movieApp
//
//  Created by kareem mohamed  on 11/10/2026.
//

import Foundation


@Observable

class ViewModel{
    enum FetchStatus{
      case  notStarted
        case fetching
        case success
        case failre(underlyingError: Error)
    }
    
    private(set) var homeStatus: FetchStatus = .notStarted
    private var dataFetcher = DataFetcher()
    var trendingMovies : [Title] = []
    var trendingTV : [Title] = []
    var topRatedMovies : [Title] = []
    var topRatedTv : [Title] = []
    
    
    func gettitles()async{
        homeStatus = .fetching
        
     if   trendingMovies.isEmpty{
            
            do{
                async let tMovies =  dataFetcher.fetchTitles(for: "movie" , by: "trending")
                async let tTV =  dataFetcher.fetchTitles(for: "tv" , by: "trending")
                async let tRMovies =  dataFetcher.fetchTitles(for: "movie" , by: "top_rated")
                async let tRTV =  dataFetcher.fetchTitles(for: "tv" , by: "top_rated")
                
                trendingMovies = try await tMovies
                trendingTV = try await tTV
                topRatedMovies = try await tRMovies
                topRatedTv = try await tRTV
                homeStatus = .success
            }catch{
                print(error)
                homeStatus = .failre(underlyingError: error)
            }
        } else{
            homeStatus = .success
        }
    }
}
