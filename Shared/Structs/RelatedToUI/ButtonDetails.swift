//
//  ButtonDetails.swift
//  NewsApp
//
//  Created by Chris Guirguis on 10/7/21.
//

import SwiftUI

struct ButtonDetails {
    var text: Text
    var systemName: String?
    var imageName: String?
    var action: () -> ()
    
    init(
        text: Text,
        imageName: String,
        action: @escaping () -> ()
    ){
        self.text = text
        self.imageName = imageName
        self.action = action
    }
    
    init(
        text: Text,
        systemName: String,
        action: @escaping () -> ()
    ){
        self.text = text
        self.systemName = systemName
        self.action = action
    }
    
    init(
        text: Text,
        action: @escaping () -> ()
    ){
        self.text = text
        self.action = action
    }
}
