//
//  MyNewsViewModel.swift
//  NewsApp
//
//  Created by Chris Guirguis on 10/7/21.
//

import SwiftUI
import SweetSimpleSwift

class MyNewsViewModel: ObservableObject {
    enum Tab: String, Hashable, CaseIterable {
        case Following
        case Saved
    }
    
    var options: [Tab] = Tab.allCases
    @Published var selection:Tab = .Following
    
    
}

extension MyNewsViewModel {
    static var dummy: MyNewsViewModel = .init()
}
