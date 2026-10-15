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
    let youtubeSearchUrl = ApiConfig.shared?.youtubesearchUrl
    let youtubeApiKey = ApiConfig.shared?.youtubeApiKey
    
    func fetchTitles (for media: String , by type:String)async throws -> [Title]{
        let fetchtitlesUrl = try buildURL(media: media, type: type)
        guard let fetchtitlesUrl = fetchtitlesUrl else { throw NetworkError.urlBuildFailed}
        print(fetchtitlesUrl)
        var titles = try await fetchAndDecode(url : fetchtitlesUrl , type: APIObject.self).results
        Constant.addPostertoPath(to: &titles)
        return titles
    }
    
    func fetchVideoId(for title :String) async throws -> String{
        guard let baseSearchUrl = youtubeSearchUrl else {throw NetworkError.missingconfig}
        guard let searchApiKey = youtubeApiKey else{throw NetworkError.missingconfig}
    
        let trailerSearch = title + YoutubeUrlStrings.space.rawValue + YoutubeUrlStrings.trailer.rawValue
        
        guard let fetchVideoUrl = URL(string: baseSearchUrl)?.appending(queryItems:[
        URLQueryItem(name: YoutubeUrlStrings.querySearch.rawValue,value:trailerSearch),
        URLQueryItem(name: YoutubeUrlStrings.key.rawValue,value:searchApiKey)

        ])else {
            throw NetworkError.urlBuildFailed
        }
        print(fetchVideoUrl)
        
        
        return try await fetchAndDecode(url: fetchVideoUrl, type:YoutubeSearchResponse.self).items?.first?.id?.videoId ?? ""
    }
    
    func fetchAndDecode<T: Decodable>(url: URL , type: T.Type) async throws -> T{
        
        let(data,urlResponse) = try await URLSession.shared.data(from: url)
        
        guard let response = urlResponse as? HTTPURLResponse , response.statusCode == 200 else{
            throw NetworkError.badRequestResponse(underlyingError: NSError(
                domain: "DataFetcher",
                code: (urlResponse as? HTTPURLResponse)?.statusCode ?? -1,
                userInfo: [NSLocalizedDescriptionKey :"Invalid HTTP Request"]))
        }
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(type, from: data)
    
    }
    
    private func buildURL(media:String , type:String) throws -> URL?{
        guard  let baseUrl = tmbdBaseUrl else {throw NetworkError.dataMissing}
        
        
        guard let apiKey = tmbdApiKey else {throw NetworkError.dataMissing}
        
        var path:String
        
        if type == "trending" {
            path = "3/trending/\(media)/day"
        } else if type == "top_rated" {
            path = "3/\(media)/top_rated"
        } else {
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
