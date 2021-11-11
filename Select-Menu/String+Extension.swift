//
//  String+Extension.swift
//  Select-Menu
//
//  Created by Justine Wright on 2021/11/04.
//

import Foundation

extension String {
    public var lastSubString: String {
        let result = self.split(separator: " ").map { String($0) }
        return result.last?.removeWhitespace ?? ""
    }
    func replace(string:String, replacement:String) -> String {
         return self.replacingOccurrences(of: string, with: replacement, options: NSString.CompareOptions.literal, range: nil)
    }

    var removeWhitespace: String {
            return self.replace(string: " ", replacement: "")
        }
}
