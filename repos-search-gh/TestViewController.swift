//
//  TestViewController.swift
//  repos-search-gh
//
//  Created by 김성종 on 2023/02/23.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import ReactorKit

final class TestViewController: UIViewController, ReactorKit.View {
    typealias Reactor = TestViewReactor
    var disposeBag = DisposeBag()

    private let testButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("q=Q", for: .normal)
        return button
    }()

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
        cv.backgroundColor = .white
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    var repositories: [RepositoryModel] = []

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

        view.addSubview(testButton)
        testButton.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(44)
        }
        view.addSubview(repositoryCollectionView)
        repositoryCollectionView.snp.makeConstraints {
            $0.top.equalTo(testButton.snp.bottom)
            $0.bottom.leading.trailing.equalToSuperview()
        }
    }

    func bind(reactor: Reactor) {
        testButton.rx.tap
            .map { Reactor.Action.testButtonDidTap }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)

        reactor.state
            .map { $0.repositories }
            .filter { !$0.isEmpty }
            .subscribe(onNext: { [weak self] repositories in
                self?.repositories = repositories
                self?.repositoryCollectionView.reloadData()
            })
            .disposed(by: disposeBag)
    }
}

extension TestViewController: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return repositories.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: RepositoryCell.identifier,
            for: indexPath
        )
        guard
            let repoCell = cell as? RepositoryCell,
            let model = repositories[safe: indexPath.item]
        else {
            return cell
        }
        repoCell.setup(model)
        return repoCell
    }
}

extension TestViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        guard
            let model = repositories[safe: indexPath.item]
        else {
            return .zero
        }

        let cell = RepositoryCell()
        cell.setup(model)
        let cellWidth = view.windowSize.width
        let cellHeight = cell.contentView.systemLayoutSizeFitting(.zero).height
        return CGSize(width: cellWidth, height: cellHeight)
    }
}
