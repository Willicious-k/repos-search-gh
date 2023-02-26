//
//  TestViewReactor.swift
//  repos-search-gh
//
//  Created by 김성종 on 2023/02/23.
//

import ReactorKit
import RxSwift
import Moya
import RxMoya

final class TestViewReactor: ReactorKit.Reactor {
    enum Action {
        case textFieldDidFinishEdit(String?)
    }

    enum Mutation {
        case setData([RepositoryModel])
    }

    struct State {
        var repositories: [RepositoryModel] = []
    }

    let initialState = State()

    private let provider = RepositoryModelProvider()

    init() {
    }

    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .textFieldDidFinishEdit(let searchText):
            guard
                let searchText,
                searchText.isEmpty == false
            else {
                return .empty()
            }
            return performSearch(query: searchText)
        }
    }

    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state

        switch mutation {
        case .setData(let data):
            newState.repositories = data
        }
        return newState
    }

    private func performSearch(query: String) -> Observable<Mutation> {
        return provider.fetch(query: query)
            .map { decodedData -> Mutation in
                return Mutation.setData(decodedData ?? [])
            }
    }
}
