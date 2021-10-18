//
//  TextViewReconstructed.swift
//  NewsApp
//
//  Created by Chris Guirguis on 10/6/21.
//

import SwiftUI
import SweetSimpleSwift

struct TextViewReconstructed: UIViewRepresentable {
    
    var text: NSAttributedString
    var textStyle: UIFont.TextStyle?
    
    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        
        textView.delegate = context.coordinator
        textView.font = .systemFont(ofSize: 15)
        textView.autocapitalizationType = .sentences
        textView.isSelectable = true
//        textView.isUserInteractionEnabled = true
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 20).isActive = true //<--- Here
        
        textView.isScrollEnabled = false
        
        
        return textView
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.attributedText = text
//        uiView.font = UIFont.preferredFont(forTextStyle: textStyle)
        uiView.linkTextAttributes = [
            .foregroundColor: Color.illoGray.uiColor,
            .underlineStyle: NSUnderlineStyle.single.rawValue
        ]

    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(text)
    }
    
    class Coordinator: NSObject, UITextViewDelegate {
        var text: NSAttributedString

        init(_ text: NSAttributedString) {
            self.text = text
        }
        
        func textViewDidChange(_ textView: UITextView) {
            self.text = textView.attributedText
        }
    }
}
