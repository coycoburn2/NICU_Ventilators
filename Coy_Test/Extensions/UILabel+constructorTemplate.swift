//
//  UILabel+constructorTemplate.swift
//  Coy_Test
//
//  Created by Coy Coburn on 12/5/22.
//

import Foundation
import UIKit

/* Defined Macros */
let STACK_SPACING = 20.0
let LABEL_WRAP = 0

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
    return newLabel
}
