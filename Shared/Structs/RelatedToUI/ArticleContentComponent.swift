//
//  ArticleContentComponent.swift
//  NewsApp
//
//  Created by Chris Guirguis on 10/6/21.
//

import SwiftUI
import SweetSimpleSwift
import SwiftCodableManagement
import SDWebImageSwiftUI

struct ArticleContentComponent {
    enum ComponentType: String, Codable {
        case text
        case textLink
//        case textArray
        case image
        case htmlBlock
        case oembed
    }
    
//    enum CodingKeys: String, CodingKey {
//        case type
//        case content
//
//    }
    
    
    var type: ComponentType
    var content: ContentComponentProtocol

    
    init(content: NSAttributedString){
        self.type = .text
        self.content = TextContent(text: content)
    }
    
    init(content: String, link: String){
        self.type = .textLink
        self.content = TextLinkContent(text: content, link: link)
    }
    
    init(imageURL: String,
         width: Int? = nil,
         height: Int? = nil,
         caption: String?
         
    ){
        self.type = .image
        self.content = ImageContent(url: imageURL, width: width, height: height, caption: caption)
    }
    
    init(rawHTML: String){
        self.type = .htmlBlock
        self.content = HTMLContent(string: rawHTML)
    }
    
    init(embedString: String){
        self.type = .oembed
        self.content = OEmbedContent(string: embedString)
    }
//    init(content: [TextArrayContent.LinkAndText]){
//        self.type = .textArray
//        self.content = TextArrayContent(texts: content)
//    }
    
    func view(_ width: CGFloat? = nil) -> some View {
        Group{
            switch type {
            case .text:
                if let content = content as? TextContent{
                    TextViewReconstructed(text: content.text)
                        
                }
                
                
            case .image:
                if let content = content as? ImageContent{
                    VStack{
                    GeometryReader{geo in
                        WebImage(url: URL(string: content.url))
                                                // Supports options and context, like `.delayPlaceholder` to show placeholder only when error
                                                .onSuccess { image, data, cacheType in
                                                    // Success
                                                    // Note: Data exist only when queried from disk cache or network. Use `.queryMemoryData` if you really need data
                                                }
                                                .resizable() // Resizable like SwiftUI.Image, you must use this modifier or the view will use the image bitmap size
                                                .placeholder(Image(systemName: "photo")) // Placeholder Image
                                                // Supports ViewBuilder as well
                                                .placeholder {
                                                    Rectangle().foregroundColor(.gray)
                                                }
                                                .indicator(.activity) // Activity Indicator
                                                .transition(.fade(duration: 0.5)) // Fade Transition with duration
                                                .scaledToFit()
                        
                        
                    }
//                    .background(Color.green)
                        .ifLet(width){
                            $0
                                .frame(height: $1 / (content.aspRatio_WxH?.cgfloat ?? 1))
                                .frame(width: $1)
                        }
                        if let caption = content.caption {
                            Text(caption)
                                .foregroundColor(.init(white: 0.5))
                                .font(.system(size: 12, weight: .regular))
                                .lineLimit(0)
                        }
                    }

                        
                        
                }
                
            case .textLink:
                if let content = content as? TextLinkContent,
                   let url = URL(string: content.link){
                    Link(content.text, destination: url)
                }
                
            case .htmlBlock:
                if let content = content as? HTMLContent {
                    WebViewReconstructed(htmlString: content.string)
                }
            case .oembed:
                if let content = content as? OEmbedContent {
                    WebViewReconstructed(htmlString: content.string)
                }
//            case .textArray:
//
//
//                if let content = content as? TextArrayContent {
//                    let text = MixedTextLinkToNSAttributedString(mixList: content.texts)
//
////                    text// + Link(destination: URL("https://google.com"), label: )
//
//                    TextViewReconstructed(text: text)
//                        .background(Color.red)
//
//
//                }
            }
        }
    }
}

//func MixedTextLinkToNSAttributedString(mixList: [TextArrayContent.LinkAndText]) -> NSAttributedString {
//    var linkList:Array<(link:URL, start: Int, length: Int)> = []
//    var text  = ""
//    for item in mixList {
//        if let link = item.link,
//        let url = URL(string: link){
//            linkList.append((link: url, start: text.count, length: item.text.count))
//        }
//        text += item.text
//    }
//
//    let returnVal = NSMutableAttributedString(string: text)
//    for link in linkList {
//        returnVal.setAttributes([.link: link.link], range: NSMakeRange(link.start, link.length))
//    }
//
//    return returnVal
//
//}

protocol ContentComponentProtocol {
//    init(from: Decoder)
}

struct TextContent: ContentComponentProtocol {
    var text: NSAttributedString
}

struct TextLinkContent: ContentComponentProtocol {
    var text: String
    var link: String
}

struct HTMLContent: ContentComponentProtocol {
    var string: String
}

struct OEmbedContent: ContentComponentProtocol {
    var string: String
}

struct ImageContent: ContentComponentProtocol {
    var url: String
    var width: Int?
    var height: Int?
    var caption: String?
    var aspRatio_WxH: Double? {
        if let w = width?.double, let h = height?.double {
            return w / h
        }
        
        return nil
    }
}

extension NSAttributedString {
    convenience init(htmlString html: String, font: UIFont? = nil, useDocumentFontSize: Bool = false) throws {
            let options: [NSAttributedString.DocumentReadingOptionKey : Any] = [
                .documentType: NSAttributedString.DocumentType.html,
                .characterEncoding: String.Encoding.utf8.rawValue
            ]

            let data = html.data(using: .utf8, allowLossyConversion: true)
            guard (data != nil), let fontFamily = font?.familyName, let attr = try? NSMutableAttributedString(data: data!, options: options, documentAttributes: nil) else {
                try self.init(data: data ?? Data(html.utf8), options: options, documentAttributes: nil)
                return
            }

            let fontSize: CGFloat? = useDocumentFontSize ? nil : font?.pointSize
            let range = NSRange(location: 0, length: attr.length)
            attr.enumerateAttribute(.font, in: range, options: .longestEffectiveRangeNotRequired) { attrib, range, _ in
                if let htmlFont = attrib as? UIFont {
                    let traits = htmlFont.fontDescriptor.symbolicTraits
                    var descrip = htmlFont.fontDescriptor.withFamily(fontFamily)

                    if (traits.rawValue & UIFontDescriptor.SymbolicTraits.traitBold.rawValue) != 0 {
                        descrip = descrip.withSymbolicTraits(.traitBold)!
                    }

                    if (traits.rawValue & UIFontDescriptor.SymbolicTraits.traitItalic.rawValue) != 0 {
                        descrip = descrip.withSymbolicTraits(.traitItalic)!
                    }

                    attr.addAttribute(.font, value: UIFont(descriptor: descrip, size: fontSize ?? htmlFont.pointSize), range: range)
                }
            }

            self.init(attributedString: attr)
        }

}
