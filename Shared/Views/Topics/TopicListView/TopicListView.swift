//
//  TopicListViewModel.swift
//  NewsApp
//
//  Created by Chris Guirguis on 10/5/21.
//

import SwiftUI
import SweetSimpleSwift

struct TopicListView: View {
    
    @ObservedObject var viewModel: TopicListViewModel
    
    var body: some View {
        ScrollView{
            VStack(spacing: 1){
                ForEach(viewModel.topics, id: \.self){topic in
                    Group{
                        NavigationLink(destination: {
                            NavigationLazyView(TopicView(viewModel: .init(topic: topic)))
                        }){
                            TopicCardView(
                                viewModel: .init(
                                    topic: topic,
                                    iconsystemName: viewModel.iconSystemName,
                                    buttonAction: viewModel.buttonAction))
                        }
                        Divider()
                    }.padding(.horizontal, 30)
                }
            }
        }
    }
}

