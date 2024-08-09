//
//  FlowTest.swift
//  QuizEngineTests
//
//  Created by Fauzi Arda on 08/08/24.
//

import Foundation
import XCTest
@testable import QuizEngine
class FlowTest: XCTestCase {
    let router = RouterSpy()
    
    func test_start_withNoQuestion_doesNotRouteToQuestion() {
        let sut = makeSUT(questions: [])
        
        sut.start()
        
        XCTAssertTrue(router.routedQuestions.isEmpty)
    }
    
    func test_start_withOneQuestion_routeToCorrectQuestion() {
        let sut = makeSUT(questions: ["Q1"])
        
        sut.start()
        
        XCTAssertEqual(router.routedQuestions, ["Q1"])
    }
    
    func test_start_withOneQuestion_routeToCorrectQuestion_2() {
        let sut = makeSUT(questions: ["Q2"])
        
        sut.start()
        
        XCTAssertEqual(router.routedQuestions, ["Q2"])
    }
    
    func test_start_withTwoQuestion_routeToFirstQuestion() {
        let sut = makeSUT(questions: ["Q1","Q2"])
        
        sut.start()
        
        XCTAssertEqual(router.routedQuestions, ["Q1"])
    }
    
    func test_startTwice_withTwoQuestion_routeToFirstQuestionTwice() {
        let sut = makeSUT(questions: ["Q1","Q2"])
        
        sut.start()
        sut.start()
        
        XCTAssertEqual(router.routedQuestions, ["Q1","Q1"])
    }
    
    func test_startAndAnswerFirstAndSecondQuestion_withThreeQuestion_routeToSecondAndThirdQuestion() {
        let sut = makeSUT(questions: ["Q1","Q2","Q3"])
        
        sut.start()
        router.answerCallback("A1")
        router.answerCallback("A2")
        
        XCTAssertEqual(router.routedQuestions, ["Q1","Q2","Q3"])
    }
    
    func test_startAndAnswerFirstQuestion_withOnlyOneQuestion_doesNotRouteToAnotherQuestion() {
        let sut = makeSUT(questions: ["Q1"])
        
        sut.start()
        router.answerCallback("A1")
        
        XCTAssertEqual(router.routedQuestions, ["Q1"])
    }
    
    func test_start_withNoQuestion_routeToResult() {
        let sut = makeSUT(questions: [])
        
        sut.start()
        
        XCTAssertEqual(router.routedResults, [:])
    }
    
    func test_start_withOneQuestion_doesNotRouteToResult() {
        let sut = makeSUT(questions: ["Q1"])
        
        sut.start()
        
        XCTAssertNil(router.routedResults)
    }
    
    func test_startAndAnswerFirstQuestion_withTwoQuestions_doesNotRouteToResult() {
        let sut = makeSUT(questions: ["Q1","Q2"])
        
        sut.start()
        router.answerCallback("A1")
        
        XCTAssertNil(router.routedResults)
    }
    
    func test_startAndAnswerFirstAndSecondQuestion_withTwoQuestions_routeToResult() {
        let sut = makeSUT(questions: ["Q1","Q2"])
        
        sut.start()
        router.answerCallback("A1")
        router.answerCallback("A2")
        
        XCTAssertEqual(router.routedResults, ["Q1": "A1", "Q2":"A2"])
    }
    
    // MARK: Helpers
    func makeSUT(questions: [String]) -> Flow {
        return Flow(questions: questions, router: router)
    }
    
    class RouterSpy: Router {
        var routedQuestions: [String] = []
        var routedResults: [String: String]? = nil
        var answerCallback: AnswerCallback = {_ in }
        
        func routeTo(question: String, answerCallback: @escaping AnswerCallback) {
            routedQuestions.append(question)
            self.answerCallback = answerCallback
        }
        
        func routeTo(result: [String : String]) {
            self.routedResults = result
        }
    }
}
