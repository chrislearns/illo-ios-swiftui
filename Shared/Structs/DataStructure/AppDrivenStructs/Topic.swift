//
//  Topic.swift
//  NewsApp
//
//  Created by Chris Guirguis on 10/7/21.
//

import SwiftUI
import SweetSimpleSwift

struct Topic: Hashable {
    enum Errors: String, Error {
        case failedToInitFromModel
    }
    
    var _id: String
    var name: String
    var shortDescription: String?
    var siteDescription: String?
    var subtopics: [Subtopic]?
    
    init(name: String,
         _id: String,
         shortDescription: String,
         siteDescription: String,
         subtopics: [Subtopic]? = nil
    ){
        self.name = name
        self.shortDescription = shortDescription
        self.siteDescription = siteDescription
        self.subtopics = subtopics
        self._id = _id
    }
    
    init(model: TopicResponse) throws {
        guard let name = model.name else { throw Errors.failedToInitFromModel }
        guard let _id = model._id else { throw Errors.failedToInitFromModel }
        self._id = _id
        self.name = name
        self.shortDescription = model.site?.short_description
        self.siteDescription = model.site?.site_description
    }
    
    init(model: Sections) throws {
        guard let name = model.name else { throw Errors.failedToInitFromModel }
        guard let _id = model._id else { throw Errors.failedToInitFromModel }
        self._id = _id
        self.name = name
//        self.shortDescription = model.description
        self.siteDescription = model.description
    }
}

