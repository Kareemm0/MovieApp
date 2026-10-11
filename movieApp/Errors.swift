//
//  Errors.swift
//  movieApp
//
//  Created by kareem mohamed  on 09/10/2026.
//

import Foundation


enum ApiConfigError : Error{
    case fileNotFound
    case dataLoadingFailed(underLyingError: Error)
    case decodingFailed(underLyingError: Error)
    
    
    var errorDescription: String? {
        switch self {
        case .fileNotFound: return "Api Configuration Not Found"
        case .dataLoadingFailed(underLyingError: let error ) :
            return "Failed To Load Data From Configuration file :  \(error.localizedDescription)"
            
        case .decodingFailed(underLyingError: let error) :
            return "Failed to decode data From Api Configuration file \(error.localizedDescription)"
       
        }
    }
}



enum NetworkError : Error , LocalizedError{
    case badRequestResponse(underlyingError: Error)
    case dataMissing
    case urlBuildFailed
    
    
    
    var errorDescription : String?{
        switch self {
        case .badRequestResponse(underlyingError: let error) :
            return "Faild to parse url response \(error.localizedDescription)"
        case .dataMissing :
            return "Missing Api Configuration"
            
          
        case .urlBuildFailed:
            return "Url Build Failed"
        }
    }
    
  
}
