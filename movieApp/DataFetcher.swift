//
//  DataFetcher.swift
//  movieApp
//
//  Created by kareem mohamed  on 09/10/2026.
//

import Foundation


let tmbdBaseUrl = ApiConfig.shared?.tmdbBaseURL
let tmbdApiKey = ApiConfig.shared?.tmdbAPIKey

func fetchTitles (for media: String)async throws -> [Title]{
    
    guard  let baseUrl = tmbdBaseUrl else{throw NetworkError.dataMissing}

    guard let apiKey = tmbdApiKey else {throw NetworkError.dataMissing}
}
