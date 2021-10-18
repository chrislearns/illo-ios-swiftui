//
//  ArticlePreview.swift
//  NewsApp
//
//  Created by Chris Guirguis on 10/5/21.
//

import SwiftUI
import SwiftCodableManagement
import SweetSimpleSwift

struct ArticlePreview: Identifiable, Equatable, Hashable {
    enum Errors: String, Error {
        case failedToInitFromResult
    }
    
    var id: String?
    var title: String
    var dateOfPublication: Date?
    var author: [AuthorShallow]?
    var topic: Topic?
    var description: String
    var imageURL: String
    
    init(
        id: String,
        title: String,
        dateOfPublication: Date?,
        author: [AuthorShallow]?,
        topic: Topic?,
        description: String,
        imageURL: String
    ){
        self.id = id
        self.title = title
        self.dateOfPublication = dateOfPublication
        self.author = author
        self.topic = topic
        self.description = description
        self.imageURL = imageURL
    }
    
    init(result: Results) throws {
        guard let title = result.headline else {
            print("failed to unwrap title");
            throw Errors.failedToInitFromResult
        }
        
//        guard let author = result.by else {
//            print("failed to unwrap author");
//            throw Errors.failedToInitFromResult
//        }
        guard let section = result.primary_section else {
            print("failed to unwrap topic/section")
            throw Errors.failedToInitFromResult
        }
        let topic = try Topic(model: section)
        
        
        guard let description = result.description else {
            print("failed to unwrap description");
            throw Errors.failedToInitFromResult
        }
        
        guard let imageURL = result.img?.url else {
            print("failed to unwrap image URL");
            throw Errors.failedToInitFromResult
        }
              
        
        if let dateString = result.publish_date {
            do {
                self.dateOfPublication = try dateString.iso8601withFractionalSecondsToDate()
            } catch {
                print("date unwrappable")
            }
        }
        
        self.imageURL = imageURL
        self.title = title
        self.topic = topic
        self.description = description
        
        
        self.author = result.by?.compactMap{model -> AuthorShallow? in
            do {
                return try AuthorShallow(model: model)
            } catch {
                return nil
            }
        }
        
        if let id = result._id {
            self.id = id
        } else if let id = result.id {
            self.id = id
        } else {
            print("no id - article preview");
//            throw Errors.failedToInitFromResult
        }
        
        
    }
}


