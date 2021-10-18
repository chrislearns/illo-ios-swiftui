//
//  SwiftUIView.swift
//  NewsApp
//
//  Created by Chris Guirguis on 10/5/21.
//

import SwiftUI

class StoryBlockCardViewModel: ObservableObject{
    enum Style: String, Codable {
        case StoryBlockCard1 = "StoryBlockCard-1"
        case StoryCard1 = "StoryCard-1"
        case Tile = "Tile"
        case EmailSubscriptionDropCard = "EmailSubscriptionDropCard"
        
        static func defaultValue(_ alignment: ArticleCardDisplayViewModel.CardAlignment) -> Style {
            switch alignment {
            case .vertical:
                return .StoryCard1
            case .carousal:
                return .Tile
            }
        }
    }
    
    
    
    var articlePreview: ArticlePreview
    var style: Style
    init(articlePreview: ArticlePreview, style: Style){
        self.articlePreview = articlePreview
        self.style = style
    }
}
    
