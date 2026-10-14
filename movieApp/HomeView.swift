//
//  HomeView.swift
//  movieApp
//
//  Created by kareem mohamed  on 08/10/2026.
//

import SwiftUI

struct HomeView: View {
    var herTextTitle = Constant.testTitleURL
    
    let viewModel = ViewModel()
    var body: some View {
            
        GeometryReader{ geo in
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
                        AsyncImage(url: URL(string: herTextTitle)){
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
                            Button{} label: {
                                Text(Constant.playString)
                                    .ghostButton()
                            }
                            Button{} label: {
                                Text(Constant.downloadString).ghostButton()
                            }
                        }
                        
                        HorizontalListView(titleHeader: Constant.trendingMoviesString , titles: viewModel.trendingMovies )
                        HorizontalListView(titleHeader: Constant.trendingTVString,
                                           titles: viewModel.trendingTV
                        )
                        HorizontalListView(titleHeader: Constant.topRatedMovieString , titles: viewModel.topRatedMovies)
                        HorizontalListView(titleHeader: Constant.topRatedTVString , titles: viewModel.topRatedTv)
                    }
                case .failre(let error):
                    Text("Error: \(error.localizedDescription)")
                }
                
                
                
             
            }.task {
                await viewModel.gettitles()
            }
        }
       
    }
}
#Preview {
    HomeView()
}
