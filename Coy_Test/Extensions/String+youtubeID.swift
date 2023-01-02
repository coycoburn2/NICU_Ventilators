//
//  String+youtubeID.swift
//  Coy_Test
//
//  Created by Coy Coburn on 12/5/22.
//

import Foundation

extension String {
    var youtubeID: String {
        let pattern = "((?<=(v|V)/)|(?<=be/)|(?<=(\\?|\\&)v=)|(?<=embed/))([\\w-]++)"

        let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive)
        let range = NSRange(location: 0, length: count)

        guard let result = regex?.firstMatch(in: self, range: range) else {
            return ""
        }

        return (self as NSString).substring(with: result.range)
    }
}
