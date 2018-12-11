//
//  ViewController.swift
//  SingleViewAppSwiftTemplate
//
//  Created by Treehouse on 12/8/16.
//  Copyright © 2016 Treehouse. All rights reserved.
//

import UIKit

let NUMBER_OF_ROUNDS = 3
let NUMBER_OF_SECONDS_FOR_TIMER = 15

class ViewController: UIViewController {

    
    @IBOutlet weak var firstEventLabel: UILabel!
    @IBOutlet weak var secondEventLabel: UILabel!
    @IBOutlet weak var thirdEventLabel: UILabel!
    @IBOutlet weak var fourthEventLabel: UILabel!
    @IBOutlet weak var buttonNextRound: UIButton!
    @IBOutlet weak var timerLabel: UILabel!
    
    @IBOutlet weak var firstButtonFromTop: UIButton!
    @IBOutlet weak var secondButtonFromTop: UIButton!
    @IBOutlet weak var thirdButtonFromTop: UIButton!
    @IBOutlet weak var fourthButtonFromTop: UIButton!
    @IBOutlet weak var fifthButtonFromTop: UIButton!
    @IBOutlet weak var sixthButtonFromTop: UIButton!
    
    var game: BoutGame
    var event: HistoricalEventsProvider?
    // https://teamtreehouse.com/community/swift-countdown-timer-of-60-seconds
    var countDownTimer: Timer!
    var totalTime: Int
    
    required init?(coder aDecoder: NSCoder) {
        do{
            let boutGame = try BoutGame(totalRounds: NUMBER_OF_ROUNDS, timer: NUMBER_OF_SECONDS_FOR_TIMER)
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
        game.endGameActionsDelegate = self
        let result = game.checkHistoricalOrderCorrectness(of: game.historicalEventsForOneRound)
        timerLabel.text = timeFormatted(game.timer)
        print("result : \(result)")
        startTimer()
        buttonNextRound.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: ACTIONS SECTION
    // TODO: refactor with one helper function
    @IBAction func exchangeEvents(_ sender: UIButton) {
        print(game.historicalEventsForOneRound)
        if sender.tag == 1 {
            let stringHelpingForInterchange = firstEventLabel.text
            firstEventLabel.text = secondEventLabel.text
            secondEventLabel.text = stringHelpingForInterchange
            
//            let historicalEventForInterchange = game.historicalEventsForOneRound[0]
//            game.historicalEventsForOneRound[0] = game.historicalEventsForOneRound[1]
//            game.historicalEventsForOneRound[1] = historicalEventForInterchange
//
            (game.historicalEventsForOneRound[0],  game.historicalEventsForOneRound[1]) = (game.historicalEventsForOneRound[1],  game.historicalEventsForOneRound[0])
        }
        else if sender.tag == 2{
            let stringHelpingForInterchange = firstEventLabel.text
            firstEventLabel.text = secondEventLabel.text
            secondEventLabel.text = stringHelpingForInterchange
            
//            let historicalEventForInterchange = game.historicalEventsForOneRound[0]
//            game.historicalEventsForOneRound[0] = game.historicalEventsForOneRound[1]
//            game.historicalEventsForOneRound[1] = historicalEventForInterchange
            
                        (game.historicalEventsForOneRound[0],  game.historicalEventsForOneRound[1]) = (game.historicalEventsForOneRound[1],  game.historicalEventsForOneRound[0])
        }
        else if sender.tag == 3{
            let stringHelpingForInterchange = secondEventLabel.text
            secondEventLabel.text = thirdEventLabel.text
            thirdEventLabel.text = stringHelpingForInterchange
            
//            let historicalEventForInterchange = game.historicalEventsForOneRound[1]
//            game.historicalEventsForOneRound[1] = game.historicalEventsForOneRound[2]
//            game.historicalEventsForOneRound[2] = historicalEventForInterchange
            
                        (game.historicalEventsForOneRound[1],  game.historicalEventsForOneRound[2]) = (game.historicalEventsForOneRound[2],  game.historicalEventsForOneRound[1])
        }
        else if sender.tag == 4{
            let stringHelpingForInterchange = secondEventLabel.text
            secondEventLabel.text = thirdEventLabel.text
            thirdEventLabel.text = stringHelpingForInterchange
            
//            let historicalEventForInterchange = game.historicalEventsForOneRound[1]
//            game.historicalEventsForOneRound[1] = game.historicalEventsForOneRound[2]
//            game.historicalEventsForOneRound[2] = historicalEventForInterchange
            
                                    (game.historicalEventsForOneRound[1],  game.historicalEventsForOneRound[2]) = (game.historicalEventsForOneRound[2],  game.historicalEventsForOneRound[1])
        }
        else if sender.tag == 5{
            let stringHelpingForInterchange = thirdEventLabel.text
            thirdEventLabel.text = fourthEventLabel.text
            fourthEventLabel.text = stringHelpingForInterchange
            
//            let historicalEventForInterchange = game.historicalEventsForOneRound[2]
//            game.historicalEventsForOneRound[2] = game.historicalEventsForOneRound[3]
//            game.historicalEventsForOneRound[3] = historicalEventForInterchange
            
                                    (game.historicalEventsForOneRound[2],  game.historicalEventsForOneRound[3]) = (game.historicalEventsForOneRound[3],  game.historicalEventsForOneRound[2])
        }
        else{
            let stringHelpingForInterchange = thirdEventLabel.text
            thirdEventLabel.text = fourthEventLabel.text
            fourthEventLabel.text = stringHelpingForInterchange
//
//            let historicalEventForInterchange = game.historicalEventsForOneRound[2]
//            game.historicalEventsForOneRound[2] = game.historicalEventsForOneRound[3]
//            game.historicalEventsForOneRound[3] = historicalEventForInterchange
            
            (game.historicalEventsForOneRound[2],  game.historicalEventsForOneRound[3]) = (game.historicalEventsForOneRound[3],  game.historicalEventsForOneRound[2])
        }
    }
    
    @IBAction func nextRound(_ sender: UIButton) {
        // Interface
        buttonNextRound.isHidden = true
        timerLabel.isHidden = false
        firstButtonFromTop.isEnabled = true
        secondButtonFromTop.isEnabled = true
        thirdButtonFromTop.isEnabled = true
        fourthButtonFromTop.isEnabled = true
        fifthButtonFromTop.isEnabled = true
        sixthButtonFromTop.isEnabled = true
        
        // init, start counter
        timerLabel.text = timeFormatted(game.timer)
        self.totalTime = game.timer
        startTimer()
        
        // get new questions and populate labels
        populateLabelWithHistoricalEvents()
        
    }
    
    // MARK: HELPER FUNCTIONS SECTION
    // TODO: refactor events as arguments
    func populateLabelWithHistoricalEvents(){
        game.historicalEventsForOneRound = game.historicalEvents.provide(numberOfRandomEvents: 4);
        firstEventLabel.text = game.historicalEventsForOneRound[0].event + " " + game.historicalEventsForOneRound[0].year
        secondEventLabel.text = game.historicalEventsForOneRound[1].event + " " + game.historicalEventsForOneRound[1].year
        thirdEventLabel.text = game.historicalEventsForOneRound[2].event + " " + game.historicalEventsForOneRound[2].year
        fourthEventLabel.text = game.historicalEventsForOneRound[3].event + " " + game.historicalEventsForOneRound[3].year
    }

}

// MARK: TIMER IMPLEMENTATION SECTION
extension ViewController {
    
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
        // Verify answers delegate
        if game.currentRound != NUMBER_OF_ROUNDS {
            game.endGameActionsDelegate!.roundDidFinish()
        }else{
            game.endGameActionsDelegate!.gameDidFinish()
        }
    }
    
    // TODO: fix problem at start up of counter
    func timeFormatted(_ totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds
        return String(format: "00:%02d", seconds)
    }
}

 // MARK: PROTOCOL IMPLEMENTATION SECTION
extension ViewController: EndGameActionsDelegate {

    func roundDidFinish() {
        let isCorrectOrder = game.checkHistoricalOrderCorrectness(of: game.historicalEventsForOneRound)
        let nameOfImage: String = isCorrectOrder == true ? "next_round_success" : "next_round_fail"
        
        // Invalidate buttons, hide timer, show next round button
        buttonNextRound.isHidden = false
        timerLabel.isHidden = true
        firstButtonFromTop.isEnabled = false
        secondButtonFromTop.isEnabled = false
        thirdButtonFromTop.isEnabled = false
        fourthButtonFromTop.isEnabled = false
        fifthButtonFromTop.isEnabled = false
        sixthButtonFromTop.isEnabled = false
        buttonNextRound.setImage(UIImage(named: nameOfImage)!, for: .normal)
        
        if isCorrectOrder{
            game.correctAnswers += 1
        }
        
        game.currentRound += 1

    }
    
    func gameDidFinish() {
        let endGameViewController = storyboard?.instantiateViewController(withIdentifier: "EndGameViewController") as! EndGameViewController
        present(endGameViewController, animated: true, completion: nil)
        
    }
}

