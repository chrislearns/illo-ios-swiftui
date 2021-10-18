//
//  SubtopicArticleListView.swift
//  NewsApp
//
//  Created by Chris Guirguis on 10/15/21.
//

import SwiftUI

struct SubtopicArticleListView: View {
    @ObservedObject var subtopic: Subtopic
    
    var body: some View {
        Group{
        if let articles = subtopic.articles {
            if articles.count > 0 {
            ArticleCardDisplayView(
                viewModel: .init(
                    articleGroups: [.init(
                        groupTitle: nil,
                        articles: articles.map{$0.toPreview()},
                        alignment: .vertical,
                        style: .StoryCard1)]))
            } else {
                Text("No articles in this subtopic")
            }
            
        } else {
            Text("Articles still loading")
        }
    }
            .tag(subtopic)
            
    }
}

//struct SubtopicArticleListView_Previews: PreviewProvider {
//    static var previews: some View {
//        SubtopicArticleListView()
//    }
//}
