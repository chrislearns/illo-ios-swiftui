//
//  EmailSubscriptionView.swift
//  NewsApp
//
//  Created by Chris Guirguis on 10/13/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct EmailSubscriptionView: View {
    var header: String
    var title: String
    var subtitle: String
    var imageURL: String
    
    @State var emailString: String = ""
    
    var body: some View {
        VStack{
            HStack(alignment: .top){
                VStack(alignment: .leading, spacing: 15){
                    Text(header.uppercased())
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(.init(white: 0.5))
                    Text(title)
                        .font(.system(size: 20, weight: .medium))
                        .foregroundColor(.black)
                    Text(subtitle)
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.init(white: 0.5))
                }
                
                Spacer().frame(width: 40)
                Spacer()
                ZStack{
                    Rectangle()
                        .frame(width: 150, height: 150)
                        .foregroundColor(.lightBlue)
                    WebImage(url: URL(string: imageURL))
                    // Supports options and context, like `.delayPlaceholder` to show placeholder only when error
                        .onSuccess { image, data, cacheType in
                            // Success
                            // Note: Data exist only when queried from disk cache or network. Use `.queryMemoryData` if you really need data
                        }
                        .resizable() // Resizable like SwiftUI.Image, you must use this modifier or the view will use the image bitmap size
                        .placeholder(Image(systemName: "photo")) // Placeholder Image
                    // Supports ViewBuilder as well
                        .placeholder {
                            Rectangle().foregroundColor(.init(white: 0.9))
                        }
                        .indicator(.activity) // Activity Indicator
                        .transition(.fade(duration: 0.5)) // Fade Transition with duration
                        .scaledToFit()
                        .frame(width: 120, height: 120)
                        .offset(x: -50)
                        
                }
            }
            Spacer().frame(height: 30)
            Text("SUBSCRIBE WITH EMAIL")
                .font(.system(size: 14, weight: .bold))
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, alignment: .leading)
            HStack{
                TextField("Enter email address", text: $emailString)
                    .padding(.vertical, 8)
                    .padding(.horizontal)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.init(white: 0.87), lineWidth: 1)
                    )
                Button(action: {}){
                    Image(systemName: "arrow.right.square.fill")
                        .font(.system(size: 30, weight: .regular))
                        .foregroundColor(.lightBlue)
                }
            }.padding(.trailing)
        }
        .padding(.leading)
        .padding(.bottom)
        .background(Color.white)
    }
}

struct EmailSubscriptionView_Previews: PreviewProvider {
    static var previews: some View {
        EmailSubscriptionView(
            header: "The Drop AM/PM",
            title: "Subscribe to the Daily Drop",
            subtitle: "All the day's headlines and highlights from the summit, direct to you every morning",
            imageURL: ""
        )
    }
}
