//
//  RepositoryListCellType.swift
//  repos-search-gh
//
//  Created by 김성종 on 2023/02/26.
//

import Foundation

enum RepositoryListCellType: Hashable {
    case repository(RepositoryModel)
    case emptyResult
}
