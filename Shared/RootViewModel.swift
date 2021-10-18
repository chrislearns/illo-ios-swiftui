//
//  RootViewModel.swift
//  NewsApp
//
//  Created by Chris Guirguis on 10/7/21.
//

import SwiftUI
import SweetSimpleSwift

class RootViewModel: ObservableObject {
    enum Tab: String {
        case home = "Home"
        case myNews = "My News"
        case topics = "Topics"
        case more = "More"
    }
    
    @Published var selection: Tab = .home
}
