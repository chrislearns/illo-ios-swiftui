//
//  AppearanceHelper.swift
//  NewsApp
//
//  Created by Chris Guirguis on 10/6/21.
//

import SwiftUI
import SweetSimpleSwift

struct AppearanceHelper{
    static func setup(){
        
            let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithOpaqueBackground()
        tabBarAppearance.backgroundColor = Color.illoGray.uiColor
           
        
        
        
        UITabBar.appearance().standardAppearance = tabBarAppearance
        if #available(iOS 15.0, *) {
            UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        }
        UITabBar.appearance().unselectedItemTintColor = .init(white: 0.8, alpha: 1)
        UITabBar.appearance().isTranslucent = false
        
        
        
        
        
        let appearance = UINavigationBarAppearance()
        appearance.shadowColor = .clear
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .init(white: 0.1, alpha: 1)
        appearance.largeTitleTextAttributes = [.foregroundColor: Color.white.uiColor]
        appearance.titleTextAttributes = [.foregroundColor: Color.lightBlue.uiColor]
    
        
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().standardAppearance = appearance
        
        
    }
}
