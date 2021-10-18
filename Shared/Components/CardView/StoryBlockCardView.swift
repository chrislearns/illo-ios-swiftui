//
//  StoryBlockCardView.swift
//  NewsApp
//
//  Created by Chris Guirguis on 10/5/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct StoryBlockCardView: View {
    @StateObject var viewModel: StoryBlockCardViewModel
    
    var body: some View {
        switch viewModel.style {
        case .StoryBlockCard1:
            StoryBlockCard1View
        case .StoryCard1:
            StoryCard1View
        case .Tile:
            TileView
        case .EmailSubscriptionDropCard:
            EmailSubscriptionCard
        }
    }
    
    var StoryBlockCard1View: some View {
        VStack{
            componentImage()
            Group{
                VStack(alignment: .leading, spacing: 10){
                    componentTopic(.init(white: 0.8))
                    componentTitle(.white)
                    componentDescription(.init(white: 0.8))
                    componentAuthorsAndDate(.init(white: 0.8))
                    HStack{
                        componentButtons
                        Spacer()
                    }
                }
                
                .padding(.vertical, 8)
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(.init(white: 0.8))
                .font(.system(size: 14, weight: .regular))
            }.padding(.horizontal, 10)
        }
        .padding(.bottom)
    }
    
    var StoryCard1View: some View {
        VStack(spacing: 0){
            VStack{
                Group{
                    componentTitle(.illoGray)
                        .padding(.top, 10)
                }.padding(.horizontal, 10)
                componentImage()
                Group{
                    VStack(alignment: .leading, spacing: 10){
                        componentTopic(.illoGray)
                        
                        componentDescription(.illoGray)
                        
                        HStack{
                            componentAuthorsAndDate(.illoGray)
                            Spacer()
                            componentButtons
                        }
                        
                    }
                    
                    .padding(.vertical, 8)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(.init(white: 0.8))
                    .font(.system(size: 14, weight: .regular))
                }.padding(.horizontal, 10)
            }
            
            .padding(.bottom)
            .background(Color.white)
            Rectangle()
                .foregroundColor(.init(white: 0.8))
                .frame(height: 1)
                .padding(.horizontal)
                .padding(.bottom)
                .background(Color.white)
        }
    }
    
    var TileView: some View {
        VStack(alignment: .leading){
            
            componentImage(.fill)
                .frame(height: 90)
                .frame(width: 160)
                .clipped()
                .padding(.bottom, 10)
            
            componentTopic(.init(white: 0.6))
                .padding(.bottom, 10)
            componentTitle(.black, font: .system(size: 13, weight: .semibold))
            Spacer()
        }
        .frame(width: 160)
        .frame(height: 250)
            
    }
    
    var EmailSubscriptionCard: some View {
        EmailSubscriptionView(
            header: "The Drop AM/PM",
            title: viewModel.articlePreview.title,
            subtitle: viewModel.articlePreview.description,
            imageURL: viewModel.articlePreview.imageURL
        )
    }
    
    enum ScalingMethod {
        case fit
        case fill
    }
    
    
    
    
    
    func componentImage(_ scaling: ScalingMethod? = nil) -> some View{
        
        WebImage(url: URL(string: viewModel.articlePreview.imageURL))
            // Supports options and context, like `.delayPlaceholder` to show placeholder only when error
            .onSuccess { image, data, cacheType in
                // Success
                // Note: Data exist only when queried from disk cache or network. Use `.queryMemoryData` if you really need data
            }
            .resizable() // Resizable like SwiftUI.Image, you must use this modifier or the view will use the image bitmap size
            .placeholder(Image(systemName: "photo")) // Placeholder Image
            // Supports ViewBuilder as well
            .placeholder {
                Rectangle().foregroundColor(.gray)
            }
            .indicator(.activity) // Activity Indicator
            .transition(.fade(duration: 0.5)) // Fade Transition with duration
            .if(scaling == .fit) {
                $0.scaledToFit()
            }
            .if(scaling == .fill) {
                $0.scaledToFill()
            }
            .if(scaling == nil) {
                $0.scaledToFit()
            }
            
            
    }
    
    func componentTitle(
        _ color: Color? = nil,
        font: Font? = nil
    ) -> some View {
        Text(viewModel.articlePreview.title)
            .font(font ?? .system(size: 23, weight: .semibold))
            .foregroundColor(color)
            .multilineTextAlignment(.leading)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    func componentTopic(_ color: Color? = nil) -> some View {
        Group{
            if let topic = viewModel.articlePreview.topic {
                Text(topic.name.uppercased())
                    .foregroundColor(color)
                    .font(.system(size: 13, weight: .semibold))
                    .multilineTextAlignment(.leading)
            } else {
                EmptyView()
            }
        }
    }
    
    var componentButtons: some View {
        Group{
            Image(systemName: "square.and.arrow.up")
            Image(systemName: "ellipsis")
        }
        .font(.system(size: 17))
        .foregroundColor(.teal)
    }
    
    func componentDescription(_ color: Color? = nil) -> some View {
        Text(viewModel.articlePreview.description)
            .foregroundColor(color)
            .multilineTextAlignment(.leading)
    }
    
    func componentAuthorsAndDate(_ color: Color? = nil) -> some View {
        Group{
            Text(viewModel.articlePreview.author?.nameList() ?? "") + Text(" • ") + Text(viewModel.articlePreview.dateOfPublication?.writtenOut ?? "")
        }.foregroundColor(color)
    }
}

