//
//  hearXTestTests.swift
//  hearXTestTests
//
//  Created by Varsana Maharaj on 2025/05/19.
//

import Testing
import XCTest
import SwiftUI
@testable import hearXTest

class TestScreenViewModelTests: XCTestCase {
    var viewModel: TestScreenViewModel!

    override func setUp() {
        super.setUp()
        viewModel = TestScreenViewModel()
    }

    func testGenerateTriplet() {
        let triplet1 = viewModel.generateTriplet()
        let triplet2 = viewModel.generateTriplet()
        XCTAssertEqual(triplet1.count, 3)
        XCTAssertEqual(triplet2.count, 3)
        XCTAssertNotEqual(triplet1, triplet2)
    }

    func testSubmitCorrectInput() {
        viewModel.currentTriplet = "123"
        viewModel.userInput = "123"
        viewModel.submit()
        XCTAssertEqual(viewModel.score, 5)
    }

    func testSubmitIncorrectInput() {
        viewModel.currentTriplet = "123"
        viewModel.userInput = "321"
        viewModel.submit()
        XCTAssertEqual(viewModel.score, 0)
    }

    func testEndTest() {
        viewModel.score = 50
        viewModel.endTest()
        XCTAssertEqual(viewModel.results.first?.score, 50)
    }

    func testResetTest() {
        viewModel.score = 50
        viewModel.currentRound = 5
        viewModel.resetTest()
        XCTAssertEqual(viewModel.score, 0)
        XCTAssertEqual(viewModel.currentRound, 0)
    }
}
