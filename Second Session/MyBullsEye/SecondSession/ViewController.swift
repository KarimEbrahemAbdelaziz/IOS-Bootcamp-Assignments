//
//  ViewController.swift
//  SecondSession
//
//  Created by KARIM on 4/8/17.
//  Copyright © 2017 KARIM. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var currentValue = 0
    var targetValue = 0
    var score = 0
    var round = 0

    @IBOutlet var mySlider: UISlider!
    @IBOutlet var targetLabel: UILabel!
    @IBOutlet var scoreLabel: UILabel!
    @IBOutlet var roundLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // this variable to hold the slider image when it's normal
        let ImageNormal = #imageLiteral(resourceName: "SliderThumb-Normal")
        // set image for normal state config
        mySlider.setThumbImage(ImageNormal, for: .normal)
        
        // this variable to hold the slider image when it's highlighted
        let ImageHighlighted = #imageLiteral(resourceName: "SliderThumb-Highlighted")
        // set image for highlighted state config
        mySlider.setThumbImage(ImageHighlighted, for: .highlighted)
        
        // create insets for the bar
        let insets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        // this variable hold the left image for the track
        let trackLeft = #imageLiteral(resourceName: "SliderTrackLeft")
        let trackLeftResizable =
            trackLeft.resizableImage(withCapInsets: insets)
        
        mySlider.setMinimumTrackImage(trackLeftResizable, for: .normal)
        
        // this variable hold the right image for the track
        let trackRight = #imageLiteral(resourceName: "SliderTrackRight")
        let trackRightResizable =
            trackRight.resizableImage(withCapInsets: insets)
        
        mySlider.setMaximumTrackImage(trackRightResizable, for: .normal)
        
        // startNewGame Function is work as initialization for all labels and values
        startNewGame()
        // updateLabels Function is to update labels with current values
        updateLabels()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func showAlert() {
        
        // get difference between two values in case one is greater then one.
        let difference = abs(targetValue - currentValue)
        // this is the main points to add
        var points = 100 - difference
        
        // title for alert message depending on the points you get
        let alertTitle: String
        
        switch difference {
        case 0:
            alertTitle = "Perfect"
            points += 100
        case 1..<5:
            alertTitle = "Almost had it"
            if difference == 1 {
                points += 50
            }
        case 5..<10:
            alertTitle = "Pretty good"
        default:
            alertTitle = "Not even close :("
        }
        
        // update the main score with new points
        score += points
        
        // this is the alert message for my alert
        var alertMessage = "You scored \(points) points\n"
        alertMessage += "Your Value is : \(currentValue)\n"
        alertMessage += "Current Target Value is : \(targetValue)"
        
        // create my alert with titleAlert and alertMessage
        let alert = UIAlertController(title: alertTitle,
                                      message: alertMessage,
                                      preferredStyle: .alert)
        
        // action is Button for alert shown on the screen
        let action = UIAlertAction(title: "Awesome", style: .default,
                                   handler: { action in
                                    self.startNewRound()
                                    self.updateLabels()})
        //let anotherAction = UIAlertAction(title: "secondAwesome", style: .default, handler: nil)
        
        // add Button for alert
        alert.addAction(action)
        //alert.addAction(anotherAction)
        
        // present is function to show the alert on screen
        present(alert, animated: true, completion: nil)
    }
    
    // updateLabels is to update Labels with current values
    func updateLabels() {
        targetLabel.text = String(targetValue)
        scoreLabel.text = String(score)
        roundLabel.text = String(round)
    }
    
    // sliderMoved function is to get the current value of slider, to stay foucs on it's value when changed
    @IBAction func sliderMoved(_ slider: UISlider) {
        currentValue = lroundf(slider.value)
    }
    
    // startOver function for button start over, Reset all values and rounds
    @IBAction func startOver() {
        startNewGame()
        updateLabels()
    }
    
    // startNewGame function  it's to start over
    func startNewGame() {
        score = 0
        round = 0
        startNewRound()
    }
    
    // startNewRound Function is to add new round to the game and reset slider and target values
    func startNewRound() {
        round += 1
    
        targetValue = 1 + Int(arc4random_uniform(100))
        
        currentValue = 50
        mySlider.value = Float(currentValue)
    }
    
}

