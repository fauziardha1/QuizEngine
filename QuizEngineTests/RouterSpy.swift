//
//  RouterSpy.swift
//  QuizEngineTests
//
//  Created by Fauzi Arda on 01/10/24.
//

import Foundation
@testable import QuizEngine

class RouterSpy: Router {
    var routedQuestions: [String] = []
    var routedResult: Result<String, String>? = nil
    var answerCallback: (Answer) -> Void = {_ in }
    
    func routeTo(question: String, answerCallback: @escaping (Answer) -> Void) {
        routedQuestions.append(question)
        self.answerCallback = answerCallback
    }
    
    func routeTo(result: Result<String, String>) {
        self.routedResult = result
    }
}
