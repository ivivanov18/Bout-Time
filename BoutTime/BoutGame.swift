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
    
    //TODO: take historicalEventsProvider out of this class - just use method to provide necessary
    // events for one round
    var historicalEvents: HistoricalEventsProvider
    var historicalEventsForOneRound: [HistoricalEvent]
    
    init(totalRounds: Int, timer: Int) throws{
        guard let events = HistoricalEventsProvider() else{
            throw GameError.noEventsProvided
        }
        self.historicalEvents = events
        self.totalRounds = totalRounds
        self.timer = timer
        self.correctAnswers = 0
        self.currentRound = 1
        self.historicalEventsForOneRound = []
    }
    
    // Function that checks whether game is over or not
    // is currentRound > totalRounds
    func isGameOver() -> Bool{
        return currentRound > totalRounds ? true : false
    }
    
    // TODO: Comment
    func startGame(){
        correctAnswers = 0
        currentRound = 1
    }
    
    //
    func checkHistoricalOrderCorrectness(of events: [HistoricalEvent]) -> Bool{
        for i in 0 ..< events.count - 1{
            if let firstEventYear = Int(events[i].year), let secondEventYear = Int(events[i+1].year){
                if firstEventYear < secondEventYear{
                    continue
                }else{
                    return false
                }
            }else{
                print("False in unwrapping")
                return false
            }
        }
        return true
    }

    
}
