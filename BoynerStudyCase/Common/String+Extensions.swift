//
//  String+Extensions.swift
//  BoynerStudyCase
//
//  Created by Betul Demirci Çelik on 9.11.2025.
//
 
import Foundation

extension Optional where Wrapped == String {
 
    var emptyIfNone: String {
        self ?? ""
    }
}

extension String {
    
    var htmlDecoded: String {
        guard let data = self.data(using: .utf8) else { return self }
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]
        if let decoded = try? NSAttributedString(data: data, options: options, documentAttributes: nil) {
            return decoded.string
        }
        return self
    }
}
