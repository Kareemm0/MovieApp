//
//  HomeView.swift
//  movieApp
//
//  Created by kareem mohamed  on 08/10/2026.
//

import SwiftUI

struct HomeView: View {
    var herTextTitle = Constant.testTitleURL
    var body: some View {
            
        GeometryReader{ geo in
            ScrollView(.vertical){
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
                    
                    HorizontalListView(titleHeader: Constant.trendingMoviesString)
                    HorizontalListView(titleHeader: Constant.trendingTVString)
                    HorizontalListView(titleHeader: Constant.topRatedMovieString)
                    HorizontalListView(titleHeader: Constant.topRatedTVString)
                }
            }
        }
       
    }
}
#Preview {
    HomeView()
}
