//
//  Flow.swift
//  QuizEngine
//
//  Created by Fauzi Arda on 08/08/24.
//

import Foundation

protocol Router {
    associatedtype Question: Hashable
    associatedtype Answer
    func routeTo(question: Question, answerCallback: @escaping (Answer) -> Void )
    func routeTo(result: [Question: Answer])
}

class Flow <Question: Hashable,Answer, R: Router> where Question == R.Question, Answer == R.Answer {
    private let router: R
    private let questions: [Question]
    private var results: [Question: Answer] = [:]
    
    init(questions: [Question], router: R) {
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
    
    private func nextCallback(from question: Question) -> (Answer) -> Void {
        return { [weak self] in self?.routeNext(question, $0) }
    }
    
    private func routeNext(_ question: Question, _ answer: Answer) {
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
