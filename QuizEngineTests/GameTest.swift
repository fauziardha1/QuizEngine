//
//  GameTest.swift
//  QuizEngineTests
//
//  Created by Fauzi Arda on 01/10/24.
//

import Foundation
import XCTest
@testable import QuizEngine

class GameTest: XCTestCase {
    var game: Game<String, String, RouterSpy>?
    let router = RouterSpy()
    
    override func setUp() {
        super.setUp()
        game = startGame(questions: ["Q1","Q2"], router: router, correctAnswer: ["Q1": "A1", "Q2": "A2"])
    }
    
    func test_startGame_answerZeroOutOfTwoCorrect_scoreZero() {
        router.answerCallback("Wrong")
        router.answerCallback("wrong")
        
        XCTAssertEqual(router.routedResult?.score, 0)
    }
    
    func test_startGame_answerOneOutOfTwoCorrect_scoreOne() {
        router.answerCallback("A1")
        router.answerCallback("wrong")
        
        XCTAssertEqual(router.routedResult?.score, 1)
    }
    
    func test_startGame_asnwerTwoOutOfTwoCorrect_scoreTwo() {
        router.answerCallback("A1")
        router.answerCallback("A2")
        
        XCTAssertEqual(router.routedResult?.score, 2)
    }
}
