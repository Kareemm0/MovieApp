//
//  movieAppApp.swift
//  movieApp
//
//  Created by kareem mohamed  on 08/10/2026.
//

import SwiftUI
import SwiftData

@main
struct movieAppApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }.modelContainer(for: Title.self)
    }
}
