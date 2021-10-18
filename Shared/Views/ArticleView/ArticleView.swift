//
//  ArticleView.swift
//  NewsApp
//
//  Created by Chris Guirguis on 10/5/21.
//

import SwiftUI
import SweetSimpleSwift
import SDWebImageSwiftUI

struct ArticleView: View {
    
    @ObservedObject var viewModel: ArticleViewModel
    var internalPadding:CGFloat = 12
    
    var body: some View {
        Group{
            if let article = viewModel.article {
                GeometryReader{geo in
                    ScrollView{
                        VStack(alignment: .leading, spacing: 0){
                            
                            WebImage(url: URL(string: article.imageURL))
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
                            
                            
                            Spacer()
                                .frame(height: 40)
                            
                            Group{
                                if let topic = viewModel.article?.topic {
                                HStack{
                                    NavigationLink {
                                        NavigationLazyView(TopicView(viewModel: .init(topic: topic)))
                                    } label: {
                                        Text(topic.name.uppercased())
                                            .font(.system(size: 12, weight: .semibold))
                                            .foregroundColor(.black)
                                            .padding(.horizontal, 15)
                                            .frame(height: 40)
                                            .background(Color.init(red: 0.05, green: 0.45, blue: 0.8))
                                    }

                                    
                                    Button(action: {}){
                                        Image(systemName: "plus")
                                            .font(.system(size: 17, weight: .regular))
                                        
                                            .frame(width: 40, height: 40)
                                            .foregroundColor(.black)
                                            .background(
                                                Rectangle()
                                                    .stroke(Color.init(red: 0.05, green: 0.45, blue: 0.8), lineWidth: 1)
                                            )
                                    }
                                }
                                Spacer()
                                    .frame(height: 30)
                                }
                                Text(article.title)
                                    .font(.system(size: 40, weight: .semibold))
                                    .foregroundColor(.black)
                                Spacer()
                                    .frame(height: 20)
                                Text(article.author.nameList() + "  •  " + article.dateOfPublication.writtenOut)
                                    .font(.system(size: 14, weight: .regular))
                                    .foregroundColor(.init(white: 0.6))
                                Spacer()
                                    .frame(height: 20)
                                article.finalContent(geo.frame(in: .global).size.width - (2 * internalPadding))
                                Spacer()
                                    .frame(height: 20)
                                
                                
                            }
                            .padding(.horizontal, internalPadding)
                            if let authors = viewModel.article?.author {
                                ForEach(authors, id: \.self){author in
                                    AuthorBriefDetailsView(viewModel: .init(author: author))
                                }
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }.edgesIgnoringSafeArea(.bottom)
                }.edgesIgnoringSafeArea(.bottom)
                
            } else {
                ProgressView("Loading")
                    .progressViewStyle(CircularProgressViewStyle(tint: .lightBlue))
            }
        }
        .frame(width: UIScreen.main.bounds.width)
        .edgesIgnoringSafeArea(.bottom)
    }
    
    
}


