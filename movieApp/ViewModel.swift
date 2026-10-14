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
    
    
    func gettitles()async{
        homeStatus = .fetching
        
        do{
            trendingMovies = try await dataFetcher.fetchTitles(for: "movie")
            homeStatus = .success
        }catch{
            print(error)
            homeStatus = .failre(underlyingError: error)
        }
    }
}
