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
    var score: Int {get set}
    var timer: Int {get set}
}


class BoutGame: Game{
    var totalRounds: Int
    var currentRound: Int
    var score: Int
    var timer: Int
    
    var historicalEvents: HistoricalEventsProvider
    
    init(totalRounds: Int, timer: Int){
        guard let events = HistoricalEventsProvider() else{
            fatalError()
        }
        self.historicalEvents = events
        self.totalRounds = totalRounds
        self.timer = timer
        self.score = 0
        self.currentRound = 1
    }
    
    
}
