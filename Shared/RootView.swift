//
//  RootView.swift
//  Shared
//
//  Created by Chris Guirguis on 10/5/21.
//

import SwiftUI
import SweetSimpleSwift

struct RootView: View {
    
    @ObservedObject var viewModel: RootViewModel
    
    var appState = AppState()
    
    var body: some View {
        NavigationView{
            TabView(selection: $viewModel.selection){
                HomeView(viewModel: .init(homePageResults: nil))
                    .tabItem{
                        TabItemView(text: "Home", systemName: "house")
                    }
                    .tag(RootViewModel.Tab.home)
                    
                MyNewsView(viewModel: .init())
                    .tabItem{
                        TabItemView(text: "My News", systemName: "newspaper")
                    }
                    .tag(RootViewModel.Tab.myNews)
                TopicListView(viewModel: .init(topics: nil, iconsystemName: "diamond.inset.filled", buttonAction: {_ in }))
                    .tabItem{
                        TabItemView(text: "Topics", systemName: "circle.hexagonpath")
                    }
                    .tag(RootViewModel.Tab.topics)
                MoreView(viewModel: .init())
                    .tabItem{
                        TabItemView(text: "More", systemName: "ellipsis")
                    }
                    .tag(RootViewModel.Tab.more)
            }
            .navigationBarTitleDisplayMode(.large)
            .navigationTitle(viewModel.selection.rawValue)
        }.accentColor(.lightBlue)
        
        .environmentObject(appState)
    }
}

