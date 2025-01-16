//
//  About_YouUITests.swift
//  About-YouUITests
//
//  Created by Reenen du Plessis on 2021/08/29.
//

import XCTest
@testable import About_You

class ViewControllerTests: XCTestCase {

    var sut: OrderByTableViewController!
    var navigationController: UINavigationController!

    override func setUpWithError() throws {
        sut = OrderByTableViewController(style: .plain)
        navigationController = UINavigationController(rootViewController: sut)
        sut.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        sut = nil
        navigationController = nil
    }

    func testTableViewSetup() {
        XCTAssertNotNil(sut.tableView, "TableView should be initialized")
        XCTAssertEqual(sut.tableView.numberOfSections, 1, "TableView should have 1 section")
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 3, "TableView should have 3 rows")
    }

    func testCellContents() {
        let indexPaths = [
            IndexPath(row: 0, section: 0),
            IndexPath(row: 1, section: 0),
            IndexPath(row: 2, section: 0)
        ]

        let expectedTexts = ["Years", "Coffees", "Bugs"]

        for (index, indexPath) in indexPaths.enumerated() {
            let cell = sut.tableView(sut.tableView, cellForRowAt: indexPath)
            XCTAssertEqual(cell.textLabel?.text, expectedTexts[index], "Cell at row \(indexPath.row) should display '\(expectedTexts[index])'")
        }
    }

    func testDidSelectRowCallsSortingHandler() {
        let expectation = self.expectation(description: "Sorting handler should be called")

        sut.sortingHandler = { selectedAttribute in
            XCTAssertEqual(selectedAttribute, "Years", "Sorting handler should pass the correct attribute")
            expectation.fulfill()
        }

        let indexPath = IndexPath(row: 0, section: 0)
        sut.tableView.delegate?.tableView?(sut.tableView, didSelectRowAt: indexPath)

        wait(for: [expectation], timeout: 1.0)
    }
}

