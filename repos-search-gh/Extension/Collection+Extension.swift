//
//  Collection+Extension.swift
//  repos-search-gh
//
//  Created by 김성종 on 2023/02/26.
//

import Foundation

extension Collection {
    subscript(safe i: Index) -> Iterator.Element? {
        return self.indices.contains(i) ? self[i] : nil
    }
}
