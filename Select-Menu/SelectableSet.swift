//
//  SelectableSet.swift
//  Select-Menu
//
//  Created by Justine Wright on 2021/11/04.
//

import Foundation

public struct SelectableSet {
    public let id: String
    public let labelText: String
    public let imageUrl: String
    public var selected: Bool

    public init (id: String, series: String, url: String, selected: Bool) {
        self.id = id
        self.labelText = series
        self.imageUrl = url
        self.selected = selected
    }
}

