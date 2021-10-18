//
//  MyNewsView.swift
//  NewsApp
//
//  Created by Chris Guirguis on 10/5/21.
//

import SwiftUI
import SweetSimpleSwift

struct MyNewsView: View {
    
    
    
    @ObservedObject var viewModel: MyNewsViewModel
    
    var body: some View {
        VStack(spacing: 0){
            PageSegmentControllerView(viewModel: .init(
                options: viewModel.options,
                selection: $viewModel.selection,
                height: 45,
                indicatorCornerRadius: nil,
                style: .underline,
                selectedOptionBackgroundColor: .lightBlue,
                unselectedOptionBackgroundColor: .clear,
                selectedOptionForegroundColor: .lightBlue,
                unselectedOptionForegroundColor: .white
            ), selection: $viewModel.selection
            ).background(Color.illoGray)
            TabView(selection: $viewModel.selection){
                VStack(spacing: 0){
                    BannerView(
                        viewModel: .init(
                            title: "What interests you?".toText(),
                            subtitle: "Personalize this space by following the topics you like.".toText(),
                            buttonOrientation: .minorInlineButton,
                            buttonDetails: .init(
                                text: "DONE".toText().font(.system(size: 10, weight: .bold)),
                                action: {})))
                        .padding(.vertical)
                        .background(Color.init(white: 0.93))
                    TopicListView(viewModel: .init(topics: nil, iconsystemName: "plus.diamond", buttonAction: {_ in }))
                }
                ScrollView{
                    Text("saved")
                }.tag(MyNewsViewModel.Tab.Saved)
            }.tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        }
    }
}

struct MyNewsView_Previews: PreviewProvider {
    static var previews: some View {
        MyNewsView(viewModel: .dummy)
    }
}
