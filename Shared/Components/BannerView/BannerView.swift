//
//  BannerView.swift
//  NewsApp
//
//  Created by Chris Guirguis on 10/7/21.
//

import SwiftUI
import SweetSimpleSwift

struct BannerView: View {
    
    @ObservedObject var viewModel: BannerViewModel
    
    var body: some View {
    
        HStack(alignment: .top){
            let vm = viewModel
            let style = viewModel.buttonOrientation
            VStack(alignment: .leading){
                if let title = viewModel.title {
                title
                        .font(vm.titleFont ?? .system(size: 18, weight: .medium))
                        .foregroundColor(.illoGray)
                    
                Spacer().frame(height: 20)
                }
                viewModel.subtitle
                    .font(vm.subtitleFont)
                    .foregroundColor(vm.subtitleColor)
                if style == .widespanLowerButton {
                    Spacer().frame(height: 10)
                    button
                }
            }.frame(maxWidth: .infinity, alignment: .leading)
            if style == .minorInlineButton {
                Spacer().frame(width: 30)
                button
            }
        }.padding()
            
    }
    
    var button: some View {
        Button(action: viewModel.buttonDetails.action){
            Group{
                let style = viewModel.buttonOrientation
                let details = viewModel.buttonDetails
                details.text
                    .if(style == .minorInlineButton){
                        $0.font(.system(size: 10, weight: .bold))
                            .foregroundColor(.black)
                            .padding(.horizontal, 13)
                            .frame(height: 35)
                            .background(
                                Rectangle()
                                    .stroke(Color.black, lineWidth: 1)
                                
                            )
                    }
                    .if(style == .widespanLowerButton){
                        $0.font(.system(size: 10, weight: .bold))
                            .foregroundColor(.black)
                            .frame(height: 35)
                            .frame(maxWidth: .infinity)
                            .background(
                                Rectangle()
                                    .foregroundColor(.lightBlue)
                                
                            )
                    }
            }
        }
    }
    
    
    
}
