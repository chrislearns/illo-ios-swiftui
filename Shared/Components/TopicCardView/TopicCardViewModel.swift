//
//  TopicCardViewModel.swift
//  NewsApp
//
//  Created by Chris Guirguis on 10/7/21.
//

import SwiftUI
import SweetSimpleSwift

class TopicCardViewModel: ObservableObject {
    var topic: Topic
    var iconSystemName:String
    var buttonAction: (Topic) -> ()
    
    init(topic: Topic,
         iconsystemName: String,
         buttonAction: @escaping (Topic) -> ()){
        self.topic = topic
        self.iconSystemName = iconsystemName
        self.buttonAction = buttonAction
    }
    
}

//extension TopicCardViewModel {
//    static var dummy1: TopicCardViewModel = .init(topic: .dummy1, iconsystemName: "plus.diamond.fill") { _ in }
//    static var dummy2: TopicCardViewModel = .init(topic: .dummy2, iconsystemName: "plus.diamond.fill") { _ in }
//    static var dummy3: TopicCardViewModel = .init(topic: .dummy3, iconsystemName: "plus.diamond.fill") { _ in }
//    static var dummy4: TopicCardViewModel = .init(topic: .dummy4, iconsystemName: "plus.diamond.fill") { _ in }
//    static var dummy5: TopicCardViewModel = .init(topic: .dummy5, iconsystemName: "plus.diamond.fill") { _ in }
//}
