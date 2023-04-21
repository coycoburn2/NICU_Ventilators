//
//  helperIntroChild.swift
//  NICU Ventilators
//
//  Created by Coy Coburn on 4/19/23.
//

import Foundation
import UIKit

class helperIntroChild: UIViewController {
    
    @IBOutlet weak var helperIntro: UILabel!
    @IBOutlet weak var helperBody: UILabel!
    @IBOutlet weak var helperScroll: UIScrollView!
    
    @IBOutlet weak var helperEmbeddedView: UIView!
    
    @IBOutlet weak var helperEmbeddedHeight: NSLayoutConstraint!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        helperIntro.text = MainString.helperLabel.localized
        helperBody.text = MainString.helperBody.localized
        helperScroll.sizeToFit()
        helperScroll.layoutIfNeeded()
        
        helperBody.layer.cornerRadius = 10
        helperBody.layer.masksToBounds = true
        
        helperEmbeddedHeight.constant = helperBody.intrinsicContentSize.height
        
        helperEmbeddedView.sizeToFit()
        helperEmbeddedView.layoutIfNeeded()
    }
    
    
    
}
