//
//  Game.swift
//  
//
//  Created by Fauzi Arda on 01/10/24.
//

import Foundation

public class Game<Question: Hashable, Answer, R: Router> where R.Question == Question, R.Answer == Answer {
    let flow: Flow<Question, Answer, R>
    
    init(flow: Flow<Question,Answer, R> ) {
        self.flow = flow
    }
    
}

public func startGame<Question: Hashable, Answer:Equatable, R: Router>(questions: [Question], router: R, correctAnswer: [Question: Answer]) -> Game<Question,Answer,R> where R.Question == Question, R.Answer == Answer {
    let flow = Flow(questions: questions, router: router, scoring: {scoring($0, correctAnswer: correctAnswer)} )
    flow.start()
    return Game(flow: flow)
}

public func scoring<Question: Hashable, Answer: Equatable>(_ answer: [Question: Answer], correctAnswer: [Question: Answer]) -> Int {
    return answer.reduce(0) { (score, tuple) in
        return score + (correctAnswer[tuple.key] == tuple.value ? 1 : 0)
    }
}
