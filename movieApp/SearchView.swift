//
//  SearchView.swift
//  movieApp
//
//  Created by kareem mohamed  on 15/10/2026.
//

import SwiftUI

struct SearchView: View {
    @State private var searchByMovies = true
    @State private var searchText = ""
    private let viewModel = SearchViewModel()
    @State private var navigationPath = NavigationPath()

    var body: some View {
        NavigationStack(path: $navigationPath) {
            ScrollView
            {
                
                if let error = viewModel.errorMessage {
                    Text(error)
                        .foregroundStyle(.red)
                        .padding()
                        .background(.ultraThinMaterial)
                        .clipShape(.rect(cornerRadius: 10))
                }
                LazyVGrid(columns: [GridItem(),GridItem(),GridItem()]
                ){
                    ForEach(viewModel.searchTitles){
                        title in AsyncImage(url: URL(string: title.posterPath ?? "")){
                            image in image.resizable()
                                .scaledToFit()
                                .clipShape(
                                .rect(cornerRadius: 10)
                            )
                        }placeholder: {
                            ProgressView()
                        }.frame(
                            width: 120 , height: 200
                        )
                        .onTapGesture {
                            navigationPath.append(title)
                        }
                        
                    }
                }
            }
            .navigationTitle(
                searchByMovies ? Constant.movieSearchString : Constant.tvSearchString
            ).toolbar{
                ToolbarItem(
                    placement: .topBarTrailing) {
                        Button{
                            searchByMovies.toggle()
                            
                            Task{
                                await viewModel.getSearchTitles(by: searchByMovies ? "Movie" : "tv", for: searchText)
                            }
                            
                        }label: {
                            Image(systemName:  searchByMovies ? Constant.movieIconString : Constant.tvIconString)
                        }
                    }
            }.searchable(text: $searchText , prompt: searchByMovies ? Constant.moviePlaceHolderString : Constant.tvPlaceHolderString)
                .task(id : searchText) {
                    try? await Task.sleep(for: .milliseconds(500))
                    
                    if Task.isCancelled{
                        return
                    }
                    
                    await viewModel.getSearchTitles(by: searchByMovies ? "movie" : "tv", for: searchText)
                }
                .navigationDestination(for: Title.self) { title in
                    TitlesDetailsView(title: title)
                }
        }
    }
}

#Preview {
    SearchView()
}
