//
//  Title.swift
//  movieApp
//
//  Created by kareem mohamed  on 08/10/2026.
//

import Foundation


struct APIObject : Decodable{
    var results :[Title] = []
}

struct Title : Decodable  , Identifiable{
    var id : Int?
    var title : String?
    var name : String?
    var overview : String?
    var posterPath: String?
    
    
    static var previewTitles = [
          Title(id: 1, title: "BeetleJuice", name: "BeetleJuice", overview: "A movie about BeetleJuice", posterPath: Constant.testTitleURL),
          Title(id: 2, title: "Pulp Fiction", name: "Pulp Fiction", overview: "A movie about Pulp Fiction", posterPath: Constant.testTitleURL2),
          Title(id: 3, title: "The Dark Knight", name: "The Dark Knight", overview: "A movie about the Dark Knight", posterPath: Constant.testTitleURL3)
      ]
}
