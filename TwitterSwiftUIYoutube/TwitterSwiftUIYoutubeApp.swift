//
//  TwitterSwiftUIYoutubeApp.swift
//  TwitterSwiftUIYoutube
//
//  Created by Айдана Шарипбай on 10.06.2022.
//

import SwiftUI
import Firebase

@main
struct TwitterSwiftUIYoutubeApp: App {
    
    @StateObject var viewModel = AuthViewModel()
    
    init(){
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationView{
                  ContentView()
            }
            .environmentObject(viewModel)
        }
    }
}
