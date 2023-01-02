//
//  hfjvChild.swift
//  Coy_Test
//
//  Created by Coy Coburn on 11/6/22.
//

import Foundation
import youtube_ios_player_helper

//If HFJV locals indexes are changed, update this macro
let HFJV_SETTINGS_INDEX = 8
let HFJV_MODE_INDEX = 15
let HFJV_SETTINGS_SUBTAB_INDEX = 17
let HFJV_GAS_MAN_SUBTAB_INDEX = 24
let HFJV_PRESSURE_INDEX = 33
let HFJV_FOR_INDEX = 36
let HFJV_MONITOR_INDEX = 68

/* Child COntainer Class */
class hfjvChild: UIViewController {
    @IBOutlet var menuButton: UIButton!
    @IBOutlet var scrollDetails: UILabel!
    @IBOutlet var playerDetails: YTPlayerView!
    @IBOutlet var scrollEmbeddedView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    
    @IBOutlet var scrollEmbeddedHeight: NSLayoutConstraint!
    
    lazy var scrollStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        //stackView.spacing = STACK_SPACING
        stackView.alignment = .center
        return stackView
    }()
    
    lazy var cpapStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        return stackView
    }()
    
    lazy var cmvStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        return stackView
    }()
    
    lazy var servoStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        return stackView
    }()
    
    lazy var monitorStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        return stackView
    }()
    
    //Flags for Mode sub tabs
    var cpapFlag: Bool = false
    var cmvFlag: Bool = false
    var monitorFlag: Bool = false
    
    //UIButton.Configuration is for iOS 15 or greater
    var buttonConfig = UIButton.Configuration.gray()
    var subTabConfig = UIButton.Configuration.gray()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        scrollDetails.text = hfjvString.HFJV_what.localized
        titleLabel.text = MainString.hfjv.localized

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
        
        //Set up the scrollDetails to be "clickable"
        //let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.checkForUrlClick))
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapLabel(gesture:)))
        //CC TODO split this into all UIActions of menu list
        //self.scrollDetails.isUserInteractionEnabled = true
        self.scrollDetails.addGestureRecognizer(tapGesture)
        self.scrollDetails.isUserInteractionEnabled = false
        
        createOverview()
    }
    
    func addMenuItems() -> UIMenu
    {
        let menuItems = UIMenu(title: "", options: .displayInline, children: [
            
            //Overview Tab
            UIAction(title: MainString.What.localized, handler: { (_) in
                self.scrollDetails.text = hfjvString.HFJV_what.localized
                self.removeSubButtons()
                self.scrollDetails.isUserInteractionEnabled = false
                self.createOverview()
                self.resizeScrollEmbeddedView()
            }),
            
            //Considerations tab
            UIAction(title: MainString.When.localized, handler: { (_) in
                self.scrollDetails.text = hfjvString.HFJV_when.localized
                //self.menuButton.setTitle(MainString.When.localized, for: .normal)
                //let label = MainString.When.localized
                //self.checkPlayerVisibility(buttonText: label)
                //self.clearCounts()
                self.removeSubButtons()
                self.scrollDetails.isUserInteractionEnabled = false
                self.resizeScrollEmbeddedView()
            }),
            
            //Settings tab
            UIAction(title: MainString.Settings.localized, handler: { (_) in
                self.scrollDetails.text = ""
                self.scrollDetails.isUserInteractionEnabled = false
                self.removeSubButtons()
                let tabText = MainString.Settings.localized
                self.createSubButtons(buttonText: tabText)
            }),
            
            //Management tab
            UIAction(title: MainString.Management.localized, handler: { (_) in
                self.scrollDetails.text = ""
                //self.menuButton.setTitle(MainString.Management.localized, for: .normal)
                //let label = MainString.Management.localized
                //self.checkPlayerVisibility(buttonText: label)
                self.scrollDetails.isUserInteractionEnabled = false
                //self.resizeScrollEmbeddedView()
                //self.clearCounts()
                self.removeSubButtons()
                let tabText = MainString.Management.localized
                self.createSubButtons(buttonText: tabText)

            }),
            
            //Tips tab
            UIAction(title: MainString.Tips.localized, handler: { (_) in
                self.scrollDetails.text = hfjvString.HFJV_tips.localized
                self.removeSubButtons()
                self.scrollDetails.isUserInteractionEnabled = false
                self.resizeScrollEmbeddedView()
            }),
            
            //Manuals tab
            UIAction(title: MainString.Manuals.localized, handler: { (_) in
                //self.menuButton.setTitle(MainString.Manuals.localized, for: .normal)
                
                let linksString = hfjvString.HFJV_links.localized
                //Setting up proper NSranges
                let regex = try! NSRegularExpression(pattern: #"[^\n]+"#)
                let matches = regex.matches(in: linksString, range: NSRange(linksString.startIndex..., in: linksString))
                let ranges = matches.map { $0.range }
                
                //attributedString.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 29, length: 24))
                self.scrollDetails.text = linksString
                
                //Modifying string to look like url links
                let attributedString = NSMutableAttributedString(string: linksString)
                attributedString.addAttribute(.link, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: ranges[1].location + 1, length: ranges[1].length - 1))
                attributedString.addAttribute(.link, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: ranges[3].location + 1, length: ranges[3].length - 1))
                self.scrollDetails.attributedText = attributedString
                
                //let label = MainString.Tips.localized
                //self.checkPlayerVisibility(buttonText: label)
                
                //self.clearCounts()
                self.removeSubButtons()
                self.scrollDetails.isUserInteractionEnabled = true
                self.resizeScrollEmbeddedView()
            })
        ])
        
        return menuItems
    }
    
    func checkPlayerVisibility(buttonText: String)
    {
        
        if buttonText != MainString.Video.localized
        {
            self.playerDetails.alpha = 0
        }
        else
        {
            self.playerDetails.alpha = 1
        }
    }
    
    func resizeScrollEmbeddedView()
    {
        //let labelHeight = scrollDetails.intrinsicContentSize.height
        //let playerHeight = playerDetails.intrinsicContentSize.height
        
        //var subviewArr = [UIView]()
        //if scrollEmbeddedView.subviews.count == 0
        
        var subviewHeight: CGFloat = 0
        var count = 0
        for subview in scrollEmbeddedView.subviews
        {
            if let stack = subview as? UIStackView
            {
                for stackSubview in stack.subviews
                {
                    if let subStack = stackSubview as? UIStackView
                    {
                        for subSubview in subStack.subviews
                        {
                            subSubview.sizeToFit()
                            subSubview.layoutIfNeeded()
                            subviewHeight += subSubview.intrinsicContentSize.height
                            count += 1
                        }
                    }
                    else
                    {
                        stackSubview.sizeToFit()
                        stackSubview.layoutIfNeeded()
                        subviewHeight += stackSubview.intrinsicContentSize.height
                        count += 1
                    }
                }
                subviewHeight += (STACK_SPACING * CGFloat(count))
            }
            subviewHeight += subview.intrinsicContentSize.height
            count += 1
        }
        
        print(subviewHeight, count)
            
        //scrollEmbeddedHeight.constant = labelHeight + playerHeight
        scrollEmbeddedHeight.constant = subviewHeight
        //scrollEmbeddedView.sizeToFit()
        scrollEmbeddedView.layoutIfNeeded()
    }
    
    //Func: tapLabel
    @IBAction func tapLabel(gesture: UITapGestureRecognizer) {
        
        let linksString = hfjvString.HFJV_links.localized
        //Setting up proper NSranges
        let regex = try! NSRegularExpression(pattern: #"[^\n]+"#)
        let matches = regex.matches(in: linksString, range: NSRange(linksString.startIndex..., in: linksString))
        let ranges = matches.map { $0.range }

        //print(ranges)
        //print(ranges[1].location, ranges[1].length)
        
        //Checking whether any of the urls were pressed
        if gesture.didTapAttributedTextInLabel(label: self.scrollDetails, inRange: NSRange(location: ranges[1].location, length: ranges[1].length)) {
            print("Tapped targetRange1\n\n")
            if let urlOpen = URL(string: hfjvString.Bunnell_manual.localized)
            {
                UIApplication.shared.open(urlOpen, options: [:])
            }
        } else if gesture.didTapAttributedTextInLabel(label: self.scrollDetails, inRange: NSRange(location: ranges[3].location, length: ranges[3].length)) {
            print("Tapped targetRange2\n\n")
            if let urlOpen = URL(string: hfjvString.Bunnell_video.localized)
            {
                UIApplication.shared.open(urlOpen, options: [:])
            }
        } else {
            print("Tapped none\n\n")
        }
    }
    
    func createOverview()
    {
        scrollEmbeddedView.addSubview(scrollStackView)
        scrollStackView.translatesAutoresizingMaskIntoConstraints = false
        scrollStackView.topAnchor.constraint(equalTo: scrollDetails.bottomAnchor).isActive = true
        scrollStackView.leadingAnchor.constraint(equalTo: scrollEmbeddedView.leadingAnchor).isActive = true
        scrollStackView.trailingAnchor.constraint(equalTo: scrollEmbeddedView.trailingAnchor).isActive = true
        
        let advButton = UIButton(configuration: subTabConfig)
        //Assign action to take when pressed
        advButton.addTarget(self, action: #selector(subButtonPressed(_:)), for: .touchUpInside)
        advButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        advButton.configuration?.attributedTitle = AttributedString(hfjvString.advSubTab.localized, attributes: AttributeContainer([NSAttributedString.Key.font : UIFont(name: FONT_STYLE_ARIAL, size: FONT_SIZE_15)!]))
        advButton.sizeToFit()
        //Add buttons to new stack
        scrollStackView.insertArrangedSubview(advButton, at: hfjvOverviewIndex.allCases.startIndex)
        //scrollStackView.setCustomSpacing(15, after: button)
        
        scrollStackView.spacing = STACK_SPACING
        scrollStackView.distribution = .fillProportionally
        scrollStackView.sizeToFit()
        scrollStackView.layoutIfNeeded()
        resizeScrollEmbeddedView()
        print("Overview Height: ",scrollStackView.intrinsicContentSize.height)

        
    }
    
    //Func: createSubButtons
    func createSubButtons(buttonText: String)
    {
        
        //let subButtonStack = UIStackView()
        //subButtonStack.axis = .vertical
        //subButtonStack.alignment = .fill
        //subButtonStack.distribution = .fillEqually
        
        scrollEmbeddedView.addSubview(scrollStackView)
        scrollStackView.translatesAutoresizingMaskIntoConstraints = false
        
        //Place scrollStackView between the label and YT player views
        //scrollDetails.bottomAnchor.constraint(equalTo: scrollStackView.topAnchor).isActive = true
        //playerDetails.topAnchor.constraint(equalTo: scrollStackView.bottomAnchor).isActive = true
        
        //Constrain scrollStackView
        scrollStackView.topAnchor.constraint(equalTo: scrollDetails.bottomAnchor).isActive = true
        scrollStackView.leadingAnchor.constraint(equalTo: scrollEmbeddedView.leadingAnchor).isActive = true
        scrollStackView.trailingAnchor.constraint(equalTo: scrollEmbeddedView.trailingAnchor).isActive = true
        //scrollStackView.bottomAnchor.constraint(equalTo: scrollEmbeddedView.bottomAnchor).isActive = true
        //scrollStackView.heightAnchor.constraint(equalTo: scrollEmbeddedView.heightAnchor).isActive = true
        
        
        switch(buttonText)
        {
            case MainString.Management.localized:
                //Create buttons
                let gasOneButton = UIButton(configuration: buttonConfig)
                let gasTwoButton = UIButton(configuration: buttonConfig)
                let gasThreeButton = UIButton(configuration: buttonConfig)
                let gasFourButton = UIButton(configuration: buttonConfig)
                let hyperButton = UIButton(configuration: buttonConfig)
                let hypoButton = UIButton(configuration: buttonConfig)
                let lungButton = UIButton(configuration: buttonConfig)
                let monitorButton = UIButton(configuration: buttonConfig)
                let weaningButton = UIButton(configuration: buttonConfig)
                
                let gasButtons = [gasOneButton,gasTwoButton, gasThreeButton, gasFourButton]
                let manButtons = [hyperButton, hypoButton, lungButton, monitorButton, weaningButton]
                var enumIndex = hfjvManagementIndex.allCases.startIndex
                var titleIndex = hfjvString.allCases.index(after: HFJV_GAS_MAN_SUBTAB_INDEX)
            
                for button in gasButtons
                {
                    //Assign action to take when pressed
                    button.addTarget(self, action: #selector(subButtonPressed(_:)), for: .touchUpInside)
                    button.titleLabel?.lineBreakMode = .byWordWrapping
                    button.titleLabel?.textAlignment = .center
                    //button.heightAnchor.constraint(equalToConstant: 20).isActive = true
                    button.configuration?.attributedTitle = AttributedString(hfjvString.allCases[titleIndex].localized, attributes: AttributeContainer([NSAttributedString.Key.font : UIFont(name: FONT_STYLE_ARIAL, size: FONT_SIZE_15)!]))
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
                    button.heightAnchor.constraint(equalToConstant: 20).isActive = true
                    button.configuration?.attributedTitle = AttributedString(MainString.allCases[titleIndex].localized, attributes: AttributeContainer([NSAttributedString.Key.font : UIFont(name: FONT_STYLE_ARIAL, size: FONT_SIZE_15)!]))
                    button.sizeToFit()
                    //Add buttons to new stack
                    scrollStackView.insertArrangedSubview(button, at: enumIndex)
                    //scrollStackView.setCustomSpacing(15, after: button)
                    enumIndex = enumIndex + 1
                    titleIndex = titleIndex + 1
                }
                break
                
            case MainString.Settings.localized:
                let pipButton = UIButton(configuration: buttonConfig)
                let rateButton = UIButton(configuration: buttonConfig)
                let inspiratoryButton = UIButton(configuration: buttonConfig)
                let deltaPButton = UIButton(configuration: buttonConfig)
                let pressureButton = UIButton(configuration: buttonConfig)
                let peepButton = UIButton(configuration: buttonConfig)
                let backupButton = UIButton(configuration: buttonConfig)
                
                let setButtons = [pipButton, rateButton, inspiratoryButton, deltaPButton, pressureButton, peepButton, backupButton]
                var enumIndex = hfjvSettingsIndex.allCases.startIndex
                var titleIndex = hfjvString.allCases.index(after: HFJV_SETTINGS_INDEX)
                
                for button in setButtons
                {
                    //Assign action to take when pressed
                    button.addTarget(self, action: #selector(subButtonPressed(_:)), for: .touchUpInside)
                    //button.setTitle(hfjvString.allCases[titleIndex].localized, for: .normal)
                    button.heightAnchor.constraint(equalToConstant: 20).isActive = true
                    button.configuration?.attributedTitle = AttributedString(hfjvString.allCases[titleIndex].localized, attributes: AttributeContainer([NSAttributedString.Key.font : UIFont(name: FONT_STYLE_ARIAL, size: FONT_SIZE_15)!]))
                    button.sizeToFit()
                    
                    //Add buttons to new stack
                    scrollStackView.insertArrangedSubview(button, at: enumIndex)
                    enumIndex = enumIndex + 1
                    titleIndex = titleIndex + 1
                    
                }
                break
                    
            default: break
        }

        //print("Height2: ",scrollStackView.frame.height)
        scrollStackView.spacing = STACK_SPACING
        scrollStackView.distribution = .fillProportionally
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
            
        //OVERVIEW TABS START HERE
        case hfjvString.advSubTab.localized:
            //if labelView is UILabel
            var labelView = searchLabel(labelText: hfjvString.HFJV_advantagesTwo.localized, subviewArray: subviewArray)
            
            if labelView.text == hfjvString.HFJV_advantagesTwo.localized
            {
                //Starting from bottom of stack to top for this removal case
                scrollStackView.removeArrangedSubview(labelView)
                labelView.removeFromSuperview()
                
                //If the Transitional Flow label is open, we need to remove it as well
                labelView = searchLabel(labelText: hfjvString.HFJV_transitionalFlow.localized, subviewArray: subviewArray)
                if labelView.text == hfjvString.HFJV_transitionalFlow.localized
                {
                    scrollStackView.removeArrangedSubview(labelView)
                    labelView.removeFromSuperview()
                }
                
                //Remove the embedded button under Advantages
                for subTab in subviewArray
                {
                    if let sub = subTab as? UIButton
                    {
                        if sub.titleLabel?.text == hfjvString.flowSubTab.localized
                        {
                            scrollStackView.removeArrangedSubview(sub)
                            sub.removeFromSuperview()
                        }
                    }
                }
                
                //Final label to remove
                labelView = searchLabel(labelText: hfjvString.HFJV_advantagesOne.localized, subviewArray: subviewArray)
                scrollStackView.removeArrangedSubview(labelView)
                labelView.removeFromSuperview()
                
            }
            else
            {
                let advLabelOne = stackLabel(text: hfjvString.HFJV_advantagesOne.localized, scrollStackView)
                let advLabelTwo = stackLabel(text: hfjvString.HFJV_advantagesTwo.localized, scrollStackView)
                let flowButton = UIButton(configuration: subTabConfig)
                
                //Assign action to take when pressed
                flowButton.addTarget(self, action: #selector(subButtonPressed(_:)), for: .touchUpInside)
                flowButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
                flowButton.configuration?.attributedTitle = AttributedString(hfjvString.flowSubTab.localized, attributes: AttributeContainer([NSAttributedString.Key.font : UIFont(name: FONT_STYLE_ARIAL, size: FONT_SIZE_15)!]))
                flowButton.sizeToFit()
                
                scrollStackView.insertArrangedSubview(advLabelOne, belowArrangedSubview: sender)
                scrollStackView.insertArrangedSubview(flowButton, belowArrangedSubview: advLabelOne)
                scrollStackView.insertArrangedSubview(advLabelTwo, belowArrangedSubview: flowButton)
            }
            
        case hfjvString.flowSubTab.localized:
            
            //if labelView is UILabel
            let labelView = searchLabel(labelText: hfjvString.HFJV_transitionalFlow.localized, subviewArray: subviewArray)
            
            if labelView.text == hfjvString.HFJV_transitionalFlow.localized
            {
                scrollStackView.removeArrangedSubview(labelView)
                labelView.removeFromSuperview()
            }
            else
            {
                scrollStackView.insertArrangedSubview(stackLabel(text: hfjvString.HFJV_transitionalFlow.localized, scrollStackView), belowArrangedSubview: sender)
            }
            
        //SETTINGS TABS START HERE
        case hfjvString.pipTab.localized:
            //if labelView is UILabel
            let labelView = searchLabel(labelText: hfjvString.HFJV_settingsPip.localized, subviewArray: subviewArray)
            
            if labelView.text == hfjvString.HFJV_settingsPip.localized
            {
                scrollStackView.removeArrangedSubview(labelView)
                labelView.removeFromSuperview()
            }
            else
            {
                scrollStackView.insertArrangedSubview(stackLabel(text: hfjvString.HFJV_settingsPip.localized, scrollStackView), belowArrangedSubview: sender)
            }
            
        case hfjvString.forTab.localized:
            var labelView = searchLabel(labelText: hfjvString.HFJV_settingsFreq.localized, subviewArray: subviewArray)
            
            if labelView.text == hfjvString.HFJV_settingsFreq.localized
            {
                let temp = labelView
                
                //Starting from bottom of stack to top for this removal case
                let labelTexts = [ hfjvString.HFJV_freqLow.localized,
                                   hfjvString.HFJV_freqHigh.localized]
                
                for str in labelTexts
                {
                    labelView = searchLabel(labelText: str, subviewArray: subviewArray)
                    if labelView.text == str
                    {
                        scrollStackView.removeArrangedSubview(labelView)
                        labelView.removeFromSuperview()
                    }
                }
                
                //Remove the embedded buttons under Pressure
                let btnTexts = [ hfjvString.lowFreqSubTab.localized,
                                 hfjvString.highFreqSubTab.localized]
                
                for str in btnTexts
                {
                    for subTab in subviewArray
                    {
                        if let sub = subTab as? UIButton
                        {
                            if sub.titleLabel?.text == str
                            {
                                scrollStackView.removeArrangedSubview(sub)
                                sub.removeFromSuperview()
                            }
                        }
                    }
                }
                
                //Final label to remove
                scrollStackView.removeArrangedSubview(temp)
                temp.removeFromSuperview()
            }
            else
            {
                let forLabel = stackLabel(text: hfjvString.HFJV_settingsFreq.localized, scrollStackView)
                let lowButton = UIButton(configuration: subTabConfig)
                let highButton = UIButton(configuration: subTabConfig)

                var titleIndex = hfjvString.allCases.index(after: HFJV_FOR_INDEX)
                
                let buttons = [lowButton, highButton]
                
                scrollStackView.insertArrangedSubview(forLabel, belowArrangedSubview: sender)
                
                for btn in buttons.enumerated()
                {
                    //Assign action to take when pressed
                    btn.element.addTarget(self, action: #selector(subTabPressed(_:)), for: .touchUpInside)
                    btn.element.heightAnchor.constraint(equalToConstant: 20).isActive = true
                    btn.element.configuration?.attributedTitle = AttributedString(hfjvString.allCases[titleIndex].localized, attributes: AttributeContainer([NSAttributedString.Key.font : UIFont(name: FONT_STYLE_ARIAL, size: FONT_SIZE_15)!]))
                    btn.element.sizeToFit()
                    
                    if btn.offset == buttons.startIndex
                    {
                        scrollStackView.insertArrangedSubview(btn.element, belowArrangedSubview: forLabel)
                    }
                    else
                    {
                        scrollStackView.insertArrangedSubview(btn.element, belowArrangedSubview: buttons[btn.offset - 1])
                    }
                    titleIndex += 1
                }
            }
            
        case hfjvString.inspiratoryTab.localized:
            //if labelView is UILabel
            let labelView = searchLabel(labelText: hfjvString.HFJV_settingsInspiratory.localized, subviewArray: subviewArray)
            
            if labelView.text == hfjvString.HFJV_settingsInspiratory.localized
            {
                scrollStackView.removeArrangedSubview(labelView)
                labelView.removeFromSuperview()
            }
            else
            {
                scrollStackView.insertArrangedSubview(stackLabel(text: hfjvString.HFJV_settingsInspiratory.localized, scrollStackView), belowArrangedSubview: sender)
            }
            
        
        case hfjvString.deltaTab.localized:
            //if labelView is UILabel
            let labelView = searchLabel(labelText: hfjvString.HFJV_settingsDelta.localized, subviewArray: subviewArray)
            
            if labelView.text == hfjvString.HFJV_settingsDelta.localized
            {
                scrollStackView.removeArrangedSubview(labelView)
                labelView.removeFromSuperview()
            }
            else
            {
                scrollStackView.insertArrangedSubview(stackLabel(text: hfjvString.HFJV_settingsDelta.localized, scrollStackView), belowArrangedSubview: sender)
            }
            
        case hfjvString.pressureTab.localized:
            //if labelView is UILabel
            var labelView = searchLabel(labelText: hfjvString.HFJV_settingsPressure.localized, subviewArray: subviewArray)
            
            if labelView.text == hfjvString.HFJV_settingsPressure.localized
            {
                let temp = labelView
                
                removeModeStack(&servoStack)
                
                //Final label to remove
                scrollStackView.removeArrangedSubview(temp)
                temp.removeFromSuperview()
            }
            else
            {
                let pressureLabel = stackLabel(text: hfjvString.HFJV_settingsPressure.localized, scrollStackView)
                let incButton = UIButton(configuration: subTabConfig)
                let decButton = UIButton(configuration: subTabConfig)
                let flucButton = UIButton(configuration: subTabConfig)
                
                flucButton.titleLabel?.lineBreakMode = .byWordWrapping
                flucButton.titleLabel?.textAlignment = .center

                var titleIndex = hfjvString.allCases.index(after: HFJV_PRESSURE_INDEX)
                
                let buttons = [incButton, decButton, flucButton]
                
                scrollStackView.insertArrangedSubview(pressureLabel, belowArrangedSubview: sender)
                
                populateStack(pressureLabel, buttons, &titleIndex, &servoStack)
            }
            
        case hfjvString.peepTab.localized:
            //if labelView is UILabel
            let labelView = searchLabel(labelText: hfjvString.HFJV_settingsPeep.localized, subviewArray: subviewArray)
            
            if labelView.text == hfjvString.HFJV_settingsPeep.localized
            {
                scrollStackView.removeArrangedSubview(labelView)
                labelView.removeFromSuperview()
            }
            else
            {
                scrollStackView.insertArrangedSubview(stackLabel(text: hfjvString.HFJV_settingsPeep.localized, scrollStackView), belowArrangedSubview: sender)
            }
            
        case hfjvString.backupTab.localized:
            
            let labelView = searchLabel(labelText: hfjvString.HFJV_settingsBackup.localized, subviewArray: subviewArray)
            
            if labelView.text == hfjvString.HFJV_settingsBackup.localized
            {
                //Cache labelView so we can remove it last
                let temp = labelView
                
                //Remove the Mode stacks
                removeModeStack(&cpapStack)
                removeModeStack(&cmvStack)
                cpapFlag = false
                cmvFlag = false
                
                //Remove the embedded buttons under VentMeas
                let btnTexts = [ hfjvString.cpapSubTab.localized,
                                 hfjvString.cmvSubTab.localized, ]
                for str in btnTexts
                {
                    for subTab in subviewArray
                    {
                        if let sub = subTab as? UIButton
                        {
                            if sub.titleLabel?.text == str
                            {
                                scrollStackView.removeArrangedSubview(sub)
                                sub.removeFromSuperview()
                            }
                        }
                    }
                }
                
                //Final label to remove
                scrollStackView.removeArrangedSubview(temp)
                temp.removeFromSuperview()
                
            }
            else
            {
                let backupLabel = stackLabel(text: hfjvString.HFJV_settingsBackup.localized, scrollStackView)
                let cpapMode = UIButton(configuration: subTabConfig)
                let cmvMode = UIButton(configuration: subTabConfig)
                
                var titleIndex = hfjvString.allCases.index(after: HFJV_MODE_INDEX)
                
                let buttons = [cpapMode,cmvMode]
                
                scrollStackView.insertArrangedSubview(backupLabel, belowArrangedSubview: sender)
                
                for btn in buttons.enumerated()
                {
                    //Assign action to take when pressed
                    btn.element.addTarget(self, action: #selector(subTabPressed(_:)), for: .touchUpInside)
                    //btn.element.setTitle(hfjvString.allCases[titleIndex].localized, for: .normal)
                    btn.element.heightAnchor.constraint(equalToConstant: 20).isActive = true
                    btn.element.configuration?.attributedTitle = AttributedString(hfjvString.allCases[titleIndex].localized, attributes: AttributeContainer([NSAttributedString.Key.font : UIFont(name: FONT_STYLE_ARIAL, size: FONT_SIZE_15)!]))
                    btn.element.sizeToFit()
                    
                    if btn.offset == buttons.startIndex
                    {
                        scrollStackView.insertArrangedSubview(btn.element, belowArrangedSubview: backupLabel)
                    }
                    else
                    {
                        scrollStackView.insertArrangedSubview(btn.element, belowArrangedSubview: buttons[btn.offset - 1])
                    }
                    titleIndex += 1
                }
            }
            
        //MANAGEMENT TABS START HERE
        case hfjvString.gasOneTab.localized:
            //if labelView is UILabel
            let labelView = searchLabel(labelText: hfjvString.HFJV_managementGasOne.localized, subviewArray: subviewArray)
            
            if labelView.text == hfjvString.HFJV_managementGasOne.localized
            {
                scrollStackView.removeArrangedSubview(labelView)
                labelView.removeFromSuperview()
            }
            else
            {
                scrollStackView.insertArrangedSubview(stackLabel(text: hfjvString.HFJV_managementGasOne.localized, scrollStackView), belowArrangedSubview: sender)
            }
            
        case hfjvString.gasTwoTab.localized:
            //if labelView is UILabel
            let labelView = searchLabel(labelText: hfjvString.HFJV_managementGasTwo.localized, subviewArray: subviewArray)
            
            if labelView.text == hfjvString.HFJV_managementGasTwo.localized
            {
                scrollStackView.removeArrangedSubview(labelView)
                labelView.removeFromSuperview()
            }
            else
            {
                scrollStackView.insertArrangedSubview(stackLabel(text: hfjvString.HFJV_managementGasTwo.localized, scrollStackView), belowArrangedSubview: sender)
            }
            
        case hfjvString.gasThreeTab.localized:
            //if labelView is UILabel
            let labelView = searchLabel(labelText: hfjvString.HFJV_managementGasThree.localized, subviewArray: subviewArray)
            
            if labelView.text == hfjvString.HFJV_managementGasThree.localized
            {
                scrollStackView.removeArrangedSubview(labelView)
                labelView.removeFromSuperview()
            }
            else
            {
                scrollStackView.insertArrangedSubview(stackLabel(text: hfjvString.HFJV_managementGasThree.localized, scrollStackView), belowArrangedSubview: sender)
            }
            
        case hfjvString.gasFourTab.localized:
            //if labelView is UILabel
            let labelView = searchLabel(labelText: hfjvString.HFJV_managementGasFour.localized, subviewArray: subviewArray)
            
            if labelView.text == hfjvString.HFJV_managementGasFour.localized
            {
                scrollStackView.removeArrangedSubview(labelView)
                labelView.removeFromSuperview()
            }
            else
            {
                scrollStackView.insertArrangedSubview(stackLabel(text: hfjvString.HFJV_managementGasFour.localized, scrollStackView), belowArrangedSubview: sender)
            }
            
        case MainString.hyperTab.localized:
            //if labelView is UILabel
            let labelView = searchLabel(labelText: hfjvString.HFJV_managementHyper.localized, subviewArray: subviewArray)
            
            if labelView.text == hfjvString.HFJV_managementHyper.localized
            {
                scrollStackView.removeArrangedSubview(labelView)
                labelView.removeFromSuperview()
            }
            else
            {
                scrollStackView.insertArrangedSubview(stackLabel(text: hfjvString.HFJV_managementHyper.localized, scrollStackView), belowArrangedSubview: sender)
            }
            
        case MainString.hypoTab.localized:
            //if labelView is UILabel
            let labelView = searchLabel(labelText: hfjvString.HFJV_managementHypo.localized, subviewArray: subviewArray)
            
            if labelView.text == hfjvString.HFJV_managementHypo.localized
            {
                scrollStackView.removeArrangedSubview(labelView)
                labelView.removeFromSuperview()
            }
            else
            {
                scrollStackView.insertArrangedSubview(stackLabel(text: hfjvString.HFJV_managementHypo.localized, scrollStackView), belowArrangedSubview: sender)
            }
            
        
        case MainString.lungTab.localized:
            //if labelView is UILabel
            let labelView = searchLabel(labelText: hfjvString.HFJV_managementLung.localized, subviewArray: subviewArray)
            
            if labelView.text == hfjvString.HFJV_managementLung.localized
            {
                scrollStackView.removeArrangedSubview(labelView)
                labelView.removeFromSuperview()
            }
            else
            {
                scrollStackView.insertArrangedSubview(stackLabel(text: hfjvString.HFJV_managementLung.localized, scrollStackView), belowArrangedSubview: sender)
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
                var titleIndex = hfjvString.allCases.index(after: HFJV_MONITOR_INDEX)
                
                populateStack(sender, buttons, &titleIndex, &monitorStack)
                monitorFlag = true
            }
            
        case MainString.weaningTab.localized:
            //if labelView is UILabel
            let labelView = searchLabel(labelText: hfjvString.HFJV_managementWeaning.localized, subviewArray: subviewArray)
            
            if labelView.text == hfjvString.HFJV_managementWeaning.localized
            {
                scrollStackView.removeArrangedSubview(labelView)
                labelView.removeFromSuperview()
            }
            else
            {
                scrollStackView.insertArrangedSubview(stackLabel(text: hfjvString.HFJV_managementWeaning.localized, scrollStackView), belowArrangedSubview: sender)
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

        let cmvArray = cmvStack.subviews
        let cpapArray = cpapStack.subviews
        let servoArray = servoStack.subviews
        let monitorArray = monitorStack.subviews
        let scrollArray = scrollStackView.subviews
        
        let stacks = [cmvStack, cpapStack, servoStack, monitorStack, scrollStackView]
        
        switch(buttonTitleString)
        {
        case hfjvString.cpapSubTab.localized:

            if cpapFlag == true
            {
                removeModeStack(&cpapStack)
                cpapFlag = false
            }
            else
            {
                cpapFlag = true
                let pinspButton = UIButton(configuration: subTabConfig)
                let peepButton = UIButton(configuration: subTabConfig)
                
                let buttons = [pinspButton, peepButton]
                
                var titleIndex = hfjvString.allCases.index(after: HFJV_SETTINGS_SUBTAB_INDEX)
                
                populateStack(sender, buttons, &titleIndex, &cpapStack)
            }
            cpapStack.sizeToFit()
            cpapStack.layoutIfNeeded()
            
        case hfjvString.cmvSubTab.localized:
            
            if cmvFlag == true
            {
                removeModeStack(&cmvStack)
                cmvFlag = false
            }
            else
            {
                cmvFlag = true
                let peepButton = UIButton(configuration: subTabConfig)
                let rateButton = UIButton(configuration: subTabConfig)
                let itimeButton = UIButton(configuration: subTabConfig)
                let pipButton = UIButton(configuration: subTabConfig)
                let slopeButton = UIButton(configuration: subTabConfig)
                let breathButton = UIButton(configuration: subTabConfig)
                
                let buttons = [peepButton,rateButton, itimeButton, pipButton, slopeButton, breathButton]
                
                var titleIndex = hfjvString.allCases.index(after: HFJV_SETTINGS_SUBTAB_INDEX + 1)
                
                populateStack(sender, buttons, &titleIndex, &cmvStack)
            }
            cmvStack.sizeToFit()
            cmvStack.layoutIfNeeded()
            
        case hfjvString.pinspSubTab.localized:
            //if labelView is UILabel
            let labelView = searchLabel(labelText: hfjvString.HFJV_cpapPinsp.localized, subviewArray: cpapArray)
            
            if labelView.text == hfjvString.HFJV_cpapPinsp.localized
            {
                cpapStack.removeArrangedSubview(labelView)
                labelView.removeFromSuperview()
            }
            else
            {
                cpapStack.insertArrangedSubview(stackLabel(text: hfjvString.HFJV_cpapPinsp.localized, cpapStack), belowArrangedSubview: sender)
            }
            
        case hfjvString.peepSubTab.localized:
            //if labelView is UILabel
            let labelView: UILabel
            
            var stk: UIStackView
            var str: String
            
            if sender.isDescendant(of: cpapStack)
            {
                stk = cpapStack
                labelView = searchLabel(labelText: hfjvString.HFJV_cpapPEEP.localized, subviewArray: cpapArray)
                str = hfjvString.HFJV_cpapPEEP.localized
            }
            else
            {
                stk = cmvStack
                labelView = searchLabel(labelText: hfjvString.HFJV_cmvPEEP.localized, subviewArray: cmvArray)
                str = hfjvString.HFJV_cmvPEEP.localized
            }
            
            if labelView.text == hfjvString.HFJV_cpapPEEP.localized
            {
                stk.removeArrangedSubview(labelView)
                labelView.removeFromSuperview()
            }
            else if labelView.text == hfjvString.HFJV_cmvPEEP.localized
            {
                stk.removeArrangedSubview(labelView)
                labelView.removeFromSuperview()
            }
            else
            {
                stk.insertArrangedSubview(stackLabel(text: str, stk), belowArrangedSubview: sender)
            }
            
        case hfjvString.rateSubTab.localized:
            //if labelView is UILabel
            let labelView = searchLabel(labelText: hfjvString.HFJV_cmvRate.localized, subviewArray: cmvArray)
            
            if labelView.text == hfjvString.HFJV_cmvRate.localized
            {
                cmvStack.removeArrangedSubview(labelView)
                labelView.removeFromSuperview()
            }
            else
            {
                cmvStack.insertArrangedSubview(stackLabel(text: hfjvString.HFJV_cmvRate.localized, cmvStack), belowArrangedSubview: sender)
            }
            
        case hfjvString.itimeSubTab.localized:
            //if labelView is UILabel
            let labelView = searchLabel(labelText: hfjvString.HFJV_cmvItime.localized, subviewArray: cmvArray)
            
            if labelView.text == hfjvString.HFJV_cmvItime.localized
            {
                cmvStack.removeArrangedSubview(labelView)
                labelView.removeFromSuperview()
            }
            else
            {
                cmvStack.insertArrangedSubview(stackLabel(text: hfjvString.HFJV_cmvItime.localized, cmvStack), belowArrangedSubview: sender)
            }
            
        case hfjvString.pipSubTab.localized:
            //if labelView is UILabel
            let labelView = searchLabel(labelText: hfjvString.HFJV_cmvPip.localized, subviewArray: cmvArray)
            
            if labelView.text == hfjvString.HFJV_cmvPip.localized
            {
                cmvStack.removeArrangedSubview(labelView)
                labelView.removeFromSuperview()
            }
            else
            {
                cmvStack.insertArrangedSubview(stackLabel(text: hfjvString.HFJV_cmvPip.localized, cmvStack), belowArrangedSubview: sender)
            }
            
        case hfjvString.slopeSubTab.localized:
            //if labelView is UILabel
            let labelView = searchLabel(labelText: hfjvString.HFJV_cmvSlope.localized, subviewArray: cmvArray)
            
            if labelView.text == hfjvString.HFJV_cmvSlope.localized
            {
                cmvStack.removeArrangedSubview(labelView)
                labelView.removeFromSuperview()
            }
            else
            {
                cmvStack.insertArrangedSubview(stackLabel(text: hfjvString.HFJV_cmvSlope.localized, cmvStack), belowArrangedSubview: sender)
            }
            
        case hfjvString.breathSubTab.localized:
            //if labelView is UILabel
            let labelView = searchLabel(labelText: hfjvString.HFJV_cmvBreath.localized, subviewArray: cmvArray)
            
            if labelView.text == hfjvString.HFJV_cmvBreath.localized
            {
                cmvStack.removeArrangedSubview(labelView)
                labelView.removeFromSuperview()
            }
            else
            {
                cmvStack.insertArrangedSubview(stackLabel(text: hfjvString.HFJV_cmvBreath.localized, cmvStack), belowArrangedSubview: sender)
            }
            
        //PRESSURE SUB TABS START HERE
        case hfjvString.incSubTab.localized:
            //if labelView is UILabel
            let labelView = searchLabel(labelText: hfjvString.HFJV_pressureIncrease.localized, subviewArray: servoArray)
            
            if labelView.text == hfjvString.HFJV_pressureIncrease.localized
            {
                servoStack.removeArrangedSubview(labelView)
                labelView.removeFromSuperview()
            }
            else
            {
                servoStack.insertArrangedSubview(stackLabel(text: hfjvString.HFJV_pressureIncrease.localized, servoStack), belowArrangedSubview: sender)
            }
            
        case hfjvString.decSubTab.localized:
            //if labelView is UILabel
            let labelView = searchLabel(labelText: hfjvString.HFJV_pressureDecrease.localized, subviewArray: servoArray)
            
            if labelView.text == hfjvString.HFJV_pressureDecrease.localized
            {
                servoStack.removeArrangedSubview(labelView)
                labelView.removeFromSuperview()
            }
            else
            {
                servoStack.insertArrangedSubview(stackLabel(text: hfjvString.HFJV_pressureDecrease.localized, servoStack), belowArrangedSubview: sender)
            }
            
        case hfjvString.flucSubTab.localized:
            //if labelView is UILabel
            let labelView = searchLabel(labelText: hfjvString.HFJV_pressureFlucuate.localized, subviewArray: servoArray)
            
            if labelView.text == hfjvString.HFJV_pressureFlucuate.localized
            {
                servoStack.removeArrangedSubview(labelView)
                labelView.removeFromSuperview()
            }
            else
            {
                servoStack.insertArrangedSubview(stackLabel(text: hfjvString.HFJV_pressureFlucuate.localized, servoStack), belowArrangedSubview: sender)
            }
            
        //RATE/FREQUENCY SUB TABS START HERE
        case hfjvString.lowFreqSubTab.localized:
            //if labelView is UILabel
            let labelView = searchLabel(labelText: hfjvString.HFJV_freqLow.localized, subviewArray: scrollArray)
            
            if labelView.text == hfjvString.HFJV_freqLow.localized
            {
                scrollStackView.removeArrangedSubview(labelView)
                labelView.removeFromSuperview()
            }
            else
            {
                scrollStackView.insertArrangedSubview(stackLabel(text: hfjvString.HFJV_freqLow.localized, scrollStackView), belowArrangedSubview: sender)
            }
            
        case hfjvString.highFreqSubTab.localized:
            //if labelView is UILabel
            let labelView = searchLabel(labelText: hfjvString.HFJV_freqHigh.localized, subviewArray: scrollArray)
            
            if labelView.text == hfjvString.HFJV_freqHigh.localized
            {
                scrollStackView.removeArrangedSubview(labelView)
                labelView.removeFromSuperview()
            }
            else
            {
                scrollStackView.insertArrangedSubview(stackLabel(text: hfjvString.HFJV_freqHigh.localized, scrollStackView), belowArrangedSubview: sender)
            }
            
        case hfjvString.xrayTab.localized:
            //if labelView is UILabel
            let labelView = searchLabel(labelText: hfjvString.HFJV_managementMonitorXray.localized, subviewArray: monitorArray)
            
            if labelView.text == hfjvString.HFJV_managementMonitorXray.localized
            {
                monitorStack.removeArrangedSubview(labelView)
                labelView.removeFromSuperview()
            }
            else
            {
                monitorStack.insertArrangedSubview(stackLabel(text: hfjvString.HFJV_managementMonitorXray.localized, monitorStack), belowArrangedSubview: sender)
            }
            
        case hfjvString.gasTab.localized:
            //if labelView is UILabel
            let labelView = searchLabel(labelText: hfjvString.HFJV_managementMonitorGas.localized, subviewArray: monitorArray)
            
            if labelView.text == hfjvString.HFJV_managementMonitorGas.localized
            {
                monitorStack.removeArrangedSubview(labelView)
                labelView.removeFromSuperview()
            }
            else
            {
                monitorStack.insertArrangedSubview(stackLabel(text: hfjvString.HFJV_managementMonitorGas.localized, monitorStack), belowArrangedSubview: sender)
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
            //btn.element.setTitle(hfjvString.allCases[index].localized, for: .normal)
            btn.element.configuration?.attributedTitle = AttributedString(hfjvString.allCases[index].localized, attributes: AttributeContainer([NSAttributedString.Key.font : UIFont(name: FONT_STYLE_ARIAL, size: FONT_SIZE_15)!]))
            //btn.element.heightAnchor.constraint(equalToConstant: 20).isActive = true
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
        stk.distribution = .fillProportionally
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
        cpapFlag = false
        cmvFlag = false
        monitorFlag = false
        
        //Handle scroll view stack
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
        
        //Handle YT Player
        if playerDetails.isDescendant(of: scrollEmbeddedView)
        {
            if menuButton.titleLabel?.text != MainString.Video.localized
            {
                playerDetails.removeFromSuperview()
            }
        }
        
        //Handle Mode stacks
        if cpapStack.isDescendant(of: scrollStackView)
        {
            for view in cpapStack.subviews
            {
                cpapStack.removeArrangedSubview(view)
                view.removeFromSuperview()
            }
            cpapStack.sizeToFit()
            cpapStack.layoutIfNeeded()
            cpapStack.removeFromSuperview()
        }
        if cmvStack.isDescendant(of: scrollStackView)
        {
            for view in cmvStack.subviews
            {
                cmvStack.removeArrangedSubview(view)
                view.removeFromSuperview()
            }
            cmvStack.sizeToFit()
            cmvStack.layoutIfNeeded()
            cmvStack.removeFromSuperview()
        }
        if servoStack.isDescendant(of: scrollStackView)
        {
            for view in servoStack.subviews
            {
                servoStack.removeArrangedSubview(view)
                view.removeFromSuperview()
            }
            servoStack.sizeToFit()
            servoStack.layoutIfNeeded()
            servoStack.removeFromSuperview()
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
