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
    @IBOutlet weak var timerLabel: UILabel!
    
    var game: BoutGame
    
    var event: HistoricalEventsProvider?
    // https://teamtreehouse.com/community/swift-countdown-timer-of-60-seconds
    var countDownTimer: Timer!
    var totalTime: Int
    
    required init?(coder aDecoder: NSCoder) {
        do{
            let boutGame = try BoutGame(totalRounds: 6, timer: 60)
            self.game = boutGame
            self.totalTime = boutGame.timer
            super.init(coder: aDecoder)
        }catch let error{
            fatalError("\(error)")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populateLabelWithHistoricalEvents()
        game.historicalEventsForOneRound = game.historicalEvents.provide(numberOfRandomEvents: 4)
        let result = game.checkHistoricalOrderCorrectness(of: game.historicalEventsForOneRound)
        print("result : \(result)")
        startTimer()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    // TODO: refactor with one helper function
    @IBAction func exchangeEvents(_ sender: UIButton) {
        if sender.tag == 1 {
            let stringHelpingForInterchange = firstEventLabel.text
            firstEventLabel.text = secondEventLabel.text
            secondEventLabel.text = stringHelpingForInterchange
            
            let historicalEventForInterchange = game.historicalEventsForOneRound[0]
            game.historicalEventsForOneRound[0] = game.historicalEventsForOneRound[1]
            game.historicalEventsForOneRound[1] = historicalEventForInterchange
        }
        else if sender.tag == 2{
            let stringHelpingForInterchange = firstEventLabel.text
            firstEventLabel.text = secondEventLabel.text
            secondEventLabel.text = stringHelpingForInterchange
            
            let historicalEventForInterchange = game.historicalEventsForOneRound[0]
            game.historicalEventsForOneRound[0] = game.historicalEventsForOneRound[1]
            game.historicalEventsForOneRound[1] = historicalEventForInterchange
        }
        else if sender.tag == 3{
            let stringHelpingForInterchange = secondEventLabel.text
            secondEventLabel.text = thirdEventLabel.text
            thirdEventLabel.text = stringHelpingForInterchange
            
            let historicalEventForInterchange = game.historicalEventsForOneRound[1]
            game.historicalEventsForOneRound[1] = game.historicalEventsForOneRound[2]
            game.historicalEventsForOneRound[2] = historicalEventForInterchange
        }
        else if sender.tag == 4{
            let stringHelpingForInterchange = secondEventLabel.text
            secondEventLabel.text = thirdEventLabel.text
            thirdEventLabel.text = stringHelpingForInterchange
            
            let historicalEventForInterchange = game.historicalEventsForOneRound[1]
            game.historicalEventsForOneRound[1] = game.historicalEventsForOneRound[2]
            game.historicalEventsForOneRound[2] = historicalEventForInterchange
        }
        else if sender.tag == 5{
            let stringHelpingForInterchange = thirdEventLabel.text
            thirdEventLabel.text = fourthEventLabel.text
            fourthEventLabel.text = stringHelpingForInterchange
            
            let historicalEventForInterchange = game.historicalEventsForOneRound[2]
            game.historicalEventsForOneRound[2] = game.historicalEventsForOneRound[3]
            game.historicalEventsForOneRound[3] = historicalEventForInterchange
        }
        else{
            let stringHelpingForInterchange = thirdEventLabel.text
            thirdEventLabel.text = fourthEventLabel.text
            fourthEventLabel.text = stringHelpingForInterchange
            
            let historicalEventForInterchange = game.historicalEventsForOneRound[2]
            game.historicalEventsForOneRound[2] = game.historicalEventsForOneRound[3]
            game.historicalEventsForOneRound[3] = historicalEventForInterchange
        }
    }
    
    // Helper function
    func populateLabelWithHistoricalEvents(){
        game.historicalEventsForOneRound = game.historicalEvents.provide(numberOfRandomEvents: 4);
        firstEventLabel.text = game.historicalEventsForOneRound[0].event + " " + game.historicalEventsForOneRound[0].year
        secondEventLabel.text = game.historicalEventsForOneRound[1].event + " " + game.historicalEventsForOneRound[1].year
        thirdEventLabel.text = game.historicalEventsForOneRound[2].event + " " + game.historicalEventsForOneRound[2].year
        fourthEventLabel.text = game.historicalEventsForOneRound[3].event + " " + game.historicalEventsForOneRound[3].year
    }
    
    // Code from Treehouse forum
    func startTimer() {
        countDownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    
    @objc func updateTime() {
        timerLabel.text = "\(timeFormatted(totalTime))"
        
        if totalTime != 0 {
            totalTime -= 1
        } else {
            endTimer()
        }
    }

    func endTimer() {
        countDownTimer.invalidate()
    }
    
    // TODO: fix problem at start up of counter
    func timeFormatted(_ totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds
        return String(format: "00:%02d", seconds)
    }

}

