//
//  ViewController.swift
//  BullEye
//
//  Created by user on 9/22/14.
//  Copyright (c) 2014 Neva. All rights reserved.
//

import UIKit
import QuartzCore

class ViewController: UIViewController {
    
    @IBOutlet weak var slider: UISlider!
    
    @IBOutlet weak var targetLabel:UILabel!
    
    @IBOutlet weak var totalScoreLabel:UILabel!
    
    @IBOutlet weak var roundLabel:UILabel!
    
    var currentValue = 0
    
    var targetValue = 0
    
    var score = 0
    
    var round = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        startNewGame()
        updateLabels()
        
        let thumbImageNormal = UIImage(named: "SliderThumb-Normal")
        slider.setThumbImage(thumbImageNormal, forState: .Normal)
        
        let thumbIMageHighlighted = UIImage(named: "SliderThumb - Highlighted")
        slider.setThumbImage(thumbIMageHighlighted, forState: .Highlighted)
        
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        
        let trackLeftImage = UIImage(named: "SliderTrackLeft")
        
        let trackLeftResizable = trackLeftImage.resizableImageWithCapInsets(insets)
            slider.setMinimumTrackImage(trackLeftResizable, forState: .Normal)
        
        let trackRightImage = UIImage(named: "SliderTrackRight")
        
        let trackRightResizable = trackLeftImage.resizableImageWithCapInsets(insets)
            slider.setMaximumTrackImage(trackRightResizable, forState: .Normal)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func startNewRound(){
        round += 1
        targetValue = 1 + Int(arc4random_uniform(100))
        currentValue = 50
        slider.value = Float(currentValue)
    }
    
    func startNewGame(){
        score = 0
        round = 0
        startNewRound()
    }
    
    func updateLabels(){
        targetLabel.text = String(targetValue)
        totalScoreLabel.text = String(score)
        roundLabel.text = String(round)
    }
    

    @IBAction func showAlert(){
        
        let difference = abs(currentValue - targetValue)
        
        var points = 100 - difference
        
        score += points
        
        var title: String
        
        if difference == 0 {
            title = "Perfect!"
            //100 additional points for perfect game
            points += 100
        } else if difference < 5 {
            title = "So Close"
        } else if difference < 10 {
            title = "You can do better than that!"
        } else {
            title = "Not even close"
        }
        
        
        let message = "You scored \(points) points"
        
        let alert = UIAlertController(title: title,
                                    message: message,
                             preferredStyle: .Alert)
        
        let action = UIAlertAction(title: "OK",
                                   style: .Default,
                                 handler: {action in
                                    self.startNewRound()
                                    self.updateLabels()})
        
        alert.addAction(action)
        
        presentViewController(alert, animated: true, completion: nil)
        
       
    }
    
    
    
    @IBAction func sliderMoved(slider: UISlider) {
        currentValue = lroundf(slider.value)
    }
    
    @IBAction func startOver() {
        startNewGame()
        updateLabels()
        
        let transition = CATransition()
        transition.type = kCATransitionFade
        transition.duration = 1
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        view.layer.addAnimation(transition, forKey: nil)
    }

}

