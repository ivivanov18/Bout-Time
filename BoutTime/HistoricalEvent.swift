//
//  HistoricalEvent.swift
//  SingleViewAppSwiftTemplate
//
//  Created by ivan ivanov on 20/09/2018.
//  Copyright © 2018 Treehouse. All rights reserved.
//

import Foundation


protocol Event{
    var event: String {get }
    var year: String {get}
    var url: String? {get }
    
}

struct HistoricalEvent: Event{
    
    var event: String
    var year: String
    var url: String?
    
}
