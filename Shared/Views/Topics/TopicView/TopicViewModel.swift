//
//  TopicViewModel.swift
//  NewsApp
//
//  Created by Chris Guirguis on 10/7/21.
//

import SwiftUI
import SweetSimpleSwift
import SwiftCodableManagement

class TopicViewModel: ObservableObject {
    @Published var topic: Topic?
    @Published var currentSubtopic = Subtopic.blank
    init(topic: Topic){
        self.topic = topic
        self.fetchSubtopics()
    }
    
    func fetchSubtopics(){
        if let topic = topic {
            print("fetching subtopic - \(topic.name))")
            NetworkingService().simpleRequestToObject(
                
                type: TopicLandingResponseModel.self,
                urlString: "https://thesummit-the-summit-sandbox.cdn.arcpublishing.com/pf/api/v3/content/fetch/site-service-hierarchy?query=%7B%22sectionId%22:%22\(topic._id)%22%7D&_website=the-summit") { object, url in
                guard let object = object else {
                    print("object failed to unwrap")
                    return
                }
                
                do {
                    if let children = object.children {
                        print("\(object.children?.count ?? -1) subtopics loaded")
                        self.topic?.subtopics = try children.map{try Subtopic(model: $0, topicID: topic._id)}
                        if let first = self.topic?.subtopics?.first {
                            self.currentSubtopic = first
                        }
                    }
                } catch {
                    print("failed to unwrap subtopics from response")
                }
                
                
                
                
            }
        } else {
            print("could not fetch subtopics - topic was nil")
        }
    }
}

//extension TopicViewModel{
//    static var dummy1: TopicViewModel = .init(topic: .dummy1)
//}
