//
//  AllSportsAPIServiceTests.swift
//  SportiverseTests
//
//  Created by Ramy Ashraf on 01/06/2023.
//

import XCTest
@testable import Sportiverse
final class AllSportsAPIServiceTests: XCTestCase {
    
    var api: AllSportsAPIService! = nil
    
    override func setUp() {
        api = AllSportsAPIService.getInstance(decoder: DecoderUtil())
    }
    
    // MARK: - getLeagues Tests
    
    func testGetLeagues_SuccessfulRequest_ReturnsLeagues() {
        let expectation = XCTestExpectation(description: "Completion called")
        
        api.getLeagues(of: "football", onCompletion: { result in
            switch result {
            case .success(let leagues):
                XCTAssertFalse(leagues.isEmpty, "Expected non-empty league list")
            case .failure(_):
                XCTFail()
            }
            
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testGetLeagues_InvalidRequest_ReturnsFailure() {
    
        let expectation = XCTestExpectation(description: "Completion called")
        
        api.getLeagues(of: "InvalidSport", onCompletion: { result in
            switch result {
            case .success(_):
                XCTFail()
            case .failure(_):
                expectation.fulfill()
            }
        })
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    // MARK: - getUpcomingEvents Tests
    
    func testGetUpcomingEvents_SuccessfulRequest_ReturnsEvents() {
        let expectation = XCTestExpectation(description: "Completion called")
        
        api.getUpcomingEvents(of: "tennis", leagueID: 123, from: "2023-06-01", to: "2023-06-30", onCompletion: { result in
            switch result {
            case .success(let events):
                XCTAssertFalse(events.isEmpty, "Expected non-empty event list")
            case .failure(_):
                expectation.fulfill()
            }
        })
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testGetUpcomingEvents_InvalidRequest_ReturnsFailure() {
        let expectation = XCTestExpectation(description: "Completion called")
        
        api.getUpcomingEvents(of: "InvalidSport", leagueID: 123, from: "2023-06-01", to: "2023-06-30", onCompletion: { result in
            switch result {
            case .success(_):
                XCTFail()
            case .failure(_):
                expectation.fulfill()
            }
        })
        wait(for: [expectation], timeout: 5.0)
    }
    
    // MARK: - getLivescores Tests
    
    func testGetLivescores_SuccessfulRequest_ReturnsEvents() {
        let expectation = XCTestExpectation(description: "Completion called")
        
        api.getLivescores(of: "football", leagueID: 123, onCompletion: { result in
            switch result {
            case .success(let events):
                XCTAssertFalse(events.isEmpty, "Expected non-empty event list")
            case .failure(let error):
                switch error {
                case AllSportsAPIService.APIError.emptyList:
                    expectation.fulfill()
                default:
                    XCTFail()
                }
                
            }
            
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testGetLivescores_InvalidRequest_ReturnsFailure() {
        let expectation = XCTestExpectation(description: "Completion called")
        
        api.getLivescores(of: "InvalidSport", leagueID: 123, onCompletion: { result in
            switch result {
            case .success(_):
                XCTFail()
            case .failure(_):
                expectation.fulfill()
            }
            
        })
        wait(for: [expectation], timeout: 5.0)
    }
    
    // MARK: - getTeams Tests
    
    func testGetTeams_SuccessfulRequest_ReturnsTeams() {
        let expectation = XCTestExpectation(description: "Completion called")
        
        api.getTeams(of: "cricket", leagueID: 123, onCompletion: { result in
            switch result {
            case .success(let teams):
                XCTAssertFalse(teams.isEmpty, "Expected non-empty team list")
            case .failure(_):
                expectation.fulfill()
            }
        })
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testGetTeams_InvalidRequest_ReturnsFailure() {
        let expectation = XCTestExpectation(description: "Completion called")
        
        api.getTeams(of: "InvalidSport", leagueID: 123, onCompletion: { result in
            switch result {
            case .success(_):
                XCTFail()
            case .failure(_):
                expectation.fulfill()
            }
            
        })
        
        wait(for: [expectation], timeout: 5.0)
    }
}
