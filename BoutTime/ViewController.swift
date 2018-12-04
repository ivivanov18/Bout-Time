//
//  ViewController.swift
//  SingleViewAppSwiftTemplate
//
//  Created by Treehouse on 12/8/16.
//  Copyright © 2016 Treehouse. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    

    @IBOutlet weak var firstEventLabel: UILabel!
    @IBOutlet weak var secondEventLabel: UILabel!
    @IBOutlet weak var thirdEventLabel: UILabel!
    @IBOutlet weak var fourthEventLabel: UILabel!

    var game = BoutGame(totalRounds: 6, timer: 60)
    
    var event: HistoricalEventsProvider?
    
    required init?(coder aDecoder: NSCoder) {
        if let event = HistoricalEventsProvider(){
            super.init(coder: aDecoder)
            self.event = event
        }
        fatalError("Problem initializing")
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       
        //print("game:   \(event!.historicalEvents.count)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

