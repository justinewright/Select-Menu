//
//  Select_MenuTests.swift
//  Select_MenuTests
//
//  Created by Justine Wright on 2021/11/05.
//

import XCTest

class Select_MenuTests: XCTestCase {

    var mockList: [SelectableSet] = [SelectableSet(id: "0", series: "series0", url: "", selected: false),
                                     SelectableSet(id: "1", series: "series1", url: "", selected: true)]

    var viewModelUnderTesting: SelectMenuViewModel!

    override func setUp() {
        viewModelUnderTesting = SelectMenuViewModel()
    }

    func testViewModelOriginalListEmptyOnInitialization() {
        XCTAssertTrue(viewModelUnderTesting.originalList.isEmpty)
    }

    func testViewModelAddedSetsListEmptyOnInitialization() {
        XCTAssertTrue(viewModelUnderTesting.differenceList[.added]!.isEmpty)
    }

    func testViewModelRemovedSetsListEmptyOnInitialization() {
        XCTAssertTrue(viewModelUnderTesting.differenceList[.removed]!.isEmpty)
    }

    func testViewModelOriginalListPopulatedWhenSetListCalled() {
        viewModelUnderTesting.setList(withNewList: mockList)
        XCTAssertFalse(viewModelUnderTesting.originalList.isEmpty)
    }

    func testViewModelRemovedListIsEmptyWhenSetListCalled() {
        viewModelUnderTesting.setList(withNewList: mockList)
        XCTAssertTrue(viewModelUnderTesting.differenceList[.added]!.isEmpty)
    }

    func testViewModelAddedListIsEmptyWhenSetListCalled() {
        viewModelUnderTesting.setList(withNewList: mockList)
        XCTAssertTrue(viewModelUnderTesting.differenceList[.removed]!.isEmpty)
    }

    func testWhenOriginalUnselectedItemIsSelectedThenItemIsAddedToAddedItemsList() {
        viewModelUnderTesting.setList(withNewList: mockList)
        let testID = "0"

        viewModelUnderTesting.toggleItem(withId: testID)

        let expectedAddedItemsCount = 1
        let actualAddedItemsCount = viewModelUnderTesting.differenceList[.added]!.count
        XCTAssertEqual(expectedAddedItemsCount, actualAddedItemsCount)
    }

    func testWhenOriginalUnselectedItemIsSelectedThenItemSelectedStateTogglesFromFalseToTrue() {
        viewModelUnderTesting.setList(withNewList: mockList)
        let testID = "0"
        let expectedInitialSelectedState = false
        let actualInitialSelectedState = viewModelUnderTesting.originalList[testID]!.selected
        XCTAssertEqual(expectedInitialSelectedState, actualInitialSelectedState)

        viewModelUnderTesting.toggleItem(withId: testID)

        let expectedFinalSelectedState = true
        let actualFinalSelectedState = viewModelUnderTesting.originalList[testID]!.selected
        XCTAssertEqual(expectedFinalSelectedState, actualFinalSelectedState)
    }

    func testWhenOriginalSelectedItemIsDeselectedThenItemIsAddedToRemovedItemsList() {
        viewModelUnderTesting.setList(withNewList: mockList)
        let testID = "1"
        XCTAssertTrue(((viewModelUnderTesting.originalList[testID]?.selected) != nil))

        viewModelUnderTesting.toggleItem(withId: testID)

        let expectedAddedItemsCount = 1
        let actualAddedItemsCount = viewModelUnderTesting.differenceList[.removed]!.count
        XCTAssertEqual(expectedAddedItemsCount, actualAddedItemsCount)
        XCTAssertTrue(((viewModelUnderTesting.originalList[testID]?.selected) != nil))
    }

    func testWhenOriginalSelectedItemIsDeselectedThenItemSelectedStateTogglesFromTrueToFalse() {
        viewModelUnderTesting.setList(withNewList: mockList)
        let testID = "1"
        let expectedInitialSelectedState = true
        let actualInitialSelectedState = viewModelUnderTesting.originalList[testID]!.selected
        XCTAssertEqual(expectedInitialSelectedState, actualInitialSelectedState)

        viewModelUnderTesting.toggleItem(withId: testID)

        let expectedFinalSelectedState = false
        let actualFinalSelectedState = viewModelUnderTesting.originalList[testID]!.selected
        XCTAssertEqual(expectedFinalSelectedState, actualFinalSelectedState)
    }

    func testWhenItemDoesNotExistInOriginalListThenToggleItemDoesNothing() {
        let testID = "2"

        viewModelUnderTesting.toggleItem(withId: testID)

        let expectedDifferenceListChangesCount = 0
        let actualDifferenceListChangesCount = viewModelUnderTesting.totalChanges
        XCTAssertEqual(expectedDifferenceListChangesCount, actualDifferenceListChangesCount)
    }

    func testWhenNewAddedItemIsDeselectedThenItemIsRemovedFromAddedItemsList() {
        viewModelUnderTesting.setList(withNewList: mockList)
        let testID = "0"

        viewModelUnderTesting.toggleItem(withId: testID)
        viewModelUnderTesting.toggleItem(withId: testID)

        let expectedAddedItemsCount = 0
        let actualAddedItemsCount = viewModelUnderTesting.addedChanges
        XCTAssertEqual(expectedAddedItemsCount, actualAddedItemsCount)
    }

    func testWhenNewRemovedItemIsSelectedThenItemIsRemovedFromRemovedItemsList() {
        viewModelUnderTesting.setList(withNewList: mockList)
        let testID = "1"

        viewModelUnderTesting.toggleItem(withId: testID)
        viewModelUnderTesting.toggleItem(withId: testID)

        let expectedAddedItemsCount = 0
        let actualAddedItemsCount = viewModelUnderTesting.addedChanges
        XCTAssertEqual(expectedAddedItemsCount, actualAddedItemsCount)
    }

}
