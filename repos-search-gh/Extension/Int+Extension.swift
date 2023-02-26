//
//  Int+Extension.swift
//  repos-search-gh
//
//  Created by 김성종 on 2023/02/26.
//

import Foundation

extension Int {
    func withCommas() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = NumberFormatter.Style.decimal
        return formatter.string(from: NSNumber(value: self)) ?? ""
    }
}
