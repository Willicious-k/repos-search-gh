//
//  RepositoryCell.swift
//  repos-search-gh
//
//  Created by 김성종 on 2023/02/24.
//

import UIKit
import SnapKit

final class RepositoryCell: UICollectionViewCell {
    static let identifier: String = NSStringFromClass(RepositoryCell.self)

    private lazy var labelsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            fullNameLabel,
            descriptionLabel,
            starCountLabel
        ])
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()
    private let fullNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .bold)
        label.textColor = .black
        return label
    }()
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .lightGray
        return label
    }()
    private let starCountLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .darkGray
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
        contentView.addSubview(labelsStackView)
        labelsStackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16))
        }
    }

    func setup(_ model: RepositoryModel) {
        fullNameLabel.text = model.fullName
        descriptionLabel.text = model.description
        starCountLabel.text = "\(model.starCount)"
    }
}
