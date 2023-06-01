//
//  AllSportsMockApiTests.swift
//  SportiverseTests
//
//  Created by Ramy Ashraf on 01/06/2023.
//

import XCTest
@testable import Sportiverse

final class AllSportsMockApiTests: XCTestCase {

    var mockAPI: AllSportAPIServiceMock! = nil
    
    override func setUp() {
        mockAPI = AllSportAPIServiceMock(decoder: DecoderUtil())
    }
    
    // MARK: - getLeagues Tests
    
    func testDecodeLeagues_mockResponseWithFourEvents_ReturnsLeagues() {
        let expectation = XCTestExpectation(description: "Completion called")
        
        mockAPI.getLeagues(of: "football", onCompletion: { result in
            switch result {
            case .success(let leagues):
                XCTAssertTrue(leagues.count == 4, "Expected non-empty league list")
            case .failure(_):
                XCTFail()
            }
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    
    
    // MARK: - getUpcomingEvents Tests
    
    func testDecodeUpcomingEvents_mockResponseWithThreeEvents_ReturnsEvents() {
        let expectation = XCTestExpectation(description: "Completion called")
        
        mockAPI.getUpcomingEvents(of: "tennis", leagueID: 123, from: "2023-06-01", to: "2023-06-30", onCompletion: { result in
            switch result {
            case .success(let events):
                XCTAssertTrue(events.count == 3, "Expected non-empty event list")
            case .failure(_):
                XCTFail()
            }

            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: 5.0)
    }
    

    
    // MARK: - getLivescores Tests
    
    func testDecodeLivescores_mockResponseWithThreeEvents_ReturnsEvents() {
        let expectation = XCTestExpectation(description: "Completion called")
        
        mockAPI.getLivescores(of: "football", leagueID: 123, onCompletion: { result in
            switch result {
            case .success(let events):
                XCTAssertTrue(events.count == 3, "Expected non-empty event list")
            case .failure(_):
                    XCTFail()
            }
            
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    
    // MARK: - getTeams Tests
    
    func testDecodeTeams_mockResponseWithTwoTeams_ReturnsTwoTeams() {
        let expectation = XCTestExpectation(description: "Completion called")
        
        mockAPI.getTeams(of: "", leagueID: 0, onCompletion: { result in
            switch result {
            case .success(let teams):
                XCTAssertTrue(teams.count == 2, "Expected non-empty team list")
            case .failure(_):
                XCTFail()
            }
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: 5.0)
    }
    
}
