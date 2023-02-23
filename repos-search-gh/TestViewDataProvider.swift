//
//  TestViewDataProvider.swift
//  repos-search-gh
//
//  Created by 김성종 on 2023/02/23.
//

import Foundation
import RxSwift

final class TestViewDataProvider: BaseNetworkAgent<SearchEndpoint> {
    func fetch() -> Observable<SearchResponseData?> {
        return requestOptional(
            target: .searchRepositories,
            responseType: SearchResponseData.self
        )
    }
}
