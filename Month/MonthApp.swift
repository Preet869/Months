//
//  MonthApp.swift
//  Month
//
//  Created by Preet Dhillon on 29/10/2024.
//

import SwiftUI

@main
struct MonthApp: App {
    @StateObject private var appViewModel = AppViewModel()

    var body: some Scene {
        WindowGroup {
            if appViewModel.session != nil {
                ContentView()
                    .environmentObject(appViewModel)
            } else {
                AuthView()
            }
        }
    }
}
