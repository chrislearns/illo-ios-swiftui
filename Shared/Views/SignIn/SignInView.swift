//
//  SignInView.swift
//  NewsApp (iOS)
//
//  Created by Chris Guirguis on 10/18/21.
//

import SwiftUI

struct SignInView: View {
    var body: some View {
        ZStack{
            Color.illoGray.edgesIgnoringSafeArea(.all)
            VStack{
                Group{
                    TextField.init("Email Address", text: .constant(""))
                    SecureField.init("Password", text: .constant(""))
                }
                .standardButtonStyle()
            }
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
