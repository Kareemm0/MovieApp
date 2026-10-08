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
                Text(Constant.upcomingString )
            }
            Tab(
                Constant.searchString , systemImage: Constant.searchIcon
            ){
                Text(Constant.searchString)
            }
            Tab(
                Constant.downloadString , systemImage: Constant.downloadIcon
            ){
                Text(Constant.downloadString)
            }
        }
    }
}

#Preview {
    ContentView()
}
