//
//  ArticleViewModel.swift
//  NewsApp
//
//  Created by Chris Guirguis on 10/5/21.
//

import SwiftUI
import SweetSimpleSwift
import SwiftCodableManagement

class ArticleViewModel: ObservableObject {
    @Published var article: Article? = nil
    
    init(article: Article){
        self.article = article
    }
    
    init(articleID: String){
        //Some function to go find the real article bsed on a matching article id
        self.fetchFullArticle(id: articleID)
    }
    
    
    func fetchFullArticle(id: String){
        NetworkingService().simpleRequestToObject(
            type: ArticleDetailsResponseModel.self,
            urlString: "https://thesummit-the-summit-sandbox.cdn.arcpublishing.com/pf/api/v3/content/fetch/content-api?query=%7B%22_id%22:%22\(id)%22%7D&_website=the-summit") { object, url in
                guard let object = object else {
                    print("object failed to unwrap")
                    return
                }
                
                print("Full article loaded")
                if let headline = object.headlines { print("Headline - \(String(describing: headline.basic))") }
                if let content_elements = object.content_elements {
                    print("Contents Count - \(content_elements.count)")
                }
                do {
                self.article = try .init(model: object)
                } catch {
                    print("failed to unwrap article with custom initializer")
                }
                
//                self.article = object
                
                
                
                
            }
    }
}

