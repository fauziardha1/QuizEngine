//
//  Game.swift
//  
//
//  Created by Fauzi Arda on 01/10/24.
//

import Foundation

public func startGame<Question: Hashable, Answer, R: Router>(questions: [Question], router: R, correctAnswer: [Question: Answer]) where R.Question == Question, R.Answer == Answer {
    
}
