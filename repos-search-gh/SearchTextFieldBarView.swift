//
//  SearchTextFieldBarView.swift
//  repos-search-gh
//
//  Created by 김성종 on 2023/02/26.
//

import UIKit
import RxSwift
import SnapKit

final class SearchTextFieldBarView: UIView {

    private lazy var searchTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "검색 쿼리를 입력해주세요"
        textField.clearButtonMode = .whileEditing
        textField.delegate = self
        return textField
    }()

    private let bottomHairlineView = UIView.hairlineView()

    fileprivate let searchTextPublisher = PublishSubject<String?>()

    init() {
        super.init(frame: .zero)
        render()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func render() {
        addSubview(searchTextField)
        searchTextField.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16))
        }
        addSubview(bottomHairlineView)
        bottomHairlineView.snp.makeConstraints {
            $0.bottom.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
    }
}

extension SearchTextFieldBarView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        searchTextPublisher.onNext(textField.text)
        return true
    }
}

extension Reactive where Base: SearchTextFieldBarView {
    var searchText: Observable<String?> {
        base.searchTextPublisher.asObservable()
    }
}
