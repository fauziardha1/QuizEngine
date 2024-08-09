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
            router.routeTo(question: question, answerCallback: nextCallback(from: question))
        } else {
            router.routeTo(result: results)
        }
    }
    
    private func nextCallback(from question: String) -> Router.AnswerCallback {
        return { [weak self] in self?.routeNext(question, $0) }
    }
    
    private func routeNext(_ question: String, _ answer: String) {
        if let currentQuestionIndex = self.questions.firstIndex(of: question) {
            results[question] = answer
            let nextQuestionIndex = currentQuestionIndex + 1
            if nextQuestionIndex < questions.count {
                let nextQuestion = questions[nextQuestionIndex]
                router.routeTo(question: nextQuestion, answerCallback: nextCallback(from: nextQuestion) )
            } else {
                router.routeTo(result: results)
            }
        }
    }
}
