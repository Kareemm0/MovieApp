//
//  UpComningView.swift
//  movieApp
//
//  Created by kareem mohamed  on 15/10/2026.
//

import SwiftUI

struct UpComningView: View {
    
    let viewModel = ViewModel()
    var body: some View {
        NavigationStack {
            GeometryReader
            {geo in
                switch viewModel.upcomingStatus{
                case .notStarted: EmptyView()
                case .fetching : ProgressView().frame(width: geo.size.width , height: geo.size.height)
                case .failre(let underlyingError):
                    Text(underlyingError.localizedDescription)
                case .success :
                    VerticalListView(titles: viewModel.upcomingMovies)
                }
            }.task {
                await viewModel.getUpcomingMovies()
            }
        }
    }
}

#Preview {
    UpComningView()
}
