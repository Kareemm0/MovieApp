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
    
    func fetchTitles (for media: String , by type:String)async throws -> [Title]{
        let fetchtitlesUrl = try buildURL(media: media, type: type)
        guard let fetchtitlesUrl = fetchtitlesUrl else { throw NetworkError.urlBuildFailed}
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
    
    private func buildURL(media: String , type:String) throws -> URL?{
        guard  let baseUrl = tmbdBaseUrl else{throw NetworkError.dataMissing}
        
        guard let apiKey = tmbdApiKey else {throw NetworkError.dataMissing}
        
        var path : String
        
        if type == "trending" {
            path = "3/trending/\(media)/day"
        }else if type == "top_rated" {
            path = "3/\(media)/top_rated"
        }else {
            throw NetworkError.urlBuildFailed
        }
        guard  let url = URL(string:  baseUrl)?
            .appending(path: path)
            .appending(queryItems: [URLQueryItem(name: "api_key", value: apiKey)]) else {
            throw NetworkError.urlBuildFailed
        }
        
   
        return url
        
    }
    

    
}
