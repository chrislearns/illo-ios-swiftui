//
//  BannerViewModel.swift
//  NewsApp
//
//  Created by Chris Guirguis on 10/7/21.
//

import SwiftUI
import SweetSimpleSwift

class BannerViewModel: ObservableObject {
    
    enum ButtonOrientation {
        case minorInlineButton
        case widespanLowerButton
        case noButton
    }
    
    var title: Text?
    var titleColor: Color?
    var titleFont: Font?
    
    var subtitle: Text?
    var subtitleColor: Color?
    var subtitleFont: Font?
    
    var buttonOrientation: ButtonOrientation
    var buttonDetails: ButtonDetails
    
    init(
        title: Text? = nil,
        titleColor: Color? = nil,
        titleFont: Font? = nil,
        subtitle: Text? = nil,
        subtitleColor: Color? = nil,
        subtitleFont: Font? = nil,
        buttonOrientation: ButtonOrientation,
        buttonDetails: ButtonDetails
    ){
        self.title = title
        self.titleColor = titleColor
        self.titleFont = titleFont
        
        self.subtitle = subtitle
        self.subtitleColor = subtitleColor
        self.subtitleFont = subtitleFont
        
        self.buttonOrientation = buttonOrientation
        self.buttonDetails = buttonDetails
        
        
    }
}
