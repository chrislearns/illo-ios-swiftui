//
//  Array+Extensions.swift
//  NewsApp
//
//  Created by Chris Guirguis on 10/8/21.
//

import SwiftUI

extension Array where Element: AuthorType {
    func nameList() -> String {
        self.compactMap{$0.name}.joined(separator: ", ")
    }
}


extension Array where Element == Results {
    func toArticlePreview() -> [ArticlePreview] {
        
        self.compactMap{result -> ArticlePreview? in
            
            do {
                return try ArticlePreview(result: result)
            } catch {
                print("article fail name - \(result.headline ?? "Was nil")")
                print("failed to unwrap to articlePreview")
                return nil
            }
        }
        
    }
}


extension Array where Element == ArticleDetailsResponseModel {
    func toArticle() -> [Article] {
        self.compactMap{model -> Article? in
            do {
                return try Article(model: model)
            } catch {
                print("failed to unwrap to article")
                return nil
            }
        }
        
    }
}

extension Array where Element == StoryCardsAPIResponseModel {
    func toArticleGroups() -> [ArticleCardDisplayViewModel.PreviewsAndDiplays] {
        return self.compactMap{thisItem -> ArticleCardDisplayViewModel.PreviewsAndDiplays? in
            guard let results = thisItem.result, results.count > 0 else {return nil}
            let alignment = thisItem.alignment ?? .vertical
            return ArticleCardDisplayViewModel.PreviewsAndDiplays.init(
                groupTitle: thisItem.title,
                articles: results.toArticlePreview(),
                alignment: alignment,
                style: .init(rawValue: thisItem.cardsType ?? "") ?? StoryBlockCardViewModel.Style.defaultValue(alignment)
            )
        }
    }
}
