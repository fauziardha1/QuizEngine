//
//  Result.swift
//  QuizEngine
//
//  Created by Fauzi Arda on 01/10/24.
//

import Foundation

struct Result<Question: Hashable, Answer> {
    let answers: [Question: Answer]
    let score: Int
}
