//
//  HomeViewModel.swift
//  NewsApp
//
//  Created by Chris Guirguis on 10/5/21.
//

import SwiftUI
import SweetSimpleSwift
import SwiftCodableManagement

class HomeViewModel: ObservableObject {
    @Published var homePageResults: [StoryCardsAPIResponseModel] = []
    
    init(homePageResults: [StoryCardsAPIResponseModel]?){
        
        if let results = homePageResults{
            self.homePageResults = results
        } else {
            self.fetchHomePageResults()
        }
    }
    
    func fetchHomePageResults(){
        NetworkingService().simpleRequestToObject(
            type: [StoryCardsAPIResponseModel].self,
            urlString: "https://thesummit-the-summit-sandbox.cdn.arcpublishing.com/homepage-mobile/?_webiste=the-summit&outputType=json") { object, url in
                guard let object = object else {
                    print("object failed to unwrap")
                    return
                }
                
                print("Home page loaded \(object.count) results")
                
                self.homePageResults = object
            }
    }
    
}


extension HomeViewModel {
//    static var dummy: HomeViewModel = .init(articlePreviews: [.dummy1, .dummy2, .dummy3])
    static var blank: HomeViewModel = .init(homePageResults: [])
}
