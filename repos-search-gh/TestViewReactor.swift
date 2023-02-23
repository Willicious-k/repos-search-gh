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
        case setData([Int])
    }

    struct State {
        var repositories: [Int] = []
    }

    let initialState = State()
    private let networkProvider = MoyaProvider<SearchEndpoint>()

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
            return fetch()
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

    private func fetch() -> Observable<Mutation> {
        return networkProvider.rx.request(.searchRepositories)
            .filterSuccessfulStatusCodes()
            .asObservable()
            .mapJSON()
            .map { anyData -> Mutation in
                dump(anyData)
                return Mutation.setData([1, 2, 3, 4])
            }
    }
}
