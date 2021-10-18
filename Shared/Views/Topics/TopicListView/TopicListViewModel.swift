//
//  TopicListViewModel.swift
//  NewsApp
//
//  Created by Chris Guirguis on 10/7/21.
//

import SwiftUI
import SweetSimpleSwift
import SwiftCodableManagement

class TopicListViewModel: ObservableObject {
    @Published var topics: [Topic]
    
    var iconSystemName:String
    var buttonAction: (Topic) -> ()
    
    init(topics: [Topic]?,
         iconsystemName: String,
         buttonAction: @escaping (Topic) -> ()){
        
        
        self.iconSystemName = iconsystemName
        self.buttonAction = buttonAction
        
        if let topics = topics {
            self.topics = topics
        } else {
            self.topics = []
            self.fetchAllSubtopics()
        }
    }
    
    func fetchAllSubtopics(){
        NetworkingService().simpleRequestToObject(
            type: AllTopicsResponseModel.self,
            urlString: "https://thesummit-the-summit-sandbox.cdn.arcpublishing.com/pf/api/v3/content/fetch/site-service-hierarchy?query=%7B%22hierarchy%22:%22default%22%7D&_website=the-summit&filter=%7Bchildren%20%7B_id,name,site%7Bcolor,site_description,short_description%7D%7D%7D") { object, url in
                guard let object = object else {
                    print("object failed to unwrap")
                    return
                }
                
                do {
                if let children = object.children {
                    print("\(object.children?.count ?? -1) topics loaded")
                    self.topics = try children.map{try Topic(model: $0)}
                }
                } catch {
                    print("failed to unwrap topics from response")
                }
                
            }
    }
    
}


//extension TopicListViewModel {
//    static var dummy1: TopicListViewModel = .init(topics: Topic.dummyTopics, iconsystemName: "plus.diamond", buttonAction: {_ in })
//    static var dummy2: TopicListViewModel = .init(topics: Topic.dummyTopics, iconsystemName: "diamond.inset.filled", buttonAction: {_ in })
//}
