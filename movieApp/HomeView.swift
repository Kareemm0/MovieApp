//
//  HomeView.swift
//  movieApp
//
//  Created by kareem mohamed  on 08/10/2026.
//

import SwiftUI

struct HomeView: View {
    
    let viewModel = ViewModel()
    @State private var titleDetailsPath = NavigationPath()
    var body: some View {
        
        NavigationStack(path: $titleDetailsPath) {
            GeometryReader
            { geo in
                ScrollView(.vertical){
                    switch viewModel.homeStatus {
                    case .notStarted:
                        EmptyView()
                    case .fetching:
                        ProgressView().frame(
                            width: geo.size.width ,height: geo.size.height
                        )
                    case .success:
                        LazyVStack{
                            AsyncImage(url: URL(string: viewModel.heroTitle.posterPath ?? "")){
                                image in image.resizable().scaledToFit().overlay{
                                    LinearGradient(
                                        stops: [Gradient.Stop(color: .clear, location: 0.8) ,
                                                Gradient.Stop(color: .gridant, location: 1)
                                               ],
                                        startPoint: .top,
                                        endPoint: .bottom)
                                }
                            } placeholder: {
                                ProgressView()
                            }.frame(width: geo.size.width , height: geo.size.height * 0.85)
                            HStack{
                                Button{
                                    titleDetailsPath.append(viewModel.heroTitle)
                                } label: {
                                    Text(Constant.playString)
                                        .ghostButton()
                                }
                                Button{} label: {
                                    Text(Constant.downloadString).ghostButton()
                                }
                            }
                            
                            HorizontalListView(titleHeader: Constant.trendingMoviesString , titles: viewModel.trendingMovies ){
                                title in titleDetailsPath.append(title)
                            }
                            HorizontalListView(titleHeader: Constant.trendingTVString,
                                               titles: viewModel.trendingTV
                            ){
                                title in titleDetailsPath.append(title)
                            }
                            HorizontalListView(titleHeader: Constant.topRatedMovieString , titles: viewModel.topRatedMovies){
                                title in titleDetailsPath.append(title)
                            }
                            HorizontalListView(titleHeader: Constant.topRatedTVString , titles: viewModel.topRatedTv){
                                title in titleDetailsPath.append(title)
                            }
                        }
                       
                    case .failre(let error):
                        Text("Error: \(error.localizedDescription)")
                    }
                    
                    
                    
                    
                }.task {
                    await viewModel.gettitles()
                } .navigationDestination(for: Title.self){
                    title in
                    TitlesDetailsView(title: title)
                }
            }
            
        }
    }
}
#Preview {
    HomeView()
}
