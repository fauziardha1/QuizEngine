//
//  Flow.swift
//  QuizEngine
//
//  Created by Fauzi Arda on 08/08/24.
//

import Foundation

protocol Router {
    typealias AnswerCallback = (String) -> Void
    func routeTo(question: String, answerCallback: @escaping AnswerCallback)
    func routeTo(result: [String: String])
}

class Flow {
    private let router: Router
    private let questions: [String]
    private var results: [String: String] = [:]
    
    init(questions: [String], router: Router) {
        self.router = router
        self.questions = questions
    }
    
    func start() {
        if let question = questions.first {
            router.routeTo(question: question, answerCallback: routeNext(from: question))
        } else {
            router.routeTo(result: results)
        }
    }
    
    private func routeNext(from question: String) -> Router.AnswerCallback {
        return { [weak self] answer in
            guard let self else {return}
            
            if let currentQuestionIndex = self.questions.firstIndex(of: question) {
                self.results[question] = answer
                if currentQuestionIndex+1 < self.questions.count {
                    let nextQuestion = self.questions[currentQuestionIndex+1]
                    self.router.routeTo(question: nextQuestion, answerCallback: self.routeNext(from: nextQuestion) )
                } else {
                    self.router.routeTo(result: self.results)
                }
            }
        }
    }
}
