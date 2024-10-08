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
    
    func test_startGame_oneOutOfTwoCorrect_score1() {
        let router = RouterSpy()
        startGame(questions: ["Q1","Q2"], router: router, correctAnswer: ["Q1": "A1", "Q2": "A2"])
        
        router.answerCallback("A1")
        router.answerCallback("wrong")
        
        XCTAssertEqual(router.routedResult?.score, 1)
    }
}
