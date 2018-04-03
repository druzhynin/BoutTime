//
//  ViewController.swift
//  BoutTime
//
//  Created by Kirill Druzhynin on 27.03.2018.
//  Copyright © 2018 Kirill Druzhynin. All rights reserved.
//

import UIKit
import QuartzCore
import AudioToolbox

class ViewController: UIViewController {
    
    let questionsPerRound = 6
    var questionsAsked = 0
    var correctQuestions = 0
    var correctDing: SystemSoundID = 0
    var incorrectBuzz: SystemSoundID = 1
    
    // Variables for timer
    
    var lightningTimer = Timer()
    var seconds = 60
    var ltimerRunning = false
    
    @IBOutlet weak var fourthAnswer: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        fourthAnswer.layer.masksToBounds = true
        fourthAnswer.layer.cornerRadius = 4
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func countdownTimer() {
        seconds -= 1 // countdown by 1 second
        timerLabel.text = "You've got: \(seconds) seconds to answer."
        
        if seconds >= 11 {
            timerLabel.textColor = UIColor.green
        } else if seconds < 11 && seconds > 5 {
            timerLabel.textColor = UIColor.yellow
        } else {
            timerLabel.textColor = UIColor.red
        }
        
        if seconds == 0 {
            lightningTimer.invalidate()
            questionsAsked += 1
            playIncorrectBuzz()
            self.loadNextRoundWithDelay(seconds: 2)
            timerLabel.text = "Sorry, time ran out!"
        }
    }
    
    func loadCorrectDing() {
        let pathToSoundFile = Bundle.main.path(forResource: "correctDing", ofType: "wav")
        let soundURL = URL(fileURLWithPath: pathToSoundFile!)
        AudioServicesCreateSystemSoundID(soundURL as CFURL, &correctDing)
    }
    
    func playCorrectDing() {
        AudioServicesPlaySystemSound(correctDing)
    }
    
    func loadIncorrectBuzz() {
        let pathToSoundFile = Bundle.main.path(forResource: "incorrectBuzz", ofType: "wav")
        let soundURL = URL(fileURLWithPath: pathToSoundFile!)
        AudioServicesCreateSystemSoundID(soundURL as CFURL, &incorrectBuzz)
    }
    
    func playIncorrectBuzz() {
        AudioServicesPlaySystemSound(incorrectBuzz)
    }
    
}

