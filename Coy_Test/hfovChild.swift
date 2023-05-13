//
//  hfovChild.swift
//  Coy_Test
//
//  Created by Coy Coburn on 11/6/22.
//

import Foundation
import UIKit
import youtube_ios_player_helper
import AVFoundation

//If HFOV locals indexes are changed, update this macro
let HFOV_SETTINGS_INDEX = 5
let HFOV_GAS_MAN_SUBTAB_INDEX = 11
let HFOV_VIDEOS_INDEX = 13
let HFOV_MONITOR_SUBTAB_INDEX = 35

class hfovChild: UIViewController{
    
    @IBOutlet var menuButton: UIButton!
    @IBOutlet var scrollDetails: UILabel!
    @IBOutlet var scrollEmbeddedView: UIView!
    
    @IBOutlet var scrollEmbeddedHeight: NSLayoutConstraint!
    @IBOutlet weak var titleLabel: UILabel!
    
    lazy var scrollStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        //stackView.spacing = STACK_SPACING
        stackView.alignment = .center
        return stackView
    }()
    
    lazy var monitorStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        return stackView
    }()
    
    //Declaring the videos for Videos tab
    lazy var freqOnePlayer: YTPlayerView = stackPlayer(videoID: hfovString.freqOneVideo.localized)
    lazy var freqTwoPlayer: YTPlayerView = stackPlayer(videoID: hfovString.freqTwoVideo.localized)
    lazy var oscOnePlayer: YTPlayerView = stackPlayer(videoID: hfovString.oscOneVideo.localized)
    lazy var oscTwoPlayer: YTPlayerView = stackPlayer(videoID: hfovString.oscTwoVideo.localized)    
    
    //Flags for sub tabs and videos
    var monitorFlag: Bool = false
    var freqOneBool: Bool = false
    var freqTwoBool: Bool = false
    var oscOneBool: Bool = false
    var oscTwoBool: Bool = false
    
    //UIButton.Configuration is for iOS 15 or greater
    var buttonConfig = UIButton.Configuration.gray()
    var subTabConfig = UIButton.Configuration.gray()
    
    //Reset the Videos button flags
    func resetVideoTabs()
    {
        freqOneBool = false
        freqTwoBool = false
        oscOneBool = false
        oscTwoBool = false
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        scrollDetails.text = hfovString.HFOV_what.localized
        titleLabel.text = MainString.hfov.localized
        //playerDetails.load(withVideoId: "haW_ruZ_Be8", playerVars: ["playsinLine": "1"])
        //if #available(iOS 14.0, *) {
        //Create menu here to choose between detail tabs. Works for > ios 14.0
        menuButton.menu = addMenuItems()
        menuButton.setTitle(MainString.MainMenu.localized, for: .normal)
        menuButton.showsMenuAsPrimaryAction = true
        
        buttonConfig.cornerStyle = .capsule
        buttonConfig.baseForegroundColor = UIColor(named: "Menu")
        buttonConfig.baseBackgroundColor = UIColor(named: "ButtonBack")
        buttonConfig.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 20, bottom: 2, trailing: 20)
        
        subTabConfig.cornerStyle = .capsule
        subTabConfig.baseForegroundColor = UIColor(named: "SubButton")
        subTabConfig.baseBackgroundColor = UIColor(named: "Menu")
        subTabConfig.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 20, bottom: 2, trailing: 20)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.resizeScrollEmbeddedView()
        //self.scrollDetails.isUserInteractionEnabled = false
    }
    
    func addMenuItems() -> UIMenu
    {
        let doubleTapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapLabel(gesture:)))
        doubleTapGesture.numberOfTapsRequired = 2
        view.addGestureRecognizer(doubleTapGesture)
        self.scrollDetails.addGestureRecognizer(doubleTapGesture)
        self.scrollDetails.isUserInteractionEnabled = true
 
        let menuItems = UIMenu(title: "", options: .displayInline, children: [
            
            //Overview Tab
            UIAction(title: MainString.What.localized, handler: { (_) in
                self.scrollDetails.text = hfovString.HFOV_what.localized
                self.removeSubButtons()
                self.resetVideoTabs()
                //self.scrollDetails.isUserInteractionEnabled = false
                self.resizeScrollEmbeddedView()
            }),
            
            //Considerations Tab
            UIAction(title: MainString.When.localized, handler: { (_) in
                self.scrollDetails.text = hfovString.HFOV_when.localized
                self.removeSubButtons()
                self.resetVideoTabs()
                //self.scrollDetails.isUserInteractionEnabled = false
                self.resizeScrollEmbeddedView()
            }),
            
            //Settings Tab
            UIAction(title: MainString.Settings.localized, handler: { (_) in
                self.scrollDetails.text = ""
                //self.scrollDetails.isUserInteractionEnabled = false
                self.removeSubButtons()
                self.resetVideoTabs()
                let tabText = MainString.Settings.localized
                self.createSubButtons(buttonText: tabText)
            }),
            
            //Management Tab
            UIAction(title: MainString.Management.localized, handler: { (_) in
                self.scrollDetails.text = ""
                //self.scrollDetails.isUserInteractionEnabled = false
                self.removeSubButtons()
                self.resetVideoTabs()
                let tabText = MainString.Management.localized
                self.createSubButtons(buttonText: tabText)
            }),
            
            //Tips Tab
            UIAction(title: MainString.Tips.localized, handler: { (_) in
                self.scrollDetails.text = hfovString.HFOV_tips.localized
                self.removeSubButtons()
                self.resetVideoTabs()
                //self.scrollDetails.isUserInteractionEnabled = false
                self.resizeScrollEmbeddedView()
            }),
            
            //Videos Tab
            UIAction(title: MainString.Video.localized, handler: { (_) in
                self.scrollDetails.text = ""
                self.removeSubButtons()
                self.resetVideoTabs()
                //self.scrollDetails.isUserInteractionEnabled = false
                //self.resizeScrollEmbeddedView()
                self.createVideos()
            })
        ])
        
        return menuItems
    }
    
    //Func: tapLabel
    @IBAction func tapLabel(gesture: UITapGestureRecognizer) {
        let string = self.scrollDetails.text
        let tmp = string?.replacingOccurrences(of: "•", with: "")

        ViewController.synthesizer.stopSpeaking(at: .immediate)
        ViewController.utterance = AVSpeechUtterance(string: tmp!)
        ViewController.synthesizer.speak(ViewController.utterance)
        ViewController.synthesizer.pauseSpeaking(at: .word)
    }
    
    func resizeScrollEmbeddedView()
    {
        var subviewHeight: CGFloat = 0
        var count = 0
        for subview in scrollEmbeddedView.subviews
        {
            if let stack = subview as? UIStackView
            {
                for stackSubview in stack.subviews
                {
                    if let video = stackSubview as? YTPlayerView
                    {
                        subviewHeight += video.frame.size.height
                    }
                    else
                    {
                        subviewHeight += stackSubview.intrinsicContentSize.height
                    }
                    count += 1
                }
                subviewHeight += (STACK_SPACING * CGFloat(count))
            }
            subviewHeight += subview.intrinsicContentSize.height
            count += 1
        }
        
        scrollEmbeddedHeight.constant = subviewHeight + STACK_SPACING
        scrollEmbeddedView.layoutIfNeeded()
    }
        
    func resizeStackView(stack: UIStackView)
    {
        var subviewHeight: CGFloat = 0

        for stackSubview in stack.subviews
        {
            subviewHeight += stackSubview.intrinsicContentSize.height
        }
        
        print(subviewHeight)
        stack.heightAnchor.constraint(equalToConstant: subviewHeight).isActive = true
    }
    
    func createVideos()
    {
        scrollEmbeddedView.addSubview(scrollStackView)
        scrollStackView.translatesAutoresizingMaskIntoConstraints = false
        scrollStackView.topAnchor.constraint(equalTo: scrollDetails.bottomAnchor).isActive = true
        scrollStackView.leadingAnchor.constraint(equalTo: scrollEmbeddedView.leadingAnchor).isActive = true
        scrollStackView.trailingAnchor.constraint(equalTo: scrollEmbeddedView.trailingAnchor).isActive = true
        
        let freqOneButton = UIButton(configuration: buttonConfig)
        let freqTwoButton = UIButton(configuration: buttonConfig)
        let oscOneButton = UIButton(configuration: buttonConfig)
        let oscTwoButton = UIButton(configuration: buttonConfig)
        
        let videoButtons = [freqOneButton, freqTwoButton, oscOneButton, oscTwoButton]
        
        var enumIndex = hfovVideosIndex.allCases.startIndex
        var titleIndex = hfovString.allCases.index(after: HFOV_VIDEOS_INDEX)
        
        for button in videoButtons
        {
            //Assign action to take when pressed
            button.addTarget(self, action: #selector(subButtonPressed(_:)), for: .touchUpInside)
            button.titleLabel?.lineBreakMode = .byWordWrapping
            button.titleLabel?.textAlignment = .center
            button.configuration?.attributedTitle = AttributedString(hfovString.allCases[titleIndex].localized, attributes: AttributeContainer([NSAttributedString.Key.font : UIFont(name: FONT_STYLE_ARIAL, size: FONT_SIZE_15)!]))
            button.sizeToFit()
            //Add buttons to new stack
            scrollStackView.insertArrangedSubview(button, at: enumIndex)
            enumIndex = enumIndex + 1
            titleIndex = titleIndex + 1
            
        }
        //scrollStackView.setCustomSpacing(15, after: button)
        
        scrollStackView.spacing = STACK_SPACING
        scrollStackView.sizeToFit()
        scrollStackView.layoutIfNeeded()
        resizeScrollEmbeddedView()
        print("Overview Height: ",scrollStackView.intrinsicContentSize.height)

        
    }
    
    //Func: createSubButtons
    func createSubButtons(buttonText: String)
    {
              
        scrollEmbeddedView.addSubview(scrollStackView)
        scrollStackView.translatesAutoresizingMaskIntoConstraints = false
               
        //Constrain scrollStackView
        scrollStackView.topAnchor.constraint(equalTo: scrollDetails.bottomAnchor).isActive = true
        scrollStackView.leadingAnchor.constraint(equalTo: scrollEmbeddedView.leadingAnchor).isActive = true
        scrollStackView.trailingAnchor.constraint(equalTo: scrollEmbeddedView.trailingAnchor).isActive = true
        
        switch(buttonText)
        {
            case MainString.Management.localized:
                //Create buttons
                let gasFiveButton = UIButton(configuration: buttonConfig)
                let gasSixButton = UIButton(configuration: buttonConfig)
                let hyperButton = UIButton(configuration: buttonConfig)
                let hypoButton = UIButton(configuration: buttonConfig)
                let lungButton = UIButton(configuration: buttonConfig)
                let monitorButton = UIButton(configuration: buttonConfig)
                let weaningButton = UIButton(configuration: buttonConfig)
                
                let gasButtons = [gasFiveButton, gasSixButton]
                let manButtons = [hyperButton, hypoButton, lungButton, monitorButton, weaningButton]
                var enumIndex = hfovManagementIndex.allCases.startIndex
                var titleIndex = hfovString.allCases.index(after: HFOV_GAS_MAN_SUBTAB_INDEX)
               
                for button in gasButtons
                {
                    //Assign action to take when pressed
                    button.addTarget(self, action: #selector(subButtonPressed(_:)), for: .touchUpInside)
                    //button.setTitle(hfovString.allCases[titleIndex].localized, for: .normal)
                    button.titleLabel?.lineBreakMode = .byWordWrapping
                    button.titleLabel?.textAlignment = .center
                    button.configuration?.attributedTitle = AttributedString(hfovString.allCases[titleIndex].localized, attributes: AttributeContainer([NSAttributedString.Key.font : UIFont(name: FONT_STYLE_ARIAL, size: FONT_SIZE_15)!]))
                    button.sizeToFit()
                    //Add buttons to new stack
                    scrollStackView.insertArrangedSubview(button, at: enumIndex)
                    enumIndex = enumIndex + 1
                    titleIndex = titleIndex + 1
                }
            
                titleIndex = MainString.allCases.index(after: MANAGEMENT_INDEX)
            
                for button in manButtons
                {
                    //Assign action to take when pressed
                    button.addTarget(self, action: #selector(subButtonPressed(_:)), for: .touchUpInside)
                    button.setTitle(MainString.allCases[titleIndex].localized, for: .normal)
                    button.heightAnchor.constraint(equalToConstant: 20).isActive = true
                    //button.widthAnchor.constraint(equalToConstant: 300).isActive = true
                    button.sizeToFit()
                    //Add buttons to new stack
                    scrollStackView.insertArrangedSubview(button, at: enumIndex)
                    //scrollStackView.setCustomSpacing(15, after: button)
                    enumIndex = enumIndex + 1
                    titleIndex = titleIndex + 1
                    
                }
                break
                
            case MainString.Settings.localized:
                let mapButton = UIButton(configuration: buttonConfig)
                let biasButton = UIButton(configuration: buttonConfig)
                let deltaButton = UIButton(configuration: buttonConfig)
                let freqButton = UIButton(configuration: buttonConfig)
                let ieButton = UIButton(configuration: buttonConfig)
                let powerButton = UIButton(configuration: buttonConfig)
                
                let setButtons = [mapButton, biasButton, deltaButton, freqButton, ieButton, powerButton]
                var enumIndex = hfovSettingsIndex.allCases.startIndex
                var titleIndex = hfovString.allCases.index(after: HFOV_SETTINGS_INDEX)
                
                for button in setButtons
                {
                    //Assign action to take when pressed
                    button.addTarget(self, action: #selector(subButtonPressed(_:)), for: .touchUpInside)
                    button.setTitle(hfovString.allCases[titleIndex].localized, for: .normal)
                    button.heightAnchor.constraint(equalToConstant: 20).isActive = true
                    button.configuration?.attributedTitle = AttributedString(hfovString.allCases[titleIndex].localized, attributes: AttributeContainer([NSAttributedString.Key.font : UIFont(name: FONT_STYLE_ARIAL, size: FONT_SIZE_15)!]))
                    button.sizeToFit()
                    
                    //Add buttons to new stack
                    scrollStackView.insertArrangedSubview(button, at: enumIndex)
                    enumIndex = enumIndex + 1
                    titleIndex = titleIndex + 1
                    
                }
                break
                    
            default: break
        }

        scrollStackView.spacing = STACK_SPACING
        scrollStackView.sizeToFit()
        scrollStackView.layoutIfNeeded()
        print("Height3: ",scrollStackView.frame.height)

        resizeScrollEmbeddedView()
    }
    
    @IBAction func subButtonPressed(_ sender: UIButton)
    {
        let buttonTitleString = sender.titleLabel?.text
        let subviewArray = scrollStackView.subviews
        
        switch(buttonTitleString)
        {
        //CC TODO populate all branch names in Localizable.Strings
            
        //SETTINGS TABS START HERE
        case hfovString.pawTab.localized:
            //if labelView is UILabel
            let labelView = searchLabel(labelText: hfovString.HFOV_settingsMap.localized, subviewArray: subviewArray)
            
            if labelView.text == hfovString.HFOV_settingsMap.localized
            {
                scrollStackView.removeArrangedSubview(labelView)
                labelView.removeFromSuperview()
            }
            else
            {
                scrollStackView.insertArrangedSubview(stackLabel(text: hfovString.HFOV_settingsMap.localized, scrollStackView), belowArrangedSubview: sender)
            }
            
        case hfovString.biasTab.localized:
            //if labelView is UILabel
            let labelView = searchLabel(labelText: hfovString.HFOV_settingsBias.localized, subviewArray: subviewArray)
            
            if labelView.text == hfovString.HFOV_settingsBias.localized
            {
                scrollStackView.removeArrangedSubview(labelView)
                labelView.removeFromSuperview()
            }
            else
            {
                scrollStackView.insertArrangedSubview(stackLabel(text: hfovString.HFOV_settingsBias.localized, scrollStackView), belowArrangedSubview: sender)
            }
            
        case hfovString.deltaTab.localized:
            //if labelView is UILabel
            let labelView = searchLabel(labelText: hfovString.HFOV_settingsDelta.localized, subviewArray: subviewArray)
            
            if labelView.text == hfovString.HFOV_settingsDelta.localized
            {
                scrollStackView.removeArrangedSubview(labelView)
                labelView.removeFromSuperview()
            }
            else
            {
                scrollStackView.insertArrangedSubview(stackLabel(text: hfovString.HFOV_settingsDelta.localized, scrollStackView), belowArrangedSubview: sender)
            }
            
        
        case hfovString.freqTab.localized:
            //if labelView is UILabel
            let labelView = searchLabel(labelText: hfovString.HFOV_settingsFreq.localized, subviewArray: subviewArray)
            
            if labelView.text == hfovString.HFOV_settingsFreq.localized
            {
                scrollStackView.removeArrangedSubview(labelView)
                labelView.removeFromSuperview()
            }
            else
            {
                scrollStackView.insertArrangedSubview(stackLabel(text: hfovString.HFOV_settingsFreq.localized, scrollStackView), belowArrangedSubview: sender)
            }
            
        case hfovString.ieTab.localized:
            //if labelView is UILabel
            let labelView = searchLabel(labelText: hfovString.HFOV_settingsIERatio.localized, subviewArray: subviewArray)
            
            if labelView.text == hfovString.HFOV_settingsIERatio.localized
            {
                scrollStackView.removeArrangedSubview(labelView)
                labelView.removeFromSuperview()
            }
            else
            {
                scrollStackView.insertArrangedSubview(stackLabel(text: hfovString.HFOV_settingsIERatio.localized, scrollStackView), belowArrangedSubview: sender)
            }
            
        case hfovString.powerTab.localized:
            //if labelView is UILabel
            let labelView = searchLabel(labelText: hfovString.HFOV_settingsPower.localized, subviewArray: subviewArray)
            
            if labelView.text == hfovString.HFOV_settingsPower.localized
            {
                scrollStackView.removeArrangedSubview(labelView)
                labelView.removeFromSuperview()
            }
            else
            {
                scrollStackView.insertArrangedSubview(stackLabel(text: hfovString.HFOV_settingsPower.localized, scrollStackView), belowArrangedSubview: sender)
            }
            
        //MANAGEMENT TABS START HERE
        case hfovString.gasFiveTab.localized:
            //if labelView is UILabel
            let labelView = searchLabel(labelText: hfovString.HFOV_managementGasFive.localized, subviewArray: subviewArray)
            
            if labelView.text == hfovString.HFOV_managementGasFive.localized
            {
                scrollStackView.removeArrangedSubview(labelView)
                labelView.removeFromSuperview()
            }
            else
            {
                scrollStackView.insertArrangedSubview(stackLabel(text: hfovString.HFOV_managementGasFive.localized, scrollStackView), belowArrangedSubview: sender)
            }
            
        case hfovString.gasSixTab.localized:
            //if labelView is UILabel
            let labelView = searchLabel(labelText: hfovString.HFOV_managementGasSix.localized, subviewArray: subviewArray)
            
            if labelView.text == hfovString.HFOV_managementGasSix.localized
            {
                scrollStackView.removeArrangedSubview(labelView)
                labelView.removeFromSuperview()
            }
            else
            {
                scrollStackView.insertArrangedSubview(stackLabel(text: hfovString.HFOV_managementGasSix.localized, scrollStackView), belowArrangedSubview: sender)
            }
            
        case MainString.hyperTab.localized:
            //if labelView is UILabel
            let labelView = searchLabel(labelText: hfovString.HFOV_managementHyper.localized, subviewArray: subviewArray)
            
            if labelView.text == hfovString.HFOV_managementHyper.localized
            {
                scrollStackView.removeArrangedSubview(labelView)
                labelView.removeFromSuperview()
            }
            else
            {
                scrollStackView.insertArrangedSubview(stackLabel(text: hfovString.HFOV_managementHyper.localized, scrollStackView), belowArrangedSubview: sender)
            }
            
        case MainString.hypoTab.localized:
            //if labelView is UILabel
            let labelView = searchLabel(labelText: hfovString.HFOV_managementHypo.localized, subviewArray: subviewArray)
            
            if labelView.text == hfovString.HFOV_managementHypo.localized
            {
                scrollStackView.removeArrangedSubview(labelView)
                labelView.removeFromSuperview()
            }
            else
            {
                scrollStackView.insertArrangedSubview(stackLabel(text: hfovString.HFOV_managementHypo.localized, scrollStackView), belowArrangedSubview: sender)
            }
        
        case MainString.lungTab.localized:
            //if labelView is UILabel
            let labelView = searchLabel(labelText: hfovString.HFOV_managementLung.localized, subviewArray: subviewArray)
            
            if labelView.text == hfovString.HFOV_managementLung.localized
            {
                scrollStackView.removeArrangedSubview(labelView)
                labelView.removeFromSuperview()
            }
            else
            {
                scrollStackView.insertArrangedSubview(stackLabel(text: hfovString.HFOV_managementLung.localized, scrollStackView), belowArrangedSubview: sender)
            }
            
        case MainString.monitorTab.localized:
            //Check if already expanded
            if monitorFlag == true
            {
                removeModeStack(&monitorStack)
                monitorFlag = false
            }
            else
            {
                let xrayButton = UIButton(configuration: subTabConfig)
                let gasButton = UIButton(configuration: subTabConfig)
                
                let buttons = [xrayButton, gasButton]
                var titleIndex = hfovString.allCases.index(after: HFOV_MONITOR_SUBTAB_INDEX)
                
                populateStack(sender, buttons, &titleIndex, &monitorStack)
                monitorFlag = true
            }
            
        case MainString.weaningTab.localized:
            //if labelView is UILabel
            let labelView = searchLabel(labelText: hfovString.HFOV_managementWeaning.localized, subviewArray: subviewArray)
            
            if labelView.text == hfovString.HFOV_managementWeaning.localized
            {
                scrollStackView.removeArrangedSubview(labelView)
                labelView.removeFromSuperview()
            }
            else
            {
                scrollStackView.insertArrangedSubview(stackLabel(text: hfovString.HFOV_managementWeaning.localized, scrollStackView), belowArrangedSubview: sender)
            }
            
        //VIDEOS TABS START HERE
        case hfovString.freqVentOneTab.localized:
            //if labelView is UILabel
            //let playerView = searchPlayer(playerText: hfovString.freqOneVideo.localized, subviewArray: subviewArray)
            
            //if playerView.foundFlag == true
            if freqOneBool == true
            {
                scrollStackView.removeArrangedSubview(freqOnePlayer)
                freqOnePlayer.removeFromSuperview()
                freqOneBool = false
                
            }
            else
            {
                scrollStackView.insertArrangedSubview(freqOnePlayer, belowArrangedSubview: sender)
                freqOnePlayer.leadingAnchor.constraint(equalTo: scrollStackView.leadingAnchor).isActive = true
                freqOnePlayer.trailingAnchor.constraint(equalTo: scrollStackView.trailingAnchor).isActive = true
                freqOnePlayer.heightAnchor.constraint(equalTo: freqOnePlayer.widthAnchor, multiplier: 9/16).isActive = true
                freqOneBool = true
            }
            
        case hfovString.freqVentTwoTab.localized:
            //if labelView is UILabel
            //let playerView = searchPlayer(playerText: hfovString.freqOneVideo.localized, subviewArray: subviewArray)
            
            //if playerView.foundFlag == true
            if freqTwoBool == true
            {
                scrollStackView.removeArrangedSubview(freqTwoPlayer)
                freqTwoPlayer.removeFromSuperview()
                freqTwoBool = false
                
            }
            else
            {
                scrollStackView.insertArrangedSubview(freqTwoPlayer, belowArrangedSubview: sender)
                freqTwoPlayer.leadingAnchor.constraint(equalTo: scrollStackView.leadingAnchor).isActive = true
                freqTwoPlayer.trailingAnchor.constraint(equalTo: scrollStackView.trailingAnchor).isActive = true
                freqTwoPlayer.heightAnchor.constraint(equalTo: freqTwoPlayer.widthAnchor, multiplier: 9/16).isActive = true
                freqTwoBool = true
            }
            
        case hfovString.oscillatorOneTab.localized:
            //if labelView is UILabel
            //let playerView = searchPlayer(playerText: hfovString.freqOneVideo.localized, subviewArray: subviewArray)
            
            //if playerView.foundFlag == true
            if oscOneBool == true
            {
                scrollStackView.removeArrangedSubview(oscOnePlayer)
                oscOnePlayer.removeFromSuperview()
                oscOneBool = false
                
            }
            else
            {
                scrollStackView.insertArrangedSubview(oscOnePlayer, belowArrangedSubview: sender)
                oscOnePlayer.leadingAnchor.constraint(equalTo: scrollStackView.leadingAnchor).isActive = true
                oscOnePlayer.trailingAnchor.constraint(equalTo: scrollStackView.trailingAnchor).isActive = true
                oscOnePlayer.heightAnchor.constraint(equalTo: oscOnePlayer.widthAnchor, multiplier: 9/16).isActive = true
                oscOneBool = true
            }
            
        case hfovString.oscillatorTwoTab.localized:
            //if labelView is UILabel
            //let playerView = searchPlayer(playerText: hfovString.freqOneVideo.localized, subviewArray: subviewArray)
            
            //if playerView.foundFlag == true
            if oscTwoBool == true
            {
                scrollStackView.removeArrangedSubview(oscTwoPlayer)
                oscTwoPlayer.removeFromSuperview()
                oscTwoBool = false
            }
            else
            {
                scrollStackView.insertArrangedSubview(oscTwoPlayer, belowArrangedSubview: sender)
                oscTwoPlayer.leadingAnchor.constraint(equalTo: scrollStackView.leadingAnchor).isActive = true
                oscTwoPlayer.trailingAnchor.constraint(equalTo: scrollStackView.trailingAnchor).isActive = true
                oscTwoPlayer.heightAnchor.constraint(equalTo: oscTwoPlayer.widthAnchor, multiplier: 9/16).isActive = true
                //oscTwoPlayer.bottomAnchor.constraint(equalTo: scrollStackView.bottomAnchor).isActive = true
                oscTwoBool = true
            }
        default: break
        }
        
        scrollStackView.sizeToFit()
        scrollStackView.layoutIfNeeded()
        resizeScrollEmbeddedView()
    }
    
    //Action func for sub tab buttons when pressed
    @IBAction func subTabPressed(_ sender: UIButton)
    {
        let buttonTitleString = sender.titleLabel?.text

        let monitorArray = monitorStack.subviews
        
        let stacks = [monitorStack, scrollStackView]
        
        switch(buttonTitleString)
        {
        case hfovString.xrayTab.localized:
            //if labelView is UILabel
            let labelView = searchLabel(labelText: hfovString.HFOV_managementMonitorXray.localized, subviewArray: monitorArray)
            
            if labelView.text == hfovString.HFOV_managementMonitorXray.localized
            {
                monitorStack.removeArrangedSubview(labelView)
                labelView.removeFromSuperview()
            }
            else
            {
                monitorStack.insertArrangedSubview(stackLabel(text: hfovString.HFOV_managementMonitorXray.localized, monitorStack), belowArrangedSubview: sender)
            }
            
        case hfovString.gasTab.localized:
            //if labelView is UILabel
            let labelView = searchLabel(labelText: hfovString.HFOV_managementMonitorGas.localized, subviewArray: monitorArray)
            
            if labelView.text == hfovString.HFOV_managementMonitorGas.localized
            {
                monitorStack.removeArrangedSubview(labelView)
                labelView.removeFromSuperview()
            }
            else
            {
                monitorStack.insertArrangedSubview(stackLabel(text: hfovString.HFOV_managementMonitorGas.localized, monitorStack), belowArrangedSubview: sender)
            }

            
        default: break
        }
        
        for stk in stacks
        {
            stk.sizeToFit()
            stk.layoutIfNeeded()
        }
        resizeScrollEmbeddedView()
    }
    
    //Populate sub tab stack for Modes
    func populateStack(_ sender: UIView, _ buttons: [UIButton], _ index: inout Int, _ stk: inout UIStackView)
    {
        scrollStackView.insertArrangedSubview(stk, belowArrangedSubview: sender)
        stk.translatesAutoresizingMaskIntoConstraints = false
        //stk.topAnchor.constraint(equalTo: scrollDetails.bottomAnchor).isActive = true
        stk.leadingAnchor.constraint(equalTo: scrollStackView.leadingAnchor).isActive = true
        stk.trailingAnchor.constraint(equalTo: scrollStackView.trailingAnchor).isActive = true
        for btn in buttons.enumerated()
        {
            //Assign action to take when pressed
            btn.element.addTarget(self, action: #selector(subTabPressed(_:)), for: .touchUpInside)
            btn.element.configuration?.attributedTitle = AttributedString(hfovString.allCases[index].localized, attributes: AttributeContainer([NSAttributedString.Key.font : UIFont(name: FONT_STYLE_ARIAL, size: FONT_SIZE_15)!]))
            btn.element.setContentCompressionResistancePriority(UILayoutPriority.required, for: NSLayoutConstraint.Axis.vertical)
            btn.element.sizeToFit()
            
            if btn.offset == buttons.startIndex
            {
                stk.insertArrangedSubview(btn.element, at: 0)
            }
            else
            {
                stk.insertArrangedSubview(btn.element, belowArrangedSubview: buttons[btn.offset - 1])
            }
            index += 1
        }
        
        stk.spacing = STACK_SPACING
        stk.sizeToFit()
        stk.layoutIfNeeded()
    }
    
    //Remove Mode stack view and subviews
    func removeModeStack(_ subStack: inout UIStackView)
    {
        for sub in subStack.subviews
        {
            subStack.removeArrangedSubview(sub)
            sub.removeFromSuperview()
        }
        subStack.sizeToFit()
        subStack.layoutIfNeeded()
        scrollStackView.removeArrangedSubview(subStack)
        subStack.removeFromSuperview()
    }
    
    //Remove Details stack view and subviews and YT player
    func removeSubButtons()
    {
        monitorFlag = false
        
        if scrollStackView.isDescendant(of: scrollEmbeddedView)
        {
            for view in scrollStackView.subviews
            {
                scrollStackView.removeArrangedSubview(view)
                view.removeFromSuperview()
            }
            scrollStackView.sizeToFit()
            scrollStackView.layoutIfNeeded()
            scrollStackView.removeFromSuperview()
        }
        if monitorStack.isDescendant(of: scrollStackView)
        {
            for view in monitorStack.subviews
            {
                monitorStack.removeArrangedSubview(view)
                view.removeFromSuperview()
            }
            monitorStack.sizeToFit()
            monitorStack.layoutIfNeeded()
            monitorStack.removeFromSuperview()
        }
    }
}
