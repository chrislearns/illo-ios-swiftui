//
//  ScrollingSegmentControllerView.swift
//  NewsApp (iOS)
//
//  Created by Chris Guirguis on 10/11/21.
//

import SwiftUI
import SweetSimpleSwift

struct ScrollingSegmentControllerView<T: Hashable & CustomStringConvertible>: View{
    @StateObject var viewModel: SegmentControllerViewModel<T>
    @Binding var selection: T
    @Namespace var animation
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false){
            
            ScrollViewReader{proxy in
                HStack(spacing: 8){
                    ForEach(viewModel.options, id: \.self){option in
                        Button(action: {
                            withAnimation(.standardEIO){
                                selection = option
                                print(selection)
//                                withAnimation{
//                                proxy.scrollTo(option, anchor: .center)
//                                }
                            }
                        }){
                            Text(String(describing: option.description))
//                                .foregroundColor(.black)
                                .foregroundColor(option == selection ? .black : .init(white: 0.3))
                                .font(.system(size: 12, weight: option == selection ? .semibold : .regular))
                        }
                        .padding(6)
                        .background(
                            ZStack{
                                if selection == option {
                                    if viewModel.style == .background {
                                        viewModel.selectedOptionForegroundColor
                                            .opacity(selection == option ? 1 : 0)
                                            .cornerRadius(viewModel.indicatorCornerRadius ?? 0)
                                            .matchedGeometryEffect(id: "TAB", in: animation)
                                    } else if viewModel.style == .underline {
                                        VStack{
                                            Spacer()
                                            Rectangle()
                                                .frame(height: 3)
                                                .foregroundColor(viewModel.selectedOptionForegroundColor)
                                                .matchedGeometryEffect(id: "TAB", in: animation)
                                        }
                                    }
                                }
                            }
                        )
                        .id(option)
                    }
                }
                .onChange(of: selection) { newValue in
                    withAnimation{
                    proxy.scrollTo(newValue, anchor: .center)
                    }
                }
                
//                .if(viewModel.style == .background){
//                    $0.background(
//                        viewModel.selectedOptionBackgroundColor
//                            .ifLet(viewModel.indicatorCornerRadius){
//                                $0.cornerRadius($1)
//                            }
//                            .offset(x: -size.width/2)
//                            .offset(x: segmentWidth/2)
//                            .ifLet(viewModel.options.firstIndex(of: selection), transform: { view, val in
//                                view.offset(x: Int(val).double.cgfloat * segmentWidth)
//                            })
//
//
//                    )
//                        .background(viewModel.unselectedOptionBackgroundColor)
//                }
//                .if(viewModel.style == .underline){
//                    $0.background(
//                        VStack{
//                            Spacer()
//                            viewModel.selectedOptionBackgroundColor
//                                .frame(width: segmentWidth, height: 3)
//                                .ifLet(viewModel.indicatorCornerRadius){
//                                    $0.cornerRadius($1)
//                                }
//
//                                .offset(x: -size.width/2)
//                                .offset(x: segmentWidth/2)
//                                .ifLet(viewModel.options.firstIndex(of: selection), transform: { view, val in
//                                    view.offset(x: Int(val).double.cgfloat * segmentWidth)
//                                })
//
//                        }
//                    )
//                        .background(viewModel.unselectedOptionBackgroundColor)
//                }
            }
        }.frame(height: viewModel.height)
            
    }
}

