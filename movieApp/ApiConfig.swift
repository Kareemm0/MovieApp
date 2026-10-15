//
//  ApiConfig.swift
//  movieApp
//
//  Created by kareem mohamed  on 08/10/2026.
//

import Foundation


struct ApiConfig : Decodable{
    let tmdbBaseURL : String
    let tmdbAPIKey : String
    let youtubeBaseURL: String
    let youtubeApiKey: String
    let youtubeSearchURL : String
    
    static let shared : ApiConfig? = {
        do{
            return try loadConfig()
        }catch{
            print("Faild To Load file Config \(error.localizedDescription)")
            return nil 
        }
    }()
    
    
    private static func loadConfig() throws -> ApiConfig {
    
        guard let url = Bundle.main.url(forResource: "ApiConfig", withExtension: "json") else {
            throw ApiConfigError.fileNotFound
        }
        
        do{
           let data = try Data(contentsOf: url)
            return try JSONDecoder().decode(ApiConfig.self, from: data)
        }catch let error as DecodingError{
            throw ApiConfigError.decodingFailed(underLyingError: error)
        } catch {
            throw ApiConfigError.dataLoadingFailed(underLyingError: error)
        
        }
    }
    }

