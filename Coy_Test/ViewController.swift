//
//  ViewController.swift
//  Coy_Test
//
//  Created by Coy Coburn on 10/1/22.
//

import UIKit
import youtube_ios_player_helper
import AVFoundation

class ViewController: UIViewController, UISearchBarDelegate {
    
        
    @IBOutlet weak var mainTitleButton: UIButton!
    @IBOutlet var disclaimerButton: UIButton!
    @IBOutlet var referencesButton: UIButton!
    @IBOutlet var reviewButton: UIButton!
    @IBOutlet weak var bottomStackOptions: UIStackView!
    
    //Buttons for navitgating the decision tree
    @IBOutlet var optionOne: UIButton!
    @IBOutlet var optionTwo: UIButton!
    @IBOutlet var optionThree: UIButton!
    @IBOutlet weak var stackOptions: UIStackView!
    
    
    @IBOutlet weak var pcacContainer: UIView!
    @IBOutlet weak var pcsimvContainer: UIView!
    @IBOutlet weak var pcpsvContainer: UIView!
    @IBOutlet weak var videoContainer: UIView!
    @IBOutlet weak var hfjvContainer: UIView!
    @IBOutlet weak var hfovContainer: UIView!
    @IBOutlet weak var refsContainer: UIView!
    @IBOutlet weak var disContainer: UIView!
    @IBOutlet weak var helperContainer: UIView!
    
    var tapGesture:UITapGestureRecognizer!
    
    var prevConfiguration = UIButton.Configuration.gray()
    
    var prevButton = UIButton()
    
    static var utterance = AVSpeechUtterance(string: MainString.app_name.localized)
    static let synthesizer = AVSpeechSynthesizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Populating texts
        mainTitleButton.setTitle(MainString.app_name.localized, for: .normal)
        disclaimerButton.setTitle(MainString.Dis.localized, for: .normal)
        referencesButton.setTitle(MainString.referencesLabel.localized, for: .normal)
        reviewButton.setTitle(MainString.Review.localized, for: .normal)
        
        //disclaimerButton.isAccessibilityElement = true
        //referencesButton.isAccessibilityElement = true
        //disclaimerButton.accessibilityTraits = UIAccessibilityTraits.button
        //referencesButton.accessibilityTraits = UIAccessibilityTraits.button

        
        //disclaimerButton.accessibilityValue = MainString.Dis.localized
        //referencesButton.accessibilityValue = MainString.referencesLabel.localized
        
        // Enable VoiceOver
        //UIAccessibility.isVoiceOverRunning

        // Activate the button with VoiceOver
        //UIAccessibility.post(notification: .screenChanged, argument: disclaimerButton)
        // Activate the button with VoiceOver
        //UIAccessibility.post(notification: .screenChanged, argument: referencesButton)
        
        optionOne.setTitle(MainString.conVent.localized, for: .normal)
        optionTwo.setTitle(MainString.hfjv.localized, for: .normal)
        optionThree.setTitle(MainString.hfov.localized, for: .normal)
        
        //Create previous button
        buildPrevButton()
        
        //Hiding all containers
        pcacContainer.alpha = 0
        pcsimvContainer.alpha = 0
        pcpsvContainer.alpha = 0
        videoContainer.alpha = 0
        hfjvContainer.alpha = 0
        hfovContainer.alpha = 0
        disContainer.alpha = 0
        refsContainer.alpha = 0
        
        //Except for Helper Intro
        //helperContainer.alpha = 1
        buildHelper()
        
        //ViewController.synthesizer.speak(ViewController.utterance)
        //ViewController.synthesizer.pauseSpeaking(at: .word)
    }
    
    //Func: tapLabel
    func buildHelper() {
        stackOptions.removeArrangedSubview(optionOne)
        optionOne?.removeFromSuperview()
        stackOptions.removeArrangedSubview(optionTwo)
        optionTwo?.removeFromSuperview()
        stackOptions.removeArrangedSubview(optionThree)
        optionThree?.removeFromSuperview()
        
        bottomStackOptions.removeArrangedSubview(disclaimerButton)
        disclaimerButton?.removeFromSuperview()
        bottomStackOptions.removeArrangedSubview(referencesButton)
        referencesButton?.removeFromSuperview()
        bottomStackOptions.removeArrangedSubview(reviewButton)
        reviewButton?.removeFromSuperview()
        
        //stackOptions.addArrangedSubview(prevButton)
        helperContainer.alpha = 1
        
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapHelper(gesture:)))
        tapGesture.numberOfTapsRequired = 1
        //CC TODO split this into all UIActions of menu list
        //self.scrollDetails.isUserInteractionEnabled = true
        self.helperContainer.addGestureRecognizer(tapGesture)
        self.helperContainer.isUserInteractionEnabled = true
    }
    
    @IBAction func tapHelper(gesture: UITapGestureRecognizer) {
        
        self.helperContainer.alpha = 0
        
        stackOptions.insertArrangedSubview(optionOne, at: 0)
        stackOptions.insertArrangedSubview(optionTwo, at: 1)
        stackOptions.insertArrangedSubview(optionThree, at: 2)
        
        optionOne?.setTitle(MainString.conVent.localized, for: .normal)
        optionTwo?.setTitle(MainString.hfjv.localized, for: .normal)
        optionThree?.setTitle(MainString.hfov.localized, for: .normal)
        
        bottomStackOptions.insertArrangedSubview(disclaimerButton, at: 0)
        bottomStackOptions.insertArrangedSubview(referencesButton, at: 1)
        bottomStackOptions.insertArrangedSubview(reviewButton, at: 2)
        
        
    }
    
    func buildPrevButton(){
        prevConfiguration.cornerStyle = .capsule // 2
        prevConfiguration.baseForegroundColor = UIColor.darkGray
        //prevConfiguration.baseBackgroundColor = UIColor(named: "Menu")
        prevConfiguration.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 20, bottom: 2, trailing: 20)
        
        prevButton = UIButton(configuration: prevConfiguration)
        
        prevButton.setTitle(MainString.previous.localized, for: .normal)
        prevButton.titleLabel?.font = UIFont(name: "Arial Rounded MT Bold", size: 15)
        prevButton.translatesAutoresizingMaskIntoConstraints = false
        //prevButton.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
        //prevButton.widthAnchor.constraint(equalToConstant: 40.0).isActive = true
        
        prevButton.addTarget(self, action: #selector(prevButtonPressed(_:)), for: .touchUpInside)
        prevButton.sizeToFit()
    }

/*
     Previous Button is Pressed
     
     - Handles reverting storyboard to earlier state. Includes hiding
     child container and/or modifying choice buttons
*/
    @IBAction func prevButtonPressed(_ sender: UIButton) {
        
        //If 1st phase child container is active
        let hfChildCheck = (hfjvContainer.alpha + hfovContainer.alpha)
        
        if hfChildCheck > 0
        {
            if hfjvContainer.alpha == 1
            {
                hfjvContainer.alpha = 0
            }
            else if hfovContainer.alpha == 1
            {
                hfovContainer.alpha = 0
            }
            
            stackOptions.insertArrangedSubview(optionOne, at: 0)
            stackOptions.insertArrangedSubview(optionTwo, at: 1)
            stackOptions.insertArrangedSubview(optionThree, at: 2)
            
            optionOne?.setTitle(MainString.conVent.localized, for: .normal)
            optionTwo?.setTitle(MainString.hfjv.localized, for: .normal)
            optionThree?.setTitle(MainString.hfov.localized, for: .normal)
            
            stackOptions.removeArrangedSubview(prevButton)
            prevButton.removeFromSuperview()
            return
        }
        
        //If 2nd phase child container is active
        let conVentChildCheck = (pcacContainer.alpha + pcsimvContainer.alpha + pcpsvContainer.alpha)
        
        if conVentChildCheck > 0
        {
            if pcacContainer.alpha == 1
            {
                pcacContainer.alpha = 0
            }
            else if pcsimvContainer.alpha == 1
            {
                pcsimvContainer.alpha = 0
            }
            else if pcpsvContainer.alpha == 1
            {
                pcpsvContainer.alpha = 0
            }
            
            stackOptions.insertArrangedSubview(optionOne, at: 0)
            stackOptions.insertArrangedSubview(optionTwo, at: 1)
            stackOptions.insertArrangedSubview(optionThree, at: 2)
            
            optionOne?.setTitle(MainString.PCAC.localized, for: .normal)
            optionTwo?.setTitle(MainString.PCSIMV.localized, for: .normal)
            optionThree?.setTitle(MainString.PCPSV.localized, for: .normal)
            return
        }
        
        //For test video container if active
        if videoContainer.alpha == 1
        {
            
            videoContainer.alpha = 0
            
            stackOptions.insertArrangedSubview(optionOne, at: 0)
            stackOptions.insertArrangedSubview(optionTwo, at: 1)
            stackOptions.insertArrangedSubview(optionThree, at: 2)
            
            optionOne.setTitle(MainString.conVent.localized, for: .normal)
            optionTwo.setTitle(MainString.hfjv.localized, for: .normal)
            optionThree.setTitle(MainString.hfov.localized, for: .normal)
            
            stackOptions.removeArrangedSubview(prevButton)
            prevButton.removeFromSuperview()
            return
        }
        
        if disContainer.alpha == 1
        {
            disContainer.alpha = 0
            
            stackOptions.insertArrangedSubview(optionOne, at: 0)
            stackOptions.insertArrangedSubview(optionTwo, at: 1)
            stackOptions.insertArrangedSubview(optionThree, at: 2)
            
            optionOne.setTitle(MainString.conVent.localized, for: .normal)
            optionTwo.setTitle(MainString.hfjv.localized, for: .normal)
            optionThree.setTitle(MainString.hfov.localized, for: .normal)
            
            stackOptions.removeArrangedSubview(prevButton)
            prevButton.removeFromSuperview()
            return
        }
        
        if refsContainer.alpha == 1
        {
            refsContainer.alpha = 0
            
            stackOptions.insertArrangedSubview(optionOne, at: 0)
            stackOptions.insertArrangedSubview(optionTwo, at: 1)
            stackOptions.insertArrangedSubview(optionThree, at: 2)
            
            optionOne.setTitle(MainString.conVent.localized, for: .normal)
            optionTwo.setTitle(MainString.hfjv.localized, for: .normal)
            optionThree.setTitle(MainString.hfov.localized, for: .normal)
            
            stackOptions.removeArrangedSubview(prevButton)
            prevButton.removeFromSuperview()
            return
        }
        
        if let strCheck = optionOne
        {
            //For Conventional Ventilator 2nd choice container
            if strCheck.titleLabel?.text == MainString.PCAC.localized
            {
                optionOne.setTitle(MainString.conVent.localized, for: .normal)
                optionTwo.setTitle(MainString.hfjv.localized, for: .normal)
                optionThree.setTitle(MainString.hfov.localized, for: .normal)
                
                stackOptions.removeArrangedSubview(prevButton)
                prevButton.removeFromSuperview()
            }
        }
        
        
    }

/*
     Option One is Pressed
     
     - Handles activating child container depending on storyboard state
*/
    @IBAction func optionOnePressed(_ sender: UIButton) {
        
        let choice = sender.titleLabel?.text
        //utterance = AVSpeechUtterance(string: choice!)
        //synthesizer.speak(utterance)
        switch (choice)
        {
            case MainString.conVent.localized:
                optionOne?.setTitle(MainString.PCAC.localized, for: .normal)
                optionTwo?.setTitle(MainString.PCSIMV.localized, for: .normal)
                optionThree?.setTitle(MainString.PCPSV.localized, for: .normal)
                stackOptions.addArrangedSubview(prevButton)
                    
            case MainString.PCAC.localized:
                stackOptions.removeArrangedSubview(optionOne)
                optionOne?.removeFromSuperview()
                stackOptions.removeArrangedSubview(optionTwo)
                optionTwo?.removeFromSuperview()
                stackOptions.removeArrangedSubview(optionThree)
                optionThree?.removeFromSuperview()
                
                pcacContainer.alpha = 1
            
            default: break
        }
    }

/*
     Option Two is Pressed
     
     - Handles activating child container depending on storyboard state
*/
    @IBAction func optionTwoPressed(_ sender: UIButton) {
        
        let choice = sender.titleLabel?.text
        switch (choice)
        {
            case MainString.hfjv.localized:
                stackOptions.removeArrangedSubview(optionOne)
                optionOne?.removeFromSuperview()
                stackOptions.removeArrangedSubview(optionTwo)
                optionTwo?.removeFromSuperview()
                stackOptions.removeArrangedSubview(optionThree)
                optionThree?.removeFromSuperview()
                
                stackOptions.addArrangedSubview(prevButton)
                
                hfjvContainer.alpha = 1
                    
            case MainString.PCSIMV.localized:
                stackOptions.removeArrangedSubview(optionOne)
                optionOne?.removeFromSuperview()
                stackOptions.removeArrangedSubview(optionTwo)
                optionTwo?.removeFromSuperview()
                stackOptions.removeArrangedSubview(optionThree)
                optionThree?.removeFromSuperview()
                
                pcsimvContainer.alpha = 1
            
            default: break
        }
 }
    
/*
     Option Three is Pressed
     
     - Handles activating child container depending on storyboard state
*/
    @IBAction func optionThreePressed(_ sender: UIButton) {
        
        let choice = sender.titleLabel?.text
        switch (choice)
        {
            case MainString.hfov.localized:
                stackOptions.removeArrangedSubview(optionOne)
                optionOne?.removeFromSuperview()
                stackOptions.removeArrangedSubview(optionTwo)
                optionTwo?.removeFromSuperview()
                stackOptions.removeArrangedSubview(optionThree)
                optionThree?.removeFromSuperview()
                
                stackOptions.addArrangedSubview(prevButton)
                
                hfovContainer.alpha = 1
                    
            case MainString.PCPSV.localized:
                stackOptions.removeArrangedSubview(optionOne)
                optionOne?.removeFromSuperview()
                stackOptions.removeArrangedSubview(optionTwo)
                optionTwo?.removeFromSuperview()
                stackOptions.removeArrangedSubview(optionThree)
                optionThree?.removeFromSuperview()
                
                pcpsvContainer.alpha = 1
            
            default: break
        }
    }
    
    @IBAction func disButtonPressed(_ sender: Any) {
        
        let containerArr = [pcacContainer, pcsimvContainer, pcpsvContainer, videoContainer, hfjvContainer, hfovContainer, refsContainer, disContainer]
        
        for contain in containerArr
        {
            if contain?.alpha == 1
            {
                contain?.alpha = 0
            }
        }
        stackOptions.removeArrangedSubview(optionOne)
        optionOne?.removeFromSuperview()
        stackOptions.removeArrangedSubview(optionTwo)
        optionTwo?.removeFromSuperview()
        stackOptions.removeArrangedSubview(optionThree)
        optionThree?.removeFromSuperview()
        
        stackOptions.addArrangedSubview(prevButton)
        disContainer.alpha = 1
    }
    

    @IBAction func refsButtonPressed(_ sender: Any) {
        
        let containerArr = [pcacContainer, pcsimvContainer, pcpsvContainer, videoContainer, hfjvContainer, hfovContainer, refsContainer, disContainer]
        
        for contain in containerArr
        {
            if contain?.alpha == 1
            {
                contain?.alpha = 0
            }
        }
        
        stackOptions.removeArrangedSubview(optionOne)
        optionOne?.removeFromSuperview()
        stackOptions.removeArrangedSubview(optionTwo)
        optionTwo?.removeFromSuperview()
        stackOptions.removeArrangedSubview(optionThree)
        optionThree?.removeFromSuperview()
        
        stackOptions.addArrangedSubview(prevButton)
        refsContainer.alpha = 1
        
        if disContainer.alpha == 1
        {
            disContainer.alpha = 0
        }
    }
    
    @IBAction func reviewButtonPressed(_ sender: Any) {
        if let urlOpen = URL(string: MainString.Survey_link.localized)
        {
            UIApplication.shared.open(urlOpen, options: [:])
        }
    }
    
}

