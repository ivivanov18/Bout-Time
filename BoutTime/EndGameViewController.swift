//
//  EndGameViewController.swift
//  SingleViewAppSwiftTemplate
//
//  Created by ivan ivanov on 11/12/2018.
//  Copyright © 2018 Treehouse. All rights reserved.
//

import UIKit

class EndGameViewController: UIViewController {

    @IBOutlet weak var scoreLabel: UILabel!
    
    var dataEndGameToDisplay: DataEndGame!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let textToDisplay = "\(dataEndGameToDisplay.numberOfCorrectAnswers) / \(dataEndGameToDisplay.numberOfRounds)"
        scoreLabel.text = textToDisplay
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    @IBAction func playAgain(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
