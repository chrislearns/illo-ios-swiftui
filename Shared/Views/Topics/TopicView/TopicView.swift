//
//  TopicView.swift
//  NewsApp
//
//  Created by Chris Guirguis on 10/7/21.
//

import SwiftUI
import SweetSimpleSwift

struct TopicView: View {
    
    @ObservedObject var viewModel: TopicViewModel
    
    var body: some View {
        Group{
            if let topic = viewModel.topic{
                VStack{
                    VStack{
                        if let shortDescription = topic.shortDescription {
                            Text(shortDescription)
                                .multilineTextAlignment(.center)
                                .foregroundColor(.white)
                                .padding(.horizontal)
                                .padding(.bottom, 12)
                        }
                        Button(action: {print(topic.subtopics?.count ?? -1)}){
                            HStack{
                                Text("Follow Topic".uppercased())
                                Image(systemName: "plus")
                            }
                            .font(.system(size: 10, weight: .bold))
                            .foregroundColor(.black)
                            .padding(.vertical, 10)
                            .padding(.horizontal, 10)
                            .background(Color.lightBlue)
                        }
                        .padding(.bottom, 20)
                    }
                    .frame(maxWidth: .infinity)
                    .background(Color.illoGray)
                    if let subtopics = topic.subtopics{
                        ScrollingSegmentControllerView(
                            viewModel: .init(
                                options: subtopics,
                                selection: $viewModel.currentSubtopic,
                                height: 20,
                                style: .underline,
                                selectedOptionForegroundColor: .lightBlue),
                            selection: $viewModel.currentSubtopic)
                        
                        TabView(selection: $viewModel.currentSubtopic){
                            ForEach(subtopics, id: \.self){subtopic in
                                
                                SubtopicArticleListView(subtopic: subtopic)
                                //                                ArticleCardDisplayView(
                                //                                    viewModel: .init(
                                //                                        articleGroups: [.init(
                                //                                            groupTitle: nil,
                                //                                            articles: subtopic.articles?.map{$0.toPreview()} ?? [],
                                //                                            alignment: .vertical,
                                //                                            style: .StoryCard1)]))
                                
                                
                            }
                        }.tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                    } else {
                        Spacer()
                    }
                }
                .navigationTitle(Text(topic.name))
            } else {
                Text("Loading topic")
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

