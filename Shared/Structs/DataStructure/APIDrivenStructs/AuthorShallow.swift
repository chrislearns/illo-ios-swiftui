//
//  AuthorShallow.swift
//  NewsApp
//
//  Created by Chris Guirguis on 10/8/21.
//

import SwiftUI

struct AuthorShallow: Equatable, Hashable, AuthorType {
    
    enum Errors: String, Error {
        case faileToInitFromModel
    }
    
    
    var name: String?
    var username: String
    
    init(
        name: String?,
        username: String
    ){
        self.name = name
        self.username = username
    }
    
    
    
    init(model: AuthorInfo) throws {
        
        guard let id = model.id else {
            print("failed to unwrap id - shallow author");
            throw Errors.faileToInitFromModel
        }
           
        self.name = model.name
        self.username = id
    }
}
