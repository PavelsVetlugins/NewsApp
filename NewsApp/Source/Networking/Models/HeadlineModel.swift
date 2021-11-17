//
//  HeadlineModel.swift
//  NewsApp
//
//  Created by pavels.vetlugins on 11/11/2021.
//

import Foundation

// MARK: - HeadlineResponse
struct HeadlineModel: Codable {
    var totalArticles: Int
    var articles: [Article]
}

// MARK: - Article
struct Article: Codable {
    var title, articleDescription, content: String
    var url: String
    var image: String
    var publishedAt: String
    var source: Source

    enum CodingKeys: String, CodingKey {
        case title
        case articleDescription = "description"
        case content, url, image, publishedAt, source
    }
}

// MARK: - Source
struct Source: Codable {
    var name: String
    var url: String
}

extension Article {
    static func mock() -> Article {
        let data = articleJSON.data(using: .utf8)
        return try! JSONDecoder().decode(Article.self, from: data!)
    }
}

let articleJSON = """
{
            "title": "Nick Leeder appointed as latest head of Google Ireland",
            "description": "Google has announced that Nick Leeder will replace Fionnuala Meehan as the head of its Irish operation starting in April.",
            "content": "Google has announced that Nick Leeder will replace Fionnuala Meehan as the head of its Irish operation starting in April. While its staff continue to work from home in the midst of the coronavirus pandemic, Google Ireland will have a new person leadi... [1514 chars]",
            "url": "https://www.siliconrepublic.com/companies/nick-leeder-google-ireland",
            "image": "https://www.siliconrepublic.com/wp-content/uploads/2020/03/BOO_3353_2.jpg",
            "publishedAt": "2020-03-23T13:58:53Z",
            "source": {
                "name": "Silicon Republic",
                "url": "https://www.siliconrepublic.com/"
            }
}
"""


