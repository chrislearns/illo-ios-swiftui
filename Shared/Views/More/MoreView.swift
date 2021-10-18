//
//  MoreView.swift
//  NewsApp
//
//  Created by Chris Guirguis on 10/5/21.
//

import SwiftUI
import SweetSimpleSwift

struct MoreView: View {
    
    @ObservedObject var viewModel: MoreViewModel
    
    var body: some View{
        VStack(spacing: 0){
            BannerView(
                viewModel: .init(
                    subtitle: "Sign in to save stories and follow your favorite topics.".toText(),
                    subtitleColor: .white,
                    buttonOrientation: .widespanLowerButton,
                    buttonDetails: .init(
                        text: "Sign in".toText().font(.system(size: 12, weight: .bold)),
                        action: {
                            
                        })))
                .background(Color.illoGray)
        Form{
            Section(header: Text("Contact Us".uppercased())){
                NavigationLink("Email Support"){
                    Text("NEED TO SETUP")
                }
                NavigationLink("Give Feedback"){
                    Text("NEED TO SETUP")
                }
            }
            Section(header: Text("Terms".uppercased())){
                NavigationLink("About"){
                    Text("NEED TO SETUP")
                }
                NavigationLink("Terms of Service"){
                    Text("NEED TO SETUP")
                }
                NavigationLink("Privacy Policy"){
                    Text("NEED TO SETUP")
                }
            }
            Section(header: Text("APP")) {
                HStack {
                    let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
                    let version2 = Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? ""
                    Text("Version")
                    Spacer()
                    Text("\(version) (\(version2))")
                }
            }
        }
        }
    }
}

struct MoreView_Previews: PreviewProvider {
    static var previews: some View {
        MoreView(viewModel: .init())
    }
}
