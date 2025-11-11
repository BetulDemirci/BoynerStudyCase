//
//  Int+Extensions.swift
//  BoynerStudyCase
//
//  Created by Betul Demirci Çelik on 9.11.2025.
//

import Foundation

extension Optional where Wrapped == Int {
   
    var emptyIfZero: String {
        if let value = self, value != 0 {
            return "\(value)"
        } else {
            return ""
        }
    }
}
