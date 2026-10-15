//
//  ContentView.swift
//  movieApp
//
//  Created by kareem mohamed  on 08/10/2026.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView{
            Tab(
                Constant.homeString , systemImage: Constant.homeIcon
            ){
                HomeView()
            }
            Tab(
                Constant.upcomingString , systemImage: Constant.upconingIcon
            ){
                UpComningView()
            }
            Tab(
                Constant.searchString , systemImage: Constant.searchIcon
            ){
                SearchView()
            }
            Tab(
                Constant.downloadString , systemImage: Constant.downloadIcon
            ){
                DownloadView()
            }
        }
    }
    }


#Preview {
    ContentView()
}
