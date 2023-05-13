//
//  UILabel+constructorTemplate.swift
//  Coy_Test
//
//  Created by Coy Coburn on 12/5/22.
//

import Foundation
import UIKit
import AVFoundation

/* Defined Macros */
let STACK_SPACING = 20.0
let LABEL_WRAP = 0

extension UILabel{
    
    @objc func tapUILabel(gesture: UITapGestureRecognizer) {
        let string = self.text
        var tmp = string?.replacingOccurrences(of: "•", with: "")
        tmp = tmp?.replacingOccurrences(of: "Δ", with: "delta ")
        tmp = tmp?.replacingOccurrences(of: "~", with: "about ")
        
        //Allow user to stop and continue selected UILabel text
        //Check if we are looking at the same text as last call
        if(ViewController.utterance.speechString == tmp)
        {
            if(ViewController.synthesizer.isPaused)
            {
                ViewController.synthesizer.continueSpeaking()
            }
            else if(ViewController.synthesizer.isSpeaking)
            {
                ViewController.synthesizer.pauseSpeaking(at: .immediate)
            }
            else
            {
                ViewController.synthesizer.stopSpeaking(at: .immediate)
                ViewController.utterance = AVSpeechUtterance(string: tmp!)
                ViewController.synthesizer.speak(ViewController.utterance)
                ViewController.synthesizer.pauseSpeaking(at: .word)
            }
        }
        else
        {
            ViewController.synthesizer.stopSpeaking(at: .immediate)
            ViewController.utterance = AVSpeechUtterance(string: tmp!)
            ViewController.synthesizer.speak(ViewController.utterance)
            ViewController.synthesizer.pauseSpeaking(at: .word)
        }
    }
}

//Template for details label during Settings/Management
func stackLabel(text: String,_ stk: UIStackView) -> UILabel
{
    //NumOfLines wraps content. SetContentComp ensures label shows all of text
    //let guide = stk.safeAreaLayoutGuide
    let newLabel = UILabel()
    newLabel.text = text
    newLabel.numberOfLines = LABEL_WRAP
    newLabel.textAlignment = .left
    newLabel.setContentCompressionResistancePriority(.required, for: .vertical)
    newLabel.widthAnchor.constraint(equalToConstant: stk.frame.size.width).isActive = true
    newLabel.backgroundColor = UIColor(named: "NICU_Background")
    newLabel.textColor = UIColor(named: "SubFore")
    newLabel.font = UIFont(name: "Arial Rounded MT Bold", size: 15)
    
    let doubleTapGesture = UITapGestureRecognizer(target: newLabel, action: #selector(newLabel.tapUILabel(gesture:)))
    doubleTapGesture.numberOfTapsRequired = 2
    newLabel.addGestureRecognizer(doubleTapGesture)
    newLabel.isUserInteractionEnabled = true
    return newLabel
}
