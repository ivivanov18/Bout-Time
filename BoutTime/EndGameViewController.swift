//
//  EndGameViewController.swift
//  SingleViewAppSwiftTemplate
//
//  Created by ivan ivanov on 11/12/2018.
//  Copyright © 2018 Treehouse. All rights reserved.
//

import UIKit

protocol InitGameDelegate{
    func initGame()
}

class EndGameViewController: UIViewController {

    @IBOutlet weak var scoreLabel: UILabel!
    
    var dataEndGameToDisplay: DataEndGame!
    var initGameDelegate: InitGameDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let textToDisplay = "\(dataEndGameToDisplay.numberOfCorrectAnswers) / \(dataEndGameToDisplay.numberOfRounds)"
        scoreLabel.text = textToDisplay
        initGameDelegate = dataEndGameToDisplay.initGameDelegate
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    @IBAction func playAgain(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        initGameDelegate.initGame()
    }
}
