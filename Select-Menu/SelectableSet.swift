//
//  SelectableSet.swift
//  Select-Menu
//
//  Created by Justine Wright on 2021/11/04.
//

import Foundation

struct SelectableSet {
    let id: String
    let labelText: String
    let imageUrl: String
    var selected: Bool

    init (id: String, series: String, url: String, selected: Bool) {
        self.id = id
        self.labelText = series
        self.imageUrl = url
        self.selected = selected
    }
}

