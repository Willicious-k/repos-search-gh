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
        case testButtonDidTap
    }

    enum Mutation {
        case setData([RepositoryData])
    }

    struct State {
        var repositories: [RepositoryData] = []
    }

    let initialState = State()

    private let provider = TestViewDataProvider()

    init() {
    }

    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .testButtonDidTap:
            guard
                currentState.repositories.isEmpty
            else {
                return .empty()
            }
            return performFetch()
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

    private func performFetch() -> Observable<Mutation> {
        return provider.fetch()
            .map { decoded -> Mutation in
                return Mutation.setData(decoded?.items ?? [])
            }
    }
}
