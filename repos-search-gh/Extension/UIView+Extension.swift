//
//  UIView+Extension.swift
//  repos-search-gh
//
//  Created by 김성종 on 2023/02/26.
//

import UIKit

extension UIView {
    convenience init(color: UIColor) {
        self.init(frame: .zero)
        self.backgroundColor = color
    }

    class func hairlineView(of color: UIColor?) -> UIView {
        let color = color ?? UIColor.black.withAlphaComponent(0.2)
        return UIView(color: color)
    }
}

extension UIView {
    var windowSize: CGSize {
        return window?.bounds.size ?? .zero
    }

    var safeAreaInset: UIEdgeInsets {
        return window?.safeAreaInsets ?? .zero
    }
}
