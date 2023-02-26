//
//  EmptyListCell.swift
//  repos-search-gh
//
//  Created by 김성종 on 2023/02/26.
//

import UIKit
import SnapKit

final class EmptyListCell: UICollectionViewCell {
    static let identifier: String = NSStringFromClass(EmptyListCell.self)

    private let guideLabel: UILabel = {
        let label = UILabel()
        label.text = "검색 결과가 없습니다.\n검색어를 확인해주세요"
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: .zero)
        render()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func render() {
        contentView.backgroundColor = .lightGray

        contentView.addSubview(guideLabel)
        guideLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}
