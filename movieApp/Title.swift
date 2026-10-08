//
//  Title.swift
//  movieApp
//
//  Created by kareem mohamed  on 08/10/2026.
//

import Foundation


struct APIObject : Decodable{
    var result :[Title] = []
}

struct Title : Decodable  , Identifiable{
    var id : Int?
    var title : String?
    var name : String?
    var overview : String?
    var posterPath: String?
}
