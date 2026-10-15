//
//  VerticalListView.swift
//  movieApp
//
//  Created by kareem mohamed  on 15/10/2026.
//

import SwiftUI

struct VerticalListView: View {
    
    var titles: [Title]
    var body: some View {
        List(titles){
            title in
            
            NavigationLink{
                TitlesDetailsView(title: title)
            }label: {
                AsyncImage(url: URL(string: title.posterPath ?? "")
                ) {
                    image in HStack {
                        image
                            .resizable()
                            .scaledToFit()
                            .clipShape(.rect(cornerRadius: 10))
                            .padding(5)
                        
                        Text((title.name ?? title.title) ?? "").font(.system(size: 14)).bold()
                    }
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 150)
            }
          
        }
    }
}

#Preview {
    VerticalListView(titles: Title.previewTitles)
}
