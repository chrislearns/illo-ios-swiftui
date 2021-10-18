//
//  View+Extensions.swift
//  NewsApp (iOS)
//
//  Created by Chris Guirguis on 10/18/21.
//

import SwiftUI

extension View {
    func standardButtonStyle() -> some View{
        return self
            .padding()
            .background(Color.init(white: 0.8))
            .padding()
    }
}
