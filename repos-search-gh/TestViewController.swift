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
            $0.center.equalToSuperview()
        }
    }

    func bind(reactor: Reactor) {
        testButton.rx.tap
            .map { Reactor.Action.testButtonDidTap }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
}
