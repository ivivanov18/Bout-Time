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
        super.init(coder: aDecoder)

        if let event = HistoricalEventsProvider(){
            self.event = event
        }else{
            fatalError("problem loading file hence fatal error")
        }
        
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

    
    @IBAction func exchangeEvents(_ sender: UIButton) {
        if sender.tag == 1 {
            print("Button on the top")
        }
        else if sender.tag == 2{
            print("Second button from top")
        }
        else if sender.tag == 3{
            print("Third button from top")
        }
        else if sender.tag == 4{
            print("Fourth button from top")
        }
        else if sender.tag == 5{
            print("Fifth button from top")
        }
        else{
            print("First button from bottom or sixth from top")
        }
    }
}

