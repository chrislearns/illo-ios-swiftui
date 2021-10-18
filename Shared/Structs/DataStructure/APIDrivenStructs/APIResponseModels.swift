//
//  APIResponseModels.swift
//  NewsAppUITests
//
//  Created by Chris Guirguis on 10/18/21.
//

import Foundation

struct Sections: Codable {
    let _id, name: String?
    let parent_id: String?
    let description: String?
    let additional_properties: TaxonomyAdditionalProperties?
}

struct StoryCardsAPIResponseModel: Codable {
    let title: String?
    let cardsType: String?
    let alignment: ArticleCardDisplayViewModel.CardAlignment?
    let id: String?
    let result: [Results]?
    let sectionId: String?
}

struct Results: Codable {
    
    let headline: String?
    let subheadline: String?
    let description: String?
    let by: [AuthorInfo]?
    let img: ImageDirectory?
    let primary_section: Sections?
    let publish_date: String?
    let display_date: String?
    let id, _id: String?
    let website_url: String?
    let tags: [Tag]?
    let included_media_type: String?
    var label:MediaLabel?
}

struct Tag: Codable {
    let description: String?
    let slug: String?
    let text: String?
    
}

struct ImageDirectory: Codable {
    let url: String?
    let resized_params: [String:String]?
    
    init(url:String?,resized_params:[String:String]?) {
        self.url = url
        self.resized_params = resized_params
    }
    
    init(basicDetails:Basic?) {
        self.url = basicDetails?.url
        self.resized_params = basicDetails?.resized_params
    }
    
    init(authorImage:AuthorImage?) {
        self.url = authorImage?.url
        self.resized_params = nil
    }
}

struct ResizedParams {
    let size: String?
    let suffix: String?
    
    static func createResizeParams(from dict:[String:String])->[ResizedParams]{
        return dict.map { (key,value)->ResizedParams in
            return ResizedParams(size: key, suffix: value)
        }
    }
}


// MARK: - By
struct AuthorInfo: Codable, AuthorType {
    let _id, id, type, version, name: String?
    let org: String?
    let image: AuthorImage?
    let description, url, slug: String?
    let bySocialLinks: [SocialLinkElement]?
    let social_links: [SocialLink]?
    let additional_properties: AdditionalProperties?
    
}

struct SocialLinkElement: Codable {
    let site, url: String?
}

// MARK: - Image
struct AuthorImage: Codable {
    let url: String?
    let version: String?
}

// MARK: - SocialLink
struct SocialLink: Codable {
    let site, url: String?
    let deprecated: Bool?
    let deprecation_msg: String?
    
}

// MARK: - Basic
struct Basic: Codable {
    let _id: String?
    let created_date: String?
    let height: Int?
    let subtitle, type: String?
    let url: String?
    let version: String?
    let width: Int?
    let resized_params:[String:String]?
    
}


// MARK: - Label
struct MediaLabel: Codable {
    let audio_url, event_date, event_duration, podcast_audio_duration, audio_duratioin: MediaURL?
    let event_type: EventType?
    let event_video_url: MediaURL?
    var podcast_episode: PodcastEpisode?
}



// MARK: - AdditionalProperties
struct AdditionalProperties: Codable {
    let original: Original?
}

// MARK: - Original
struct Original: Codable {
    let _id, firstName, lastName, byline: String?
    let role: String?
    let image: String?
    let email, affiliations, author_type: String?
    let bio_page, location, bio, longBio: String?
    let slug: String?
    let native_app_rendering, fuzzy_match, contributor, status: Bool?
    let last_updated_date, twitter: String?
}


struct MediaURL: Codable {
    let display: Bool?
    let text: String?
}

// MARK: - PodcastEpisode
struct PodcastEpisode: Codable {
    var display: Bool?
    var text, url: String?
}

// MARK: - Label
struct EventLabel: Codable {
    let audio_url, event_date, event_duration, event_live_url: MediaURL?
    let event_type: EventType?
}


// MARK: - EventType
struct EventType: Codable {
    let display: Bool?
    let text, url: String?
}

struct TaxonomyAdditionalProperties: Codable {
    let original: TaxonomyOriginal?
}

// MARK: - Original
struct TaxonomyOriginal: Codable {
    let _id: String?
    let site: Site?
    
}

struct Site: Codable {
    let site_about: String?
    let site_title: String?
    let site_description: String?
    let short_description: String?
    let color: String?
}

struct ArticleDetailsResponseModel: Codable {

    
    let _id, type: String?
    let content_elements: [ContentElement]?
    let headlines, subhealines, description: Headlines?
    let label: MediaLabel?
    let taxonomy: Taxonomy?
    let promo_items: PromoItems?
    let credits: Credits?
    let first_publish_date, publish_date: String?
    let website_url: String?

}

struct ContentElement: Codable {
    
    func toArticleContentComponent() throws -> [ArticleContentComponent] {
        enum Errors: String, Error  {
            case failedToConvertToArticleComponents
        }
        
        guard let type = type else { throw Errors.failedToConvertToArticleComponents }
        switch type {
        case "text":
            guard let content = content else {
                print("Text failed to unwrap")
                throw Errors.failedToConvertToArticleComponents
            }
            return [.init(content: try NSAttributedString(htmlString: content, font: .systemFont(ofSize: 15)))]
        case "quote":
            guard let content_elements = content_elements else {
                print("quote failed to unwrap")
                throw Errors.failedToConvertToArticleComponents
            }
            let val = try content_elements.flatMap{try $0.toArticleContentComponent()}
            return val
        case "interstitial_link":
            guard let content = content,
            let url = url else {
                print("interstitial link failed to unwrap")
                throw Errors.failedToConvertToArticleComponents
            }
            return [.init(content: content, link: url)]
        case "image":
            guard let url = url else {
                print("image failed to unwrap")
                throw Errors.failedToConvertToArticleComponents
            }
            return [.init(imageURL: url, width: width, height: height, caption: caption)]
        case "raw_html":
            guard let content = content else {
                print("raw_html failed to unwrap")
                throw Errors.failedToConvertToArticleComponents
            }
            print("raw-html content \(content)")
            return [.init(rawHTML: content)]
            
        case "oembed_response":
            guard let oembedContent = raw_oembed,
                  let htmlString = oembedContent.html else {
                print("oembed_response failed to unwrap")
                throw Errors.failedToConvertToArticleComponents
            }
            return [.init(embedString: htmlString)]
            
        case "header":
            guard let content = content else {
                print("header failed to unwrap")
                throw Errors.failedToConvertToArticleComponents
            }
            return [.init(content: try NSAttributedString(htmlString: content, font: nil))]
            
        default:
            print("failed to unwrap content element - case unaccounted for \(type)")
            throw Errors.failedToConvertToArticleComponents
        }
        
    }
    
    let _id, type, content, subtitle: String?
    let url: String?
    let width: Int?
    let height: Int?
    let caption: String?
    let level: Int?
    let list_type: String?
    let content_elements: [ContentElement]?
    let duration: Int?
    let video_type: String?
    let streams: [Streams]?
    let promo_image: PromoImage?
    let resized_params:[String:String]?
    let subtype: String?
    let raw_oembed: RawOEmbed?
}

// MARK: - PromoImage
struct PromoImage: Codable {
    let type, version: String?
    let credits: PromoImageCredits?
    let caption: String?
    let url: String?
    let width, height: Int?
    let resized_params:[String:String]?
}

// MARK: - PromoImageCredits
struct PromoImageCredits: Codable {
}


// MARK: - Headlines
struct Headlines: Codable {
    let basic: String?
}

// MARK: - PromoItems
struct PromoItems: Codable {
    let basic: Basic?
}

// MARK: - WelcomeCredits
struct Credits: Codable {
    let by: [AuthorInfo]?
}

// MARK: - Taxonomy
struct Taxonomy: Codable {
    let sections: [Sections]?
    let tags: [Tag]?
    let primary_section: Sections?
}

// MARK: - Streams
struct Streams: Codable {
    let height, width, filesize: Int?
    let stream_type: String?
    let url: String?
    let bitrate: Int?
    let provider: String?

}

struct AllTopicsResponseModel: Codable {
    let children: [TopicResponse]?
    let id: String?
}

// MARK: - Child
struct TopicResponse: Codable {
    let _id: String?
    let name: String?
    let site: TopicSite?
}

struct TopicSite: Codable {
    let color: String?
    let site_description: String?
    let short_description: String?
    
}


struct TopicLandingResponseModel: Codable {
    let _id: String?
    let site: Site?
    let children: [SubtopicDetailsModel]?
}
struct SubtopicDetailsModel: Codable {
    let _id: String?
    let site: Site?
    let name: String?
    
}

struct SubtopicResponseModel: Codable {
    var _id: String?
    var count: Int?
    var content_elements: [ArticleDetailsResponseModel]?
}

struct RawOEmbed: Codable {
    let _id: String?
    let author_name: String?
    let author_url: String?
    let provider_url: String?
    let provider_name: String?
    let html: String?
    let type: String?
    let version: String?
    let width: Int?
}
