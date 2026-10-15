//
//  HorizontalListView.swift
//  movieApp
//
//  Created by kareem mohamed  on 08/10/2026.
//

import SwiftUI

struct HorizontalListView: View {
    let titleHeader : String
    var titles : [Title]
    let onSelect :(Title) -> Void
    var body: some View {
        VStack( alignment: .leading, ){
            Text(titleHeader).font(.title)
            
            ScrollView(.horizontal){
                LazyHStack {
                    ForEach(titles){
                        title in AsyncImage(url: URL(string: title.posterPath ?? "")){
                            image in image.resizable().scaledToFit().clipShape(RoundedRectangle(cornerRadius: 16))
                        } placeholder: {
                            ProgressView()
                        }.frame(width: 120 , height: 200).onTapGesture {
                            onSelect(title)
                        }
                    }
                }
            }
        }.frame(height: 250).padding(16)
    }
}

#Preview {
    HorizontalListView(titleHeader:  Constant.trendingMoviesString , titles: Title.previewTitles){
        title in 
    }
}
