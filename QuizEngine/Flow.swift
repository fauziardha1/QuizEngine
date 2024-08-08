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
}

class Flow {
    private let router: Router
    private let questions: [String]
    
    init(questions: [String], router: Router) {
        self.router = router
        self.questions = questions
    }
    
    func start() {
        guard let question = questions.first else { return }
        router.routeTo(question: question, answerCallback: routeNext(from: question))
    }
    
    private func routeNext(from question: String) -> Router.AnswerCallback {
        return { [weak self] _ in
            guard let self else {return}
            guard let currentQuestionIndex = self.questions.firstIndex(of: question) else { return }
            guard currentQuestionIndex+1 < self.questions.count else { return }
            let nextQuestion = self.questions[currentQuestionIndex+1]
            self.router.routeTo(question: nextQuestion, answerCallback: self.routeNext(from: nextQuestion) )
        }
    }
}
