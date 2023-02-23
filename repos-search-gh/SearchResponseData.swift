//
//  SearchResponseData.swift
//  repos-search-gh
//
//  Created by 김성종 on 2023/02/23.
//

import Foundation

struct SearchResponseData: Decodable {
    let totalCount: Int
    let items: [RepositoryData]

    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case items
    }
}

struct RepositoryData: Decodable {
    let id: Int
    let fullName: String
    let description: String
    let starCount: Int

    enum CodingKeys: String, CodingKey {
        case id
        case fullName = "full_name"
        case description
        case starCount = "stargazers_count"
    }
}
