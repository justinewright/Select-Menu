//
//  SelectMenuViewModel.swift
//  Select-Menu
//
//  Created by Justine Wright on 2021/11/04.
//

import Foundation

public class SelectMenuViewModel {
    enum Difference {
        case added
        case removed
    }
    // MARK: - Properties
    private(set) var differenceList: [Difference: [String : SelectableSet]] = [.added: [:], .removed: [:]]
    private(set) var originalList: [String: SelectableSet] = [:]
    private(set) public var searchList: [String] = []

    // MARK: - Computed Variables
    public var removedChanges: Int {
        return differenceList[.removed]?.count ?? 0
    }

    public var addedChanges: Int {
        return differenceList[.added]?.count ?? 0
    }

    public var totalChanges: Int {
        return removedChanges + addedChanges
    }
    public var addedSets: [String]? {
        return differenceList[.added].map{ $0.map { $0.key}}
    }

    public var removedSets: [String]? {
        return differenceList[.removed].map{ $0.map { $0.key}}
    }

    // MARK: - Filter Properties
    public var filteredList: [String] = []
    public var sets: [String: SelectableSet] {
        filteredList.isEmpty ? originalList :
        originalList.filter { filteredList.map{ $0.lastSubString }.contains($0.key) }
    }
    // MARK: - Initialization
    public init () { }

    public func setList(withNewList list: [SelectableSet]) {
        originalList = Dictionary(uniqueKeysWithValues: list.map({($0.id, $0)}))
    }

    public func setSearchList(withSearchList list: [String]) {
        searchList = list
    }

    public func toggleItem(withId itemID: String) {
        guard let _ = originalList[itemID] else {
            return
        }
        if isItemOriginal(itemID) {
            toggleOriginalItem(itemID)
        } else {
            toggleModifiedItem(itemID)
        }
        originalList[itemID]!.selected = !originalList[itemID]!.selected
    }

    public var keys: [String] {
        Array(sets.keys)
    }

    // MARK: - Private methods
    fileprivate func toggleOriginalItem(_ itemID: String) {
        let targetKey: Difference = originalList[itemID]!.selected ? .removed : .added
        differenceList[targetKey]![itemID] = originalList[itemID]!
    }

    fileprivate func toggleModifiedItem(_ itemID: String) {
        let targetKey: Difference = originalList[itemID]!.selected ? .added : .removed
        differenceList[targetKey]!.removeValue(forKey: itemID)
    }

    private func isItemOriginal(_ itemID: String) -> Bool {
        differenceList[.added]![itemID] == nil && differenceList[.removed]![itemID] == nil
    }

}
