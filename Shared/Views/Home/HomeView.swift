//
//  HomeView.swift
//  NewsApp
//
//  Created by Chris Guirguis on 10/5/21.
//

import SwiftUI
import SweetSimpleSwift



struct HomeView: View {
    
    @ObservedObject var viewModel: HomeViewModel
    
    var body: some View {
        
        
        VStack(spacing: 0){
            Text(Date.getSalutation())
                .foregroundColor(.white)
                .padding(.top, 8)
                .padding(.leading, 10)
                .padding(.bottom, 12)
            
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.system(size: 19, weight: .semibold))
                .foregroundColor(.white).background(Color.illoGray)
            ArticleCardDisplayView(
                viewModel:
                        .init(articleGroups:
                                viewModel.homePageResults.toArticleGroups()
                             )
            )
        }
        
        .background(Color.illoTintedGray)
        
    }
    
//    func verticalGroupComponent(_ apiResult: StoryCardsAPIResponseModel, style: StoryBlockCardViewModel.Style) -> some View {
//        Group{
//            if let results = apiResult.result {
//                ForEach(results.toArticlePreview(), id: \.id){preview in
//                    NavigationLink(destination: NavigationLazyView(ArticleView(viewModel: .init(articlePreview: preview))) ){
//                        StoryBlockCardView.init(viewModel: .init(articlePreview: preview, style: style))
//                    }
//                    
//                }
//            }
//        }
//    }
//    
//    func carouselComponent(_ apiResult: StoryCardsAPIResponseModel, style: StoryBlockCardViewModel.Style) -> some View {
//        Section(
//            content: {
//                Group{
//                    if let results = apiResult.result {
//                        
//                            
//                            ScrollView(.horizontal, showsIndicators: false){
//                                HStack(spacing: 10){
//                                    ForEach(results.toArticlePreview(), id: \.id){preview in
//                                        NavigationLink(destination: NavigationLazyView(ArticleView(viewModel: .init(articlePreview: preview))) ){
//                                            StoryBlockCardView.init(viewModel: .init(articlePreview: preview, style: style))
//                                        }
//                                    }
//                                }.padding(.horizontal, 10)
//                            }
//                        
//                    }
//                }
//                .padding(.top)
//                .background(Color.white)
//                
//            },
//            header: {
//                HStack(alignment: .top){
//                    Text(apiResult.title ?? "Trends")
//                        .font(.system(size: 20, weight: .semibold))
//                    Spacer()
//                    HStack{
//                        Text("See All")
//                        Image(systemName: "chevron.right")
//                    }.font(.system(size: 14, weight: .semibold))
//                        .foregroundColor(.teal)
//                        .embedInButton {
//                            print("going to move forward")
//                        }
//                    
//                }.padding()
//                    .background(Color.white)
//                
//            })
//    }
}

//struct HomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView(viewModel: .blank)
//    }
//}

struct NavigationLazyView<Content: View>: View {
    let build: () -> Content
    init(_ build: @autoclosure @escaping () -> Content) {
        self.build = build
    }
    var body: Content {
        build()
    }
}
