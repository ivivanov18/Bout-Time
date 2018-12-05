//
//  Game.swift
//  SingleViewAppSwiftTemplate
//
//  Created by ivan ivanov on 21/09/2018.
//  Copyright © 2018 Treehouse. All rights reserved.
//

import Foundation

enum GameError: Error{
    case noEventsProvided
}

protocol Game{
    var totalRounds: Int {get}
    var currentRound: Int {get set}
    var correctAnswers: Int {get set}
    var timer: Int {get set}
}


class BoutGame: Game{
    var totalRounds: Int
    var currentRound: Int
    var correctAnswers: Int
    var timer: Int
    
    var historicalEvents: HistoricalEventsProvider
    
    init(totalRounds: Int, timer: Int) throws{
        guard let events = HistoricalEventsProvider() else{
            throw GameError.noEventsProvided
        }
        self.historicalEvents = events
        self.totalRounds = totalRounds
        self.timer = timer
        self.correctAnswers = 0
        self.currentRound = 1
    }
    
    // Function that checks whether game is over or not
    // is currentRound > totalRounds
    func isGameOver() -> Bool{
        return currentRound > totalRounds ? true : false
    }
    
    
}
