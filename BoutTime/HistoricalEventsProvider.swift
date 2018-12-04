//
//  HistoricalEvents.swift
//  SingleViewAppSwiftTemplate
//
//  Created by ivan ivanov on 21/09/2018.
//  Copyright © 2018 Treehouse. All rights reserved.
//

import Foundation

enum EventErrors: Error{
    case invalidResource
    case conversionFailure
}

class HistoricalEventsProvider{
    var historicalEvents: [HistoricalEvent]
    
    init?(){
        do{
            let dictionary = try PlistConverter.arrayOfdictionaries(fromFile: "HistoricalEvents", ofType: "plist")
            
            let historicalEvents  = try EventsUnarchiver.makeEvents(from: dictionary)
            
            self.historicalEvents = historicalEvents
        }catch let error{
            return nil
        }
    }
}


class PlistConverter{
    static func arrayOfdictionaries(fromFile name: String, ofType type: String) throws -> [[String: String]]{
        guard let path = Bundle.main.path(forResource: name, ofType: type) else{
            throw EventErrors.invalidResource
        }
        
        guard let arrayOfDictionaries = NSArray(contentsOfFile: path) as? [[String: String]] else{
            throw EventErrors.conversionFailure
        }
        
        return arrayOfDictionaries
    }
}

class EventsUnarchiver{
    static func makeEvents(from arrayOfdictionaries: [[String: String]]) throws -> [HistoricalEvent]{
        
        var events: [HistoricalEvent] = []
        
        for dictionary in arrayOfdictionaries{
            if let year = dictionary["year"], let event = dictionary["event"], let url = dictionary["url"]{
                let historicalEvent = HistoricalEvent(event: event, year: year, url: url)
                print(historicalEvent.event)
                print(historicalEvent.year)
                print(historicalEvent.url)
                events.append(historicalEvent)
            }
        }
        
        return events
    }
}
