//
//  NewsAppApp.swift
//  Shared
//
//  Created by Chris Guirguis on 10/5/21.
//

import SwiftUI

@main
struct NewsAppApp: App {
    
    init(){
        AppearanceHelper.setup()
    }
    var body: some Scene {
        WindowGroup {
            RootView(viewModel: .init())
        }
    }
}
