//
//  DataFetcher.swift
//  movieApp
//
//  Created by kareem mohamed  on 09/10/2026.
//

import Foundation

struct DataFetcher{
    
    let tmbdBaseUrl = ApiConfig.shared?.tmdbBaseURL
    let tmbdApiKey = ApiConfig.shared?.tmdbAPIKey
    
    func fetchTitles (for media: String)async throws -> [Title]{
        
        guard  let baseUrl = tmbdBaseUrl else{throw NetworkError.dataMissing}
        
        guard let apiKey = tmbdApiKey else {throw NetworkError.dataMissing}
        
        
        guard  let fetchtitlesUrl = URL(string:  baseUrl)?
            .appending(path: "3/trending/\(media)/day")
            .appending(queryItems: [URLQueryItem(name: "api_key", value: apiKey)]) else {
            throw NetworkError.urlBuildFailed
        }
        
        print(fetchtitlesUrl)
        
        let(data,urlResponse) = try await URLSession.shared.data(from: fetchtitlesUrl)
        
        
        guard let response = urlResponse as? HTTPURLResponse , response.statusCode == 200 else{
            throw NetworkError.badRequestResponse(underlyingError: NSError(
                domain: "DataFetcher",
                code: (urlResponse as? HTTPURLResponse)?.statusCode ?? -1,
                userInfo: [NSLocalizedDescriptionKey :"Invalid HTTP Request"]))
        }
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        var titles =  try decoder.decode(APIObject.self, from: data).results
         Constant.addPostertoPath(to: &titles)
        return titles
    }
    
}
