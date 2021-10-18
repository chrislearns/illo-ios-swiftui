//
//  Subtopic.swift
//  NewsApp (iOS)
//
//  Created by Chris Guirguis on 10/11/21.
//

import SwiftUI
import SwiftCodableManagement

class Subtopic: Hashable, CustomStringConvertible, ObservableObject{
    
    static func == (lhs: Subtopic, rhs: Subtopic) -> Bool {
        lhs._id == rhs._id &&
        lhs.topicID == rhs.topicID &&
        lhs.name == rhs.name &&
        lhs.color == rhs.color &&
        lhs.siteDescription == rhs.siteDescription &&
        lhs.shortDescription == rhs.shortDescription
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self._id)
        hasher.combine(self.topicID)
        hasher.combine(self.name)
        hasher.combine(self.color)
        hasher.combine(self.siteDescription)
        hasher.combine(self.shortDescription)
        
    }
    var description: String { name }
    
    enum Errors: String, Error {
        case faileToInitFromModel
    }
    
    let _id: String
    let topicID: String
    let name: String
    let color: String?
    let siteDescription: String?
    let shortDescription: String?
    @Published var articles: [Article]?
    
    init(
        _id: String,
        topicID: String,
        name: String,
         color: String?,
         siteDescription: String?,
         shortDescription: String?,
         articles: [Article]?
    ){
        self._id = _id
        self.topicID = topicID
        self.name = name
        self.color = color
        self.siteDescription = siteDescription
        self.shortDescription = shortDescription
        self.articles = articles
    }
    
    init(model: SubtopicDetailsModel, topicID: String) throws {
        guard let name = model.name else {
            print("failed to unwrap name");
            throw Errors.faileToInitFromModel
        }
        
        guard let id = model._id else {
            print("failed to unwrap id - subtopic");
            throw Errors.faileToInitFromModel
        }
        
        self._id = id
        self.topicID = topicID
        self.name = name
        self.color = model.site?.color
        self.shortDescription = model.site?.short_description
        self.siteDescription = model.site?.site_description
        fetchArticlesInSubtopic()
    }
    
    func fetchArticlesInSubtopic(){
        NetworkingService().simpleRequestToObject(
            type: SubtopicResponseModel.self,
            urlString: "https://thesummit-the-summit-sandbox.cdn.arcpublishing.com/pf/api/v3/content/fetch/story-feed-query?query=%7B%22query%22:%22type:story%20AND%20subtype:standard%20AND%20(taxonomy.primary_section._id:%5C%22\(_id)%5C%22)%22,%22size%22:10,%22offset%22:0%7D&_website=the-summit") { object, url in
                guard let object = object else {
                    print(url)
                    print("object failed to unwrap")
                    return
                }
                
                if let results = object.content_elements {
//                    print("\(results.count) articles loaded - \(self._id)")
                    self.articles = results.compactMap{thisModel -> Article? in
                        do {
                            return try Article(model: thisModel)
                        } catch {
                            print("failed to unwrap articles from response")
                            return nil
                            
                        }
                    }
                }
                
            }
    }

    
    
}

extension Subtopic {
    static var blank: Subtopic = .init(
        _id: "",
        topicID: "",
        name: "",
        color: nil,
        siteDescription: nil,
        shortDescription: nil,
        articles: nil)
}
