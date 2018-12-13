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

        // Do any additional setup after loading the view.
        let textToDisplay = "\(dataEndGameToDisplay.numberOfCorrectAnswers) / \(dataEndGameToDisplay.numberOfRounds)"
        scoreLabel.text = textToDisplay
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func playAgain(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
