//
//  SearchViewController.swift
//  repos-search-gh
//
//  Created by 김성종 on 2023/02/23.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import ReactorKit

final class SearchViewController: UIViewController, ReactorKit.View {
    typealias Reactor = SearchViewReactor
    var disposeBag = DisposeBag()

    private let searchBarView = SearchTextFieldBarView()

    private let repositoryLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        return layout
    }()
    private lazy var repositoryCollectionView: UICollectionView = {
        let cv = UICollectionView(
            frame: .zero,
            collectionViewLayout: repositoryLayout
        )
        cv.register(
            RepositoryCell.self,
            forCellWithReuseIdentifier: RepositoryCell.identifier
        )
        cv.register(
            EmptyListCell.self,
            forCellWithReuseIdentifier: EmptyListCell.identifier
        )
        cv.backgroundColor = .white
        cv.alwaysBounceVertical = true
        cv.keyboardDismissMode = .onDrag
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()

    private var cellTypes: [RepositoryListCellType] {
        reactor?.currentState.cellTypes ?? []
    }

    init(reactor: Reactor) {
        defer { self.reactor = reactor }
        super.init(nibName: nil, bundle: nil)
        render()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func render() {
        view.backgroundColor = .white

        view.addSubview(searchBarView)
        searchBarView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(44)
        }
        view.addSubview(repositoryCollectionView)
        repositoryCollectionView.snp.makeConstraints {
            $0.top.equalTo(searchBarView.snp.bottom)
            $0.bottom.leading.trailing.equalToSuperview()
        }
    }

    func bind(reactor: Reactor) {
        searchBarView.rx.searchText
            .distinctUntilChanged()
            .map { Reactor.Action.textFieldDidFinishEdit($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)

        reactor.state
            .map { $0.cellTypes }
            .filter { !$0.isEmpty }
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] _ in
                self?.repositoryCollectionView.reloadData()
            })
            .disposed(by: disposeBag)
    }
}

extension SearchViewController: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return cellTypes.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard
            let cellType = cellTypes[safe: indexPath.item]
        else {
            return UICollectionViewCell()
        }

        switch cellType {
        case .repository(let model):
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: RepositoryCell.identifier,
                for: indexPath
            )
            guard
                let repoCell = cell as? RepositoryCell
            else {
                return cell
            }
            repoCell.setup(model)
            return repoCell

        case .emptyResult:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: EmptyListCell.identifier,
                for: indexPath
            )
            return cell
        }
    }
}

extension SearchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        guard
            let cellType = cellTypes[safe: indexPath.item]
        else {
            return .zero
        }

        switch cellType {
        case .repository(let model):
            let cell = RepositoryCell()
            cell.setup(model)
            let cellWidth = view.windowSize.width
            let cellHeight = cell.contentView.systemLayoutSizeFitting(.zero).height
            return CGSize(width: cellWidth, height: cellHeight)

        case .emptyResult:
            return view.windowSize
        }
    }
}
