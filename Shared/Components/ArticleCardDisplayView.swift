//
//  ArticleCardDisplayView.swift
//  NewsApp
//
//  Created by Chris Guirguis on 10/12/21.
//

import SwiftUI

struct ArticleCardDisplayView: View {
    @ObservedObject var viewModel: ArticleCardDisplayViewModel
    var body: some View {
    ScrollView(){
        LazyVStack(spacing: 0, pinnedViews: [.sectionHeaders]){
//            let homePageGroups = viewModel.homePageResults.filter{$0.result != nil}
            ForEach(viewModel.articleGroups.indices, id: \.self){i in
                let articleGroup = viewModel.articleGroups[i]
                //                    Text("Result has - \(apiResult.result?.count ?? -1) articles")
                
//                    if let styleText = apiResult.cardsType,
//                       let style = StoryBlockCardViewModel.Style(rawValue: styleText){
                if articleGroup.alignment == .vertical {
                            verticalGroupComponent(articleGroup)
                            
                } else if articleGroup.alignment == .carousal {
                            carouselComponent(articleGroup)
                        }
                    
                }
            }
        }
    }
    
    func verticalGroupComponent(_ articlesGroup: ArticleCardDisplayViewModel.PreviewsAndDiplays) -> some View {
        VStack(spacing: 0){
            ForEach(articlesGroup.articles, id: \.id){preview in
                if let previewID = preview.id {
                    NavigationLink(destination: NavigationLazyView(ArticleView(viewModel: .init(articleID: previewID))) ){
                        StoryBlockCardView.init(viewModel: .init(articlePreview: preview, style: articlesGroup.style))
                    }
                } else if articlesGroup.style == .EmailSubscriptionDropCard{
                    StoryBlockCardView.init(viewModel: .init(articlePreview: preview, style: articlesGroup.style))
                }
            }
            
        }
    }
    
    func carouselComponent(_ articlesGroup: ArticleCardDisplayViewModel.PreviewsAndDiplays) -> some View {
        Section(
            content: {
                Group{
                    ScrollView(.horizontal, showsIndicators: false){
                        HStack(spacing: 10){
                            ForEach(articlesGroup.articles, id: \.id){preview in
                                if let previewID = preview.id {
                                    NavigationLink(destination: NavigationLazyView(ArticleView(viewModel: .init(articleID: previewID))) ){
                                        StoryBlockCardView.init(viewModel: .init(articlePreview: preview, style: articlesGroup.style))
                                    }
                                }
                            }
                        }.padding(.horizontal, 10)
                    }
                }
                .padding(.top)
                .background(Color.white)
                
            },
            header: {
                HStack(alignment: .top){
                    Text(articlesGroup.groupTitle ?? "Trends")
                        .font(.system(size: 20, weight: .semibold))
                    Spacer()
                    HStack{
                        Text("See All")
                        Image(systemName: "chevron.right")
                    }.font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.teal)
                        .embedInButton {
                            print("going to move forward")
                        }
                    
                }.padding()
                    .background(Color.white)
                
            })
    }
    
}

class ArticleCardDisplayViewModel: ObservableObject {
    
    enum CardAlignment: String, Codable {
        case vertical
        case carousal
    }
    struct PreviewsAndDiplays {
        var groupTitle: String?
        var articles: [ArticlePreview]
        var alignment: CardAlignment
        var style: StoryBlockCardViewModel.Style
    }
    
    @Published var articleGroups: [PreviewsAndDiplays]
    
    init(articleGroups: [PreviewsAndDiplays]){
    self.articleGroups = articleGroups
    }
}
