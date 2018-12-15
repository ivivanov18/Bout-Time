//
//  ViewController.swift
//  SingleViewAppSwiftTemplate
//
//  Created by Treehouse on 12/8/16.
//  Copyright © 2016 Treehouse. All rights reserved.
//

import UIKit

let NUMBER_OF_ROUNDS = 3
let NUMBER_OF_SECONDS_FOR_TIMER = 10

struct DataEndGame{
    let numberOfRounds: Int
    let numberOfCorrectAnswers: Int
    let initGameDelegate: InitGameDelegate
}


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
        
        timerLabel.text = timeFormatted(game.timer)
        startTimer()
        
        buttonNextRound.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: ACTIONS SECTION
    @IBAction func exchangeEvents(_ sender: UIButton) {
        if sender.tag == 1 {
            swapTextField(of: firstEventLabel, withTextFieldOf: secondEventLabel)
            swapElementAtIndex(0, withElementFromIndex: 1)
        }
        else if sender.tag == 2{
            swapTextField(of: firstEventLabel, withTextFieldOf: secondEventLabel)
            swapElementAtIndex(0, withElementFromIndex: 1)
        }
        else if sender.tag == 3{
            swapTextField(of: secondEventLabel, withTextFieldOf: thirdEventLabel)
            swapElementAtIndex(1, withElementFromIndex: 2)
        }
        else if sender.tag == 4{
            swapTextField(of: secondEventLabel, withTextFieldOf: thirdEventLabel)
            swapElementAtIndex(1, withElementFromIndex: 2)
        }
        else if sender.tag == 5{
            swapTextField(of: thirdEventLabel, withTextFieldOf: fourthEventLabel)
            swapElementAtIndex(2, withElementFromIndex: 3)
        }
        else{
            swapTextField(of: thirdEventLabel, withTextFieldOf: fourthEventLabel)
            swapElementAtIndex(2, withElementFromIndex: 3)
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
        
        game.isRoundOver = false
        
        // init, start counter
        timerLabel.text = timeFormatted(game.timer)
        self.totalTime = game.timer
        startTimer()
        
        // get new questions and populate labels
        populateLabelWithHistoricalEvents()
        
    }
    
    // MARK: HELPER FUNCTIONS SECTION
    // TODO: delete year hint at end
    func populateLabelWithHistoricalEvents(){
        game.historicalEventsForOneRound = game.historicalEvents.provide(numberOfRandomEvents: 4);
        firstEventLabel.text = game.historicalEventsForOneRound[0].event + " " + game.historicalEventsForOneRound[0].year
        secondEventLabel.text = game.historicalEventsForOneRound[1].event + " " + game.historicalEventsForOneRound[1].year
        thirdEventLabel.text = game.historicalEventsForOneRound[2].event + " " + game.historicalEventsForOneRound[2].year
        fourthEventLabel.text = game.historicalEventsForOneRound[3].event + " " + game.historicalEventsForOneRound[3].year
    }
    
    func swapElementAtIndex(_ index: Int, withElementFromIndex fromIndex: Int){
        
         (game.historicalEventsForOneRound[index],  game.historicalEventsForOneRound[fromIndex]) = (game.historicalEventsForOneRound[fromIndex], game.historicalEventsForOneRound[index])
    }
    
    
    func swapTextField(of firstLabel: UILabel, withTextFieldOf secondLabel: UILabel){
        let stringHelpingForInterchange = firstLabel.text
        firstLabel.text = secondLabel.text
        secondLabel.text = stringHelpingForInterchange
    }
    
}

// MARK: TIMER IMPLEMENTATION SECTION
// Code from TREEHOUSE FORUM https://teamtreehouse.com/community/swift-countdown-timer-of-60-seconds
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
            endRound()
        }
    }
    
    func endTimer() {
        countDownTimer.invalidate()

    }
    
    func timeFormatted(_ totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds
        return String(format: "00:%02d", seconds)
    }
}

 // MARK: EndGameActionsDelegate PROTOCOL IMPLEMENTATION SECTION
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
        let isCorrectOrder = game.checkHistoricalOrderCorrectness(of: game.historicalEventsForOneRound)
        
        if isCorrectOrder{
            game.correctAnswers += 1
        }
        
        let endGameViewController = storyboard?.instantiateViewController(withIdentifier: "EndGameViewController") as! EndGameViewController
        endGameViewController.dataEndGameToDisplay = DataEndGame(numberOfRounds: game.totalRounds, numberOfCorrectAnswers: game.correctAnswers, initGameDelegate: self)
        present(endGameViewController, animated: true, completion: nil)
        
    }
    
    func endRound(){
        // Verify answers delegate
        game.isRoundOver = true
        if game.currentRound != NUMBER_OF_ROUNDS {
            game.endGameActionsDelegate!.roundDidFinish()
        }else{
            game.endGameActionsDelegate!.gameDidFinish()
        }
    }
}

// MARK: InitGameDelegate PROTOCOL IMPLEMENTATION SECTION
extension ViewController: InitGameDelegate{
    func initGame() {
        game.correctAnswers = 0
        game.currentRound = 1
        game.isRoundOver = false
        populateLabelWithHistoricalEvents()
        timerLabel.text = timeFormatted(game.timer)
        self.totalTime = game.timer
        startTimer()
    }
}

// MARK: ADD SHAKE MOTION DETECTION
extension ViewController{
    override func becomeFirstResponder() -> Bool {
        return true
    }
    
    override func motionBegan(_ motion: UIEventSubtype, with event: UIEvent?) {
        if motion == .motionShake && !game.isRoundOver{
            endTimer()
            endRound()
        }
    }
}

