//
//  TabItemView.swift
//  NewsApp
//
//  Created by Chris Guirguis on 10/5/21.
//

import SwiftUI

struct TabItemView: View {
    var text:String
    var systemName:String
    
    var body: some View {
        VStack{
            Image(systemName: systemName)
            Text(text)
            
        }
        
    }
}

struct TabItemView_Previews: PreviewProvider {
    static var previews: some View {
        TabItemView(text: "Text", systemName: "star")
    }
}
