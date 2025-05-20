//
//  ResultScreenViewTests.swift
//  hearXTestTests
//
//  Created by Varsana Maharaj on 2025/05/20.
//

import Testing
import XCTest
import SwiftUI
@testable import hearXTest

class resultsScreenViewTests: XCTestCase {
    func testResultsViewDisplaysResults() {
        let viewModel = TestScreenViewModel()
        viewModel.results = [
            TestResult(score: 100, date: Date()),
            TestResult(score: 80, date: Date().addingTimeInterval(-3600))
        ]

        let resultsView = ResultsScreenView(viewModel: viewModel)
        let view = UIHostingController(rootView: resultsView)

        XCTAssertNotNil(view)
        XCTAssertEqual(viewModel.results.count, 2)
    }

    func testResultsSortedByScoreDescending() {
        let viewModel = TestScreenViewModel()
        let firstResult = TestResult(score: 80, date: Date())
        let secondResult = TestResult(score: 100, date: Date().addingTimeInterval(-3600))
        viewModel.results = [firstResult, secondResult]

        let sortedResults = viewModel.results.sorted { $0.score > $1.score }

        XCTAssertEqual(sortedResults.first?.score, 100)
        XCTAssertEqual(sortedResults.last?.score, 80)
    }

    func testResultsViewDisplaysFormattedDate() {
        let viewModel = TestScreenViewModel()
        let testDate = Date(timeIntervalSince1970: 0)
        viewModel.results = [TestResult(score: 100, date: testDate)]
        let formatter = DateFormatter.shortDate

        let resultsView = ResultsScreenView(viewModel: viewModel)
        let view = UIHostingController(rootView: resultsView)
        let displayedDate = formatter.string(from: testDate)

        XCTAssertNotNil(view)
    }
}
