//
//  RepositoryModelProvider.swift
//  repos-search-gh
//
//  Created by 김성종 on 2023/02/23.
//

import Foundation
import RxSwift

final class RepositoryModelProvider: BaseNetworkAgent<SearchEndpoint> {
    func fetch(query: String) -> Observable<[RepositoryModel]?> {
        return requestOptional(
            target: .searchRepositories(query),
            responseType: [RepositoryData].self,
            atKeyPath: "items"
        )
        .map { items -> [RepositoryModel]? in
            items?.map { RepositoryModel(from: $0) }
        }
    }
}
