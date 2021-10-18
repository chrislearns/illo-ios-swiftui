//
//  AuthorBriefDetailsView.swift
//  NewsApp
//
//  Created by Chris Guirguis on 10/6/21.
//

import SwiftUI
import SweetSimpleSwift
import SDWebImageSwiftUI

struct AuthorBriefDetailsView: View {
    @ObservedObject var viewModel: AuthorBriefDetailsViewModel
    
    var body: some View {
        VStack{
            Spacer().frame(height: 40)
            HStack(alignment: .top){
                Group{
                    if let authorImageURL = viewModel.author.imageURL{
                        WebImage(url: URL(string: authorImageURL))
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
                            .scaledToFit()
                            .mask(Circle())
                    } else {
                        Image(systemName: "person.crop.circle")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.init(white: 0.9))
                    }
                }.frame(width: 40, height: 40)
                VStack(alignment: .leading){
                    if let name = viewModel.author.name {
                    Text("By " + name)
                            .font(.system(size: 18, weight: .medium))
                    }
                        
                    Text(viewModel.author.longDescription ?? viewModel.author.shortDescription)
                        .font(.system(size: 14, weight: .regular))
                        .foregroundColor(.init(white: 0.4))
                    
                }.frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.horizontal, 25)
            Spacer().frame(height: 30)
            Button(action: {}){
                Text("VIEW PROFILE")
                    .font(.system(size: 10, weight: .semibold))
                    .foregroundColor(.black)
                    .padding(.horizontal, 15)
                    .frame(height: 40)
                    .background(
                        Rectangle()
                            .stroke(Color.black, lineWidth: 1)
                    )
            }
            Spacer().frame(height: 30)
        }
        .background(Color.init(white: 0.95).edgesIgnoringSafeArea(.bottom))
    }
}

