//
//  TopicCardView.swift
//  NewsApp
//
//  Created by Chris Guirguis on 10/7/21.
//

import SwiftUI
import SweetSimpleSwift

struct TopicCardView: View {
    
    @ObservedObject var viewModel: TopicCardViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12){
            HStack{
                Text(viewModel.topic.name)
                    .multilineTextAlignment(.leading)
                    .font(.system(size: 18, weight: .medium))
                    .foregroundColor(.illoGray)
                Spacer()
                Button(action: {viewModel.buttonAction(viewModel.topic)}){
                    Image(systemName: viewModel.iconSystemName)
                        .resizable()
                        .frame(width: 40, height: 40)
                        .foregroundColor(.lightBlue)
                }
            }
            
            if let siteDescription = viewModel.topic.siteDescription {
            Text(siteDescription)
                .multilineTextAlignment(.leading)
                .font(.system(size: 13, weight: .medium))
                .foregroundColor(.init(white: 0.3))
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .padding(.top)
        .padding(.bottom, 8)
    }
}

//struct TopicCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        ScrollView{
//            VStack(spacing: 1){
//                ForEach([TopicCardViewModel.dummy1,
//                         TopicCardViewModel.dummy2,
//                         TopicCardViewModel.dummy3,
//                         TopicCardViewModel.dummy4].indices, id: \.self){i in
//                    let topic = [TopicCardViewModel.dummy1,
//                                 TopicCardViewModel.dummy2,
//                                 TopicCardViewModel.dummy3,
//                                 TopicCardViewModel.dummy4][i]
//                    Group{TopicCardView(viewModel: topic)
//                        
//                    Divider()
//                    }.padding(.horizontal, 30)
//                }
//            }
//        }
//    }
//}
