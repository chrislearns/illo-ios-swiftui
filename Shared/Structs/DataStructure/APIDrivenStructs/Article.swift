//
//  Article.swift
//  NewsApp
//
//  Created by Chris Guirguis on 10/5/21.
//

import Foundation
import SwiftUI
import SweetSimpleSwift

struct Article: Identifiable {
    func toPreview() -> ArticlePreview {
        .init(id: id, title: title, dateOfPublication: dateOfPublication, author: author.map{$0.toShallow()}, topic: topic, description: description, imageURL: imageURL)
    }
    
    enum Errors: String, Error {
        case faileToInitFromModel
    }
    
    init(
        id: String,
        title: String,
        description: String,
        dateOfPublication: Date,
        author: [Author],
        topic: Topic?,
        imageURL: String,
        articleContent: [ArticleContentComponent]
    ){
        self.id = id
        self.title = title
        self.dateOfPublication = dateOfPublication
        self.author = author
        self.topic = topic
        self.imageURL = imageURL
        self.articleContent = articleContent
        self.description = description
    }
    
    
    var id: String
    var title: String
    var description: String
    var dateOfPublication: Date
    var author: [Author]
    var topic: Topic?
    var imageURL: String
    var articleContent: [ArticleContentComponent]
    
    
    
    
    func finalContent(_ width: CGFloat) -> some View {
        VStack{
//            let articles = articleContent.condenseTextedItems()
            ForEach(articleContent.indices.sorted(), id: \.self){i in
                
                let contentPiece = articleContent[i]
                contentPiece.view(width)
                //                Text("\(contentPiece.type.rawValue)")
                
            }
        }
        
    }
    
    init(model: ArticleDetailsResponseModel) throws {
        guard let id = model._id else {
            print("failed to unwrap id - article");
            throw Errors.faileToInitFromModel
        }
        guard let title = model.headlines?.basic else {
            print("failed to unwrap title");
            throw Errors.faileToInitFromModel
        }
        guard let dateString = model.first_publish_date else {
            print("failed to unwrap date");
            throw Errors.faileToInitFromModel
        }
        guard let author = model.credits?.by else {
            print("failed to unwrap author");
            throw Errors.faileToInitFromModel
        }
        guard let section = model.taxonomy?.primary_section else {
            print("failed to unwrap topic/section")
            throw Errors.faileToInitFromModel
        }
        let topic = try Topic(model: section)
        
        guard let content = model.content_elements else {
            print("failed to unwrap content")
            throw Errors.faileToInitFromModel
        }
        
        guard let description = model.description?.basic else {
            print("failed to unwrap description")
            throw Errors.faileToInitFromModel
        }
        
        guard let imageURL = model.promo_items?.basic?.url else {
            print("failed to unwrap image URL");
            throw Errors.faileToInitFromModel
        }
              
//              print("assigning values")
        
        self.id = id
        self.imageURL = imageURL
        self.title = title
        self.topic = topic
        
        self.dateOfPublication = try dateString.iso8601withFractionalSecondsToDate()
        self.author = author.compactMap{model -> Author? in
            do {
                return try Author(model: model)
            } catch {
                return nil
            }
        }
        self.articleContent = content.compactMap{contentElement -> [ArticleContentComponent]? in
            
            do{
                return try contentElement.toArticleContentComponent()
            } catch {
                print("failed to unwrap article content component")
                return nil
            }
        }.flatMap{$0}
        self.description = description
    }
    
    
}




