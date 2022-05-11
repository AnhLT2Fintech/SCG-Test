//
//  NewsResponse.swift
//  NewsTest
//
//  Created by AnhLe on 10/05/2022.
//

import Foundation

// MARK: - NewsReponse
struct NewsResponse: Codable {
    let status: String?
    let totalResults: Int?
    let articles: [Article]?
    let code: String?
    let message: String?
}

// MARK: - Article
struct Article: Codable {
    let source: Source?
    let author: String?
    let title: String?
    let articleDescription: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?

    enum CodingKeys: String, CodingKey {
        case source, author, title
        case articleDescription = "description"
        case url, urlToImage, publishedAt, content
    }
}

// MARK: - Source
struct Source: Codable {
    let id: String?
    let name: String?
}
