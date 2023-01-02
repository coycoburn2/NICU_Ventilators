//
//  ChooseVentChild.swift
//  Coy_Test
//
//  Created by Coy Coburn on 11/2/22.
//

import UIKit

//If PCAC locals indexes are changed, update this macro
let PCAC_SETTINGS_INDEX = 4
let PCAC_SETTINGS_SUBTAB_INDEX = 12

class pcacChild: UIViewController {
       
    @IBOutlet var menuButton: UIButton!
    @IBOutlet weak var scrollDetails: UILabel!
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
    
    lazy var ventMeasStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        return stackView
    }()
    
    //UIButton.Configuration is for iOS 15 or greater
    var buttonConfig = UIButton.Configuration.gray()
    var subTabConfig = UIButton.Configuration.gray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        scrollDetails.text = pcacString.PCAC_what.localized
        titleLabel.text = MainString.PCAC.localized

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
        self.scrollDetails.isUserInteractionEnabled = false
    }
    
    func addMenuItems() -> UIMenu
    {
        let menuItems = UIMenu(title: "", options: .displayInline, children: [
            
            UIAction(title: MainString.What.localized, handler: { (_) in
                self.scrollDetails.text = pcacString.PCAC_what.localized
                self.removeSubButtons()
                self.scrollDetails.isUserInteractionEnabled = false
                self.resizeScrollEmbeddedView()
            }),
            
            UIAction(title: MainString.When.localized, handler: { (_) in
                self.scrollDetails.text = pcacString.PCAC_when.localized
                self.removeSubButtons()
                self.scrollDetails.isUserInteractionEnabled = false
                self.resizeScrollEmbeddedView()
            }),
            
            UIAction(title: MainString.Settings.localized, handler: { (_) in
                self.scrollDetails.text = ""
                self.scrollDetails.isUserInteractionEnabled = false
                self.removeSubButtons()
                let tabText = MainString.Settings.localized
                self.createSubButtons(buttonText: tabText)
            }),
            
            UIAction(title: MainString.Management.localized, handler: { (_) in
                self.scrollDetails.text = ""
                self.scrollDetails.isUserInteractionEnabled = false
                self.removeSubButtons()
                let tabText = MainString.Management.localized
                self.createSubButtons(buttonText: tabText)
            }),
            
            UIAction(title: MainString.Tips.localized, handler: { (_) in
                self.scrollDetails.text = ""
                self.removeSubButtons()
                self.scrollDetails.isUserInteractionEnabled = false
                self.resizeScrollEmbeddedView()
                let tabText = MainString.Tips.localized
                self.createSubButtons(buttonText: tabText)
            }),
        ])
        return menuItems
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
                    
        scrollEmbeddedHeight.constant = subviewHeight
        scrollEmbeddedView.layoutIfNeeded()
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
                let bloodButton = UIButton(configuration: buttonConfig)
                let ioxyButton = UIButton(configuration: buttonConfig)
                let doxyButton = UIButton(configuration: buttonConfig)
                let hyperButton = UIButton(configuration: buttonConfig)
                let hypoButton = UIButton(configuration: buttonConfig)
                
                let manButtons = [bloodButton, ioxyButton, doxyButton, hyperButton, hypoButton]
                var enumIndex = pcacManagementIndex.allCases.startIndex
                var titleIndex = MainString.allCases.index(after: PCXX_MANAGEMENT_INDEX)
                            
                for button in manButtons
                {
                    //Assign action to take when pressed
                    button.addTarget(self, action: #selector(subButtonPressed(_:)), for: .touchUpInside)
                    button.heightAnchor.constraint(equalToConstant: 20).isActive = true
                    button.configuration?.attributedTitle = AttributedString(MainString.allCases[titleIndex].localized, attributes: AttributeContainer([NSAttributedString.Key.font : UIFont(name: FONT_STYLE_ARIAL, size: FONT_SIZE_15)!]))
                    button.sizeToFit()
                    
                    //Add buttons to new stack
                    scrollStackView.insertArrangedSubview(button, at: enumIndex)
                    enumIndex = enumIndex + 1
                    titleIndex = titleIndex + 1
                    
                }
                break
                
            case MainString.Settings.localized:
                let volumeButton = UIButton(configuration: buttonConfig)
                let rateButton = UIButton(configuration: buttonConfig)
                let fioButton = UIButton(configuration: buttonConfig)
                let inspTimeButton = UIButton(configuration: buttonConfig)
                let inspPresButton = UIButton(configuration: buttonConfig)
                let peepButton = UIButton(configuration: buttonConfig)
                let backupButton = UIButton(configuration: buttonConfig)
                
                let setButtons = [volumeButton, rateButton, fioButton, inspTimeButton, inspPresButton, peepButton, backupButton]
                var enumIndex = pcacManagementIndex.allCases.startIndex
                var titleIndex = pcacString.allCases.index(after: PCAC_SETTINGS_INDEX)
                
                for button in setButtons
                {
                    //Assign action to take when pressed
                    button.addTarget(self, action: #selector(subButtonPressed(_:)), for: .touchUpInside)
                    button.heightAnchor.constraint(equalToConstant: 20).isActive = true
                    button.configuration?.attributedTitle = AttributedString(pcacString.allCases[titleIndex].localized, attributes: AttributeContainer([NSAttributedString.Key.font : UIFont(name: FONT_STYLE_ARIAL, size: FONT_SIZE_15)!]))
                    button.sizeToFit()
                    
                    //Add buttons to new stack
                    scrollStackView.insertArrangedSubview(button, at: enumIndex)
                    enumIndex = enumIndex + 1
                    titleIndex = titleIndex + 1
                    
                }
                break
            
            case MainString.Tips.localized:
                let xrayButton = UIButton(configuration: buttonConfig)
                let leakButton = UIButton(configuration: buttonConfig)
                let gasTimeButton = UIButton(configuration: buttonConfig)
                let transButton = UIButton(configuration: buttonConfig)
                let sensButton = UIButton(configuration: buttonConfig)
                let lowTidalButton = UIButton(configuration: buttonConfig)
                
                let setButtons = [xrayButton, leakButton, gasTimeButton, transButton, sensButton, lowTidalButton]
                var enumIndex = pcacTipsIndex.allCases.startIndex
                var titleIndex = MainString.allCases.index(after: HFXX_TIPS_INDEX)
                
                for button in setButtons
                {
                    //Assign action to take when pressed
                    button.addTarget(self, action: #selector(subButtonPressed(_:)), for: .touchUpInside)
                    button.heightAnchor.constraint(equalToConstant: 20).isActive = true
                    button.configuration?.attributedTitle = AttributedString(MainString.allCases[titleIndex].localized, attributes: AttributeContainer([NSAttributedString.Key.font : UIFont(name: FONT_STYLE_ARIAL, size: FONT_SIZE_15)!]))
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
        let ventMeasArray = ventMeasStack.subviews
        
        switch(buttonTitleString)
        {
        //SETTINGS TABS START HERE
        case pcacString.volumeTab.localized:
            //if labelView is UILabel
            var labelView = searchLabel(labelText: pcacString.PCAC_settingsVolume.localized, subviewArray: subviewArray)
            
            if labelView.text == pcacString.PCAC_settingsVolume.localized
            {
                //Cache labelView so we can remove it last
                let temp = labelView
                
                //Starting from bottom of stack to top for this removal case
                labelView = searchLabel(labelText: pcacString.PCAC_settingsPmax.localized, subviewArray: subviewArray)
                if labelView.text == pcacString.PCAC_settingsPmax.localized
                {
                    scrollStackView.removeArrangedSubview(labelView)
                    labelView.removeFromSuperview()
                }
                
                //Remove the embedded button under Volume tab
                for subTab in subviewArray
                {
                    if let sub = subTab as? UIButton
                    {
                        if sub.titleLabel?.text == pcacString.pmaxSubTab.localized
                        {
                            scrollStackView.removeArrangedSubview(sub)
                            sub.removeFromSuperview()
                        }
                    }
                }
                scrollStackView.removeArrangedSubview(temp)
                temp.removeFromSuperview()
            }
            else
            {
                let volumeLabel = stackLabel(text: pcacString.PCAC_settingsVolume.localized, scrollStackView)
                let pmaxButton = UIButton(configuration: subTabConfig)
                
                //Assign action to take when pressed
                pmaxButton.addTarget(self, action: #selector(subButtonPressed(_:)), for: .touchUpInside)
                pmaxButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
                pmaxButton.configuration?.attributedTitle = AttributedString(pcacString.pmaxSubTab.localized, attributes: AttributeContainer([NSAttributedString.Key.font : UIFont(name: FONT_STYLE_ARIAL, size: FONT_SIZE_15)!]))
                pmaxButton.sizeToFit()
                
                scrollStackView.insertArrangedSubview(volumeLabel, belowArrangedSubview: sender)
                scrollStackView.insertArrangedSubview(pmaxButton, belowArrangedSubview: volumeLabel)
                
            }
            
        case pcacString.pmaxSubTab.localized:
            
            //if labelView is UILabel
            let labelView = searchLabel(labelText: pcacString.PCAC_settingsPmax.localized, subviewArray: subviewArray)
            
            if labelView.text == pcacString.PCAC_settingsPmax.localized
            {
                scrollStackView.removeArrangedSubview(labelView)
                labelView.removeFromSuperview()
            }
            else
            {
                scrollStackView.insertArrangedSubview(stackLabel(text: pcacString.PCAC_settingsPmax.localized, scrollStackView), belowArrangedSubview: sender)
            }
            
        case pcacString.rateTab.localized:
            //if labelView is UILabel
            let labelView = searchLabel(labelText: pcacString.PCAC_settingsBackup.localized, subviewArray: subviewArray)
            
            if labelView.text == pcacString.PCAC_settingsBackup.localized
            {
                scrollStackView.removeArrangedSubview(labelView)
                labelView.removeFromSuperview()
            }
            else
            {
                scrollStackView.insertArrangedSubview(stackLabel(text: pcacString.PCAC_settingsBackup.localized, scrollStackView), belowArrangedSubview: sender)
            }
            
        case pcacString.fioTab.localized:
            //if labelView is UILabel
            let labelView = searchLabel(labelText: pcacString.PCAC_settingsFIO.localized, subviewArray: subviewArray)
            
            if labelView.text == pcacString.PCAC_settingsFIO.localized
            {
                scrollStackView.removeArrangedSubview(labelView)
                labelView.removeFromSuperview()
            }
            else
            {
                scrollStackView.insertArrangedSubview(stackLabel(text: pcacString.PCAC_settingsFIO.localized, scrollStackView), belowArrangedSubview: sender)
            }
            
        case pcacString.fioTab.localized:
            //if labelView is UILabel
            let labelView = searchLabel(labelText: pcacString.PCAC_settingsFIO.localized, subviewArray: subviewArray)
            
            if labelView.text == pcacString.PCAC_settingsFIO.localized
            {
                scrollStackView.removeArrangedSubview(labelView)
                labelView.removeFromSuperview()
            }
            else
            {
                scrollStackView.insertArrangedSubview(stackLabel(text: pcacString.PCAC_settingsFIO.localized, scrollStackView), belowArrangedSubview: sender)
            }
            
        
        case pcacString.inspTimeTab.localized:
            //if labelView is UILabel
            let labelView = searchLabel(labelText: pcacString.PCAC_settingsTime.localized, subviewArray: subviewArray)
            
            if labelView.text == pcacString.PCAC_settingsTime.localized
            {
                scrollStackView.removeArrangedSubview(labelView)
                labelView.removeFromSuperview()
            }
            else
            {
                scrollStackView.insertArrangedSubview(stackLabel(text: pcacString.PCAC_settingsTime.localized, scrollStackView), belowArrangedSubview: sender)
            }
            
        case pcacString.inspPresTab.localized:
            //if labelView is UILabel
            let labelView = searchLabel(labelText: pcacString.PCAC_settingsPressure.localized, subviewArray: subviewArray)
            
            if labelView.text == pcacString.PCAC_settingsPressure.localized
            {
                scrollStackView.removeArrangedSubview(labelView)
                labelView.removeFromSuperview()
            }
            else
            {
                scrollStackView.insertArrangedSubview(stackLabel(text: pcacString.PCAC_settingsPressure.localized, scrollStackView), belowArrangedSubview: sender)
            }
            
        case pcacString.peepTab.localized:
            //if labelView is UILabel
            let labelView = searchLabel(labelText: pcacString.PCAC_settingsPEEP.localized, subviewArray: subviewArray)
            
            if labelView.text == pcacString.PCAC_settingsPEEP.localized
            {
                scrollStackView.removeArrangedSubview(labelView)
                labelView.removeFromSuperview()
            }
            else
            {
                scrollStackView.insertArrangedSubview(stackLabel(text: pcacString.PCAC_settingsPEEP.localized, scrollStackView), belowArrangedSubview: sender)
            }
            
        //Ventilator Measurements and Sub Tabs
        case pcacString.ventMeasTab.localized:
            //if labelView is UILabel
            var labelView = searchLabel(labelText: pcacString.PCAC_settingsVentMeas.localized, subviewArray: subviewArray)
            
            if labelView.text == pcacString.PCAC_settingsVentMeas.localized
            {
                //Cache labelView so we can remove it last
                let temp = labelView
                
                //Remove the nested stack
                removeModeStack(&ventMeasStack)
                
                //Final label to remove
                scrollStackView.removeArrangedSubview(temp)
                temp.removeFromSuperview()
                
            }
            else
            {
                labelView = stackLabel(text: pcacString.PCAC_settingsVentMeas.localized, scrollStackView)
                let mvButton = UIButton(configuration: subTabConfig)
                let leakButton = UIButton(configuration: subTabConfig)
                let mapButton = UIButton(configuration: subTabConfig)
                
                var titleIndex = pcacTipsIndex.allCases.index(after: PCAC_SETTINGS_SUBTAB_INDEX)
                
                let buttons = [mvButton, leakButton, mapButton]
                
                scrollStackView.insertArrangedSubview(labelView, belowArrangedSubview: sender)
                
                //Build nested stack
                populateStack(labelView, buttons, &titleIndex, &ventMeasStack)
            }
            
        case pcacString.mvSubTab.localized:
            //if labelView is UILabel
            let labelView = searchLabel(labelText: pcacString.PCAC_settingsMV.localized, subviewArray: ventMeasArray)
            
            if labelView.text == pcacString.PCAC_settingsMV.localized
            {
                ventMeasStack.removeArrangedSubview(labelView)
                labelView.removeFromSuperview()
            }
            else
            {
                ventMeasStack.insertArrangedSubview(stackLabel(text: pcacString.PCAC_settingsMV.localized, ventMeasStack), belowArrangedSubview: sender)
            }
            
        case pcacString.mapTab.localized:
            //if labelView is UILabel
            let labelView = searchLabel(labelText: pcacString.PCAC_settingsMAP.localized, subviewArray: ventMeasArray)
            
            if labelView.text == pcacString.PCAC_settingsMAP.localized
            {
                ventMeasStack.removeArrangedSubview(labelView)
                labelView.removeFromSuperview()
            }
            else
            {
                ventMeasStack.insertArrangedSubview(stackLabel(text: pcacString.PCAC_settingsMAP.localized, ventMeasStack), belowArrangedSubview: sender)
            }
            
        //MANAGEMENT TABS START HERE
        case MainString.bloodTab.localized:
            //if labelView is UILabel
            let labelView = searchLabel(labelText: pcacString.PCAC_managementBlood.localized, subviewArray: subviewArray)
            
            if labelView.text == pcacString.PCAC_managementBlood.localized
            {
                scrollStackView.removeArrangedSubview(labelView)
                labelView.removeFromSuperview()
            }
            else
            {
                scrollStackView.insertArrangedSubview(stackLabel(text: pcacString.PCAC_managementBlood.localized, scrollStackView), belowArrangedSubview: sender)
            }
            
        case MainString.ioxyTab.localized:
            //if labelView is UILabel
            let labelView = searchLabel(labelText: pcacString.PCAC_managementIncGas.localized, subviewArray: subviewArray)
            
            if labelView.text == pcacString.PCAC_managementIncGas.localized
            {
                scrollStackView.removeArrangedSubview(labelView)
                labelView.removeFromSuperview()
            }
            else
            {
                scrollStackView.insertArrangedSubview(stackLabel(text: pcacString.PCAC_managementIncGas.localized, scrollStackView), belowArrangedSubview: sender)
            }
            
        case MainString.doxyTab.localized:
            //if labelView is UILabel
            let labelView = searchLabel(labelText: pcacString.PCAC_managementDecGas.localized, subviewArray: subviewArray)
            
            if labelView.text == pcacString.PCAC_managementDecGas.localized
            {
                scrollStackView.removeArrangedSubview(labelView)
                labelView.removeFromSuperview()
            }
            else
            {
                scrollStackView.insertArrangedSubview(stackLabel(text: pcacString.PCAC_managementDecGas.localized, scrollStackView), belowArrangedSubview: sender)
            }
            
        case MainString.hyperTab.localized:
            //if labelView is UILabel
            let labelView = searchLabel(labelText: pcacString.PCAC_managementHyper.localized, subviewArray: subviewArray)
            
            if labelView.text == pcacString.PCAC_managementHyper.localized
            {
                scrollStackView.removeArrangedSubview(labelView)
                labelView.removeFromSuperview()
            }
            else
            {
                scrollStackView.insertArrangedSubview(stackLabel(text: pcacString.PCAC_managementHyper.localized, scrollStackView), belowArrangedSubview: sender)
            }
            
        case MainString.hypoTab.localized:
            //if labelView is UILabel
            let labelView = searchLabel(labelText: pcacString.PCAC_managementHypo.localized, subviewArray: subviewArray)
            
            if labelView.text == pcacString.PCAC_managementHypo.localized
            {
                scrollStackView.removeArrangedSubview(labelView)
                labelView.removeFromSuperview()
            }
            else
            {
                scrollStackView.insertArrangedSubview(stackLabel(text: pcacString.PCAC_managementHypo.localized, scrollStackView), belowArrangedSubview: sender)
            }
            
        //TIPS START HERE
        case MainString.xrayTab.localized:
            //if labelView is UILabel
            let labelView = searchLabel(labelText: pcacString.PCAC_tipsXray.localized, subviewArray: subviewArray)
            
            if labelView.text == pcacString.PCAC_tipsXray.localized
            {
                scrollStackView.removeArrangedSubview(labelView)
                labelView.removeFromSuperview()
            }
            else
            {
                scrollStackView.insertArrangedSubview(stackLabel(text: pcacString.PCAC_tipsXray.localized, scrollStackView), belowArrangedSubview: sender)
            }
            
        case MainString.leakTab.localized:
            //if labelView is UILabel
            var labelView = UILabel()
            
            if(sender.isDescendant(of: ventMeasStack))
            {
                labelView = searchLabel(labelText: pcacString.PCAC_settingsLeak.localized, subviewArray: ventMeasArray)
                
                if labelView.text == pcacString.PCAC_settingsLeak.localized
                {
                    ventMeasStack.removeArrangedSubview(labelView)
                    labelView.removeFromSuperview()
                }
                else
                {
                    ventMeasStack.insertArrangedSubview(stackLabel(text: pcacString.PCAC_settingsLeak.localized, ventMeasStack), belowArrangedSubview: sender)
                }
            }
            else
            {
                labelView = searchLabel(labelText: pcacString.PCAC_tipsLeak.localized, subviewArray: subviewArray)
                
                if labelView.text == pcacString.PCAC_tipsLeak.localized
                {
                    scrollStackView.removeArrangedSubview(labelView)
                    labelView.removeFromSuperview()
                }
                else
                {
                    scrollStackView.insertArrangedSubview(stackLabel(text: pcacString.PCAC_tipsLeak.localized, scrollStackView), belowArrangedSubview: sender)
                }
            }
            
        case MainString.gasTimeTab.localized:
            //if labelView is UILabel
            let labelView = searchLabel(labelText: pcacString.PCAC_tipsGasTime.localized, subviewArray: subviewArray)
            
            if labelView.text == pcacString.PCAC_tipsGasTime.localized
            {
                scrollStackView.removeArrangedSubview(labelView)
                labelView.removeFromSuperview()
            }
            else
            {
                scrollStackView.insertArrangedSubview(stackLabel(text: pcacString.PCAC_tipsGasTime.localized, scrollStackView), belowArrangedSubview: sender)
            }
            
        case MainString.transTab.localized:
            //if labelView is UILabel
            let labelView = searchLabel(labelText: pcacString.PCAC_tipsTrans.localized, subviewArray: subviewArray)
            
            if labelView.text == pcacString.PCAC_tipsTrans.localized
            {
                scrollStackView.removeArrangedSubview(labelView)
                labelView.removeFromSuperview()
            }
            else
            {
                scrollStackView.insertArrangedSubview(stackLabel(text: pcacString.PCAC_tipsTrans.localized, scrollStackView), belowArrangedSubview: sender)
            }
            
        case MainString.sensTab.localized:
            //if labelView is UILabel
            let labelView = searchLabel(labelText: pcacString.PCAC_tipsSens.localized, subviewArray: subviewArray)
            
            if labelView.text == pcacString.PCAC_tipsSens.localized
            {
                scrollStackView.removeArrangedSubview(labelView)
                labelView.removeFromSuperview()
            }
            else
            {
                scrollStackView.insertArrangedSubview(stackLabel(text: pcacString.PCAC_tipsSens.localized, scrollStackView), belowArrangedSubview: sender)
            }
            
        case MainString.lowTidalTab.localized:
            //if labelView is UILabel
            let labelView = searchLabel(labelText: pcacString.PCAC_tipsLowTidal.localized, subviewArray: subviewArray)
            
            if labelView.text == pcacString.PCAC_tipsLowTidal.localized
            {
                scrollStackView.removeArrangedSubview(labelView)
                labelView.removeFromSuperview()
            }
            else
            {
                scrollStackView.insertArrangedSubview(stackLabel(text: pcacString.PCAC_tipsLowTidal.localized, scrollStackView), belowArrangedSubview: sender)
            }
            
        default: break
        }
        
        scrollStackView.sizeToFit()
        scrollStackView.layoutIfNeeded()
        resizeScrollEmbeddedView()
    }
    
    //Populate sub tab stack for Modes
    func populateStack(_ sender: UIView, _ buttons: [UIButton], _ index: inout Int, _ stk: inout UIStackView)
    {
        scrollStackView.insertArrangedSubview(stk, belowArrangedSubview: sender)
        stk.translatesAutoresizingMaskIntoConstraints = false
        stk.leadingAnchor.constraint(equalTo: scrollStackView.leadingAnchor).isActive = true
        stk.trailingAnchor.constraint(equalTo: scrollStackView.trailingAnchor).isActive = true
        for btn in buttons.enumerated()
        {
            //Assign action to take when pressed
            btn.element.addTarget(self, action: #selector(subButtonPressed(_:)), for: .touchUpInside)
            btn.element.configuration?.attributedTitle = AttributedString(pcacString.allCases[index].localized, attributes: AttributeContainer([NSAttributedString.Key.font : UIFont(name: FONT_STYLE_ARIAL, size: FONT_SIZE_15)!]))
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
    }
}
