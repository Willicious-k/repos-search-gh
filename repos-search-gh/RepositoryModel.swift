//
//  RepositoryModel.swift
//  repos-search-gh
//
//  Created by 김성종 on 2023/02/23.
//

import Foundation

struct RepositoryModel: Hashable {
    let id: Int
    let fullName: String
    let description: String
    let starCount: Int

    init(from data: RepositoryData) {
        id = data.id
        fullName = data.fullName
        description = data.description
        starCount = data.starCount
    }

    init(
        id: Int = 0,
        fullName: String = "",
        description: String = "",
        starCount: Int = 0
    ) {
        self.id = id
        self.fullName = fullName
        self.description = description
        self.starCount = starCount
    }
}
