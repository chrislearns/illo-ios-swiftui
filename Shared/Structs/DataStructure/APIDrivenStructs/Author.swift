//
//  Author.swift
//  NewsApp
//
//  Created by Chris Guirguis on 10/5/21.
//

import SwiftUI
import SweetSimpleSwift

protocol AuthorType {
    var name: String? { get }
}
struct Author: Hashable, Equatable, Codable, AuthorType {
    
    enum Errors: String, Error {
        case faileToInitFromModel
    }
    
    var name: String?
    var username: String
    var imageURL: String?
    var shortDescription: String
    var longDescription: String?
    
    func toShallow() -> AuthorShallow {
        .init(name: name, username: username)
    }
    
    
    init(
        name: String?,
        username:String,
        imageURL: String?,
        shortDescription: String,
        longDescription: String
    ){
        self.name = name
        self.username = username
        self.imageURL = imageURL
        self.shortDescription = shortDescription
        self.longDescription = longDescription
    }
    init(model: AuthorInfo) throws {
        guard let imageURL = model.additional_properties?.original?.image else {
            print("failed to unwrap image URL");
            throw Errors.faileToInitFromModel
        }
        
        guard let id = model._id else {
            print("failed to unwrap id - author");
            throw Errors.faileToInitFromModel
        }
        
        guard let bio = model.additional_properties?.original?.bio else {
            print("failed to unwrap bio");
            throw Errors.faileToInitFromModel
        }
        
        
        self.name = model.name
        self.imageURL = imageURL
        self.username = id
        self.shortDescription = bio
        self.longDescription = model.additional_properties?.original?.longBio
        
    }
}


