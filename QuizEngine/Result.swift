//
//  Result.swift
//  QuizEngine
//
//  Created by Fauzi Arda on 01/10/24.
//

import Foundation

public struct Result<Question: Hashable, Answer> {
    public let answers: [Question: Answer]
    public let score: Int
}
