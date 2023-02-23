//
//  TestViewController.swift
//  repos-search-gh
//
//  Created by 김성종 on 2023/02/23.
//

import UIKit
import SnapKit

final class TestViewController: UIViewController {

    private let testButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("q=Q", for: .normal)
        return button
    }()

    init() {
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
}
