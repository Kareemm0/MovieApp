//
//  DownloadView.swift
//  movieApp
//
//  Created by kareem mohamed  on 15/10/2026.
//

import SwiftUI
import SwiftData

struct DownloadView: View {
    
    @Query(sort: \Title.title) var savedTitles: [Title]
    var body: some View {
        NavigationStack{
            if savedTitles.isEmpty{
                Text("NO Downloads").padding().font(.title3).bold()
            } else{
                VerticalListView(titles: savedTitles , canDelete: true)
            }
        }
    }
}

#Preview {
    DownloadView()
}
