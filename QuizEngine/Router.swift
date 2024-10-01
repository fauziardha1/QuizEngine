//
//  Router.swift
//  QuizEngine
//
//  Created by Fauzi Arda on 01/10/24.
//

import Foundation

public protocol Router {
    associatedtype Question: Hashable
    associatedtype Answer
    func routeTo(question: Question, answerCallback: @escaping (Answer) -> Void )
    func routeTo(result: Result<Question, Answer>)
}
