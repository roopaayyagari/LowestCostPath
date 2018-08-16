//
//  LowestTotalCostTests.swift
//  LowestCostPathTests
//
//  Created by Roopa on 15/08/18.
//  Copyright © 2018 photon. All rights reserved.
//

import XCTest
@testable import LowestCostPath

class LowestTotalCostViewControllerTests: XCTestCase {
    
    func testViewDidLoad ()
    {
        let vc = getViewControllerFromStoryBoard ()
        _ = vc.view
        let input = "3 4 1 2 8 6\n6 1 8 2 7 4\n5 9 3 9 9 5\n8 4 1 3 2 6\n3 7 2 8 6 4"
        vc.textInput()
        XCTAssertTrue(vc.costTextView.text == input)
    }
    
    func testSubmit ()
    {
        let vc = getViewControllerFromStoryBoard ()
        _ = vc.view
        let input = "3 4 1 2 8 6\n6 1 8 2 7 4\n5 9 3 9 9 5\n8 4 1 3 2 6\n3 7 2 8 6 4"
        vc.submit("" as AnyObject)
        XCTAssertTrue(vc.costTextView.text == input)
        
    }
    
    func testGetLeastCostPathForSample1 () // 5*6 matrix
    {
        let input = "3 4 1 2 8 6\n6 1 8 2 7 4\n5 9 3 9 9 5\n8 4 1 3 2 6\n3 7 2 8 6 4"
        let expectedPath = "[1, 2, 3, 4, 4, 5]"
        let vc = getViewControllerFromStoryBoard ()
        _ = vc.view
        vc.getLeastCostPath(input: input)
        XCTAssertTrue(vc.pathOfLeastCostExists.text == "Yes")
        XCTAssertTrue(vc.leastCost.text == "16")
        XCTAssertTrue(vc.leastCostPath.text ==  expectedPath)
    }
    
    func testGetLeastCostPathForSample2 () // 5*6 matrix
    {
        let input = "3 4 1 2 8 6\n6 1 8 2 7 4\n5 9 3 9 9 5\n8 4 1 3 2 6\n3 7 2 1 2 3"
        let expectedPath = "[1, 2, 1, 5, 4, 5]"
        let vc = getViewControllerFromStoryBoard ()
        _ = vc.view
        vc.getLeastCostPath(input: input)
        XCTAssertTrue(vc.pathOfLeastCostExists.text == "Yes")
        XCTAssertTrue(vc.leastCost.text == "11")
        XCTAssertTrue(vc.leastCostPath.text == expectedPath)
    }
    
    func testGetLeastCostPathForSample3 () // 5*6 matrix
    {
        let input = "19 10 19 10 19\n21 23 20 19 12\n20 12 20 11 10"
        let expectedPath = "[1, 1, 1]"
        let vc = getViewControllerFromStoryBoard ()
        _ = vc.view
        vc.getLeastCostPath(input: input)
        XCTAssertTrue(vc.pathOfLeastCostExists.text == "No")
        XCTAssertTrue(vc.leastCost.text == "48")
        XCTAssertTrue(vc.leastCostPath.text == expectedPath)
    }
    
    func testGetLeastCostPathForSample4 ()  // Single row
    {
        let input = "5 8 5 3 5"
        let expectedPath = "[1, 1, 1, 1, 1]"
        let vc = getViewControllerFromStoryBoard ()
        _ = vc.view
        vc.getLeastCostPath(input: input)
        XCTAssertTrue(vc.pathOfLeastCostExists.text == "Yes")
        XCTAssertTrue(vc.leastCost.text == "26")
        XCTAssertTrue(vc.leastCostPath.text == expectedPath)
    }
    
    func testGetLeastCostPathForSample5 ()  // Single Column
    {
        let input = "5\n8\n5\n3\n5"
        let expectedPath = "[4]"
        let vc = getViewControllerFromStoryBoard ()
        _ = vc.view
        vc.getLeastCostPath(input: input)
        XCTAssertTrue(vc.pathOfLeastCostExists.text == "Yes")
        XCTAssertTrue(vc.leastCost.text == "3")
        XCTAssertTrue(vc.leastCostPath.text == expectedPath)
    }
    
    func testGetLeastCostPathForSample6 ()  // Non numeric
    {
        let input = "5 4 H\n8 M 7\n5 7 5"
        let vc = getViewControllerFromStoryBoard ()
        _ = vc.view
        vc.getLeastCostPath(input: input)
        XCTAssertTrue(vc.pathOfLeastCostExists.text == "Invalid matrix")
    }
    
    func testGetLeastCostPathForSample7 ()  // No input
    {
        let input = ""
        let vc = getViewControllerFromStoryBoard ()
        _ = vc.view
        vc.getLeastCostPath(input: input)
        XCTAssertTrue(vc.pathOfLeastCostExists.text == "No input")
    }
    
    func testGetLeastCostPathForSample8 ()  // First column > 50
    {
        let input = "69 10 19 10 19\n51 23 20 19 12\n60 12 20 11 10"
        let expectedPath = "[]"
        let vc = getViewControllerFromStoryBoard ()
        _ = vc.view
        vc.getLeastCostPath(input: input)
        XCTAssertTrue(vc.pathOfLeastCostExists.text == "No")
        XCTAssertTrue(vc.leastCost.text == "0")
        XCTAssertTrue(vc.leastCostPath.text == expectedPath)
    }
    
    func testGetLeastCostPathForSample9 ()  //First cell > 50
    {
        let input = "60 3 3 6\n6 3 7 9\n5 6 8 3"
        let expectedPath = "[3, 2, 1, 3]"
        let vc = getViewControllerFromStoryBoard ()
        _ = vc.view
        vc.getLeastCostPath(input: input)
        XCTAssertTrue(vc.pathOfLeastCostExists.text == "Yes")
        XCTAssertTrue(vc.leastCost.text == "14")
        XCTAssertTrue(vc.leastCostPath.text == expectedPath)
    }
    
    func testGetLeastCostPathForSample10 ()  // -ve values
    {
        let input = "60 3 -5 9\n-5 2 4 10\n3 -2 6 10\n6 -1 -2 10"
        let expectedPath = "[2, 3, 4, 1]"
        let vc = getViewControllerFromStoryBoard ()
        _ = vc.view
        vc.getLeastCostPath(input: input)
        XCTAssertTrue(vc.pathOfLeastCostExists.text == "Yes")
        XCTAssertTrue(vc.leastCost.text == "0")
        XCTAssertTrue(vc.leastCostPath.text == expectedPath)
    }
    
    func testGetLeastCostPathForSample11 ()  // 4*2 matrix
    {
        let input = "51 51\n0 51\n51 51\n5 5"
        let expectedPath = "[4, 4]"
        let vc = getViewControllerFromStoryBoard ()
        _ = vc.view
        vc.getLeastCostPath(input: input)
        XCTAssertTrue(vc.pathOfLeastCostExists.text == "Yes")
        XCTAssertTrue(vc.leastCost.text == "10")
        XCTAssertTrue(vc.leastCostPath.text ==  expectedPath)
    }
    
    func testGetLeastCostPathForSample12 ()  // 4*3 matrix
    {
        let input = "51 51 51\n0 51 51\n51 51 51 \n5 5 51"
        let expectedPath = "[4, 4]"
        let vc = getViewControllerFromStoryBoard ()
        _ = vc.view
        vc.getLeastCostPath(input: input)
        XCTAssertTrue(vc.pathOfLeastCostExists.text == "No")
        XCTAssertTrue(vc.leastCost.text == "10")
        XCTAssertTrue(vc.leastCostPath.text ==  expectedPath)
    }
    
    func testGetLeastCostPathForSample13 ()  // 2*20 matrix
    {
        let input = "1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1\n2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2"
        let expectedPath = "[1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]"
        let vc = getViewControllerFromStoryBoard ()
        _ = vc.view
        vc.getLeastCostPath(input: input)
        XCTAssertTrue(vc.pathOfLeastCostExists.text == "Yes")
        XCTAssertTrue(vc.leastCost.text == "20")
        XCTAssertTrue(vc.leastCostPath.text == expectedPath)
    }
    
    fileprivate func getViewControllerFromStoryBoard () -> LowestTotalCostViewController
    {
        let storyboard = UIStoryboard(name: "Main", bundle:Bundle.main)
        return (storyboard.instantiateViewController(withIdentifier: "LowestTotalCostViewController") as! LowestTotalCostViewController)
    }
}
