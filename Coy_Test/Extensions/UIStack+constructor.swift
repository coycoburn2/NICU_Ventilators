//
//  UIStack+constructor.swift
//  Coy_Test
//
//  Created by Coy Coburn on 12/5/22.
//

import Foundation
import UIKit

lazy var scrollStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .vertical
    //stackView.spacing = STACK_SPACING
    stackView.alignment = .center
    return stackView
}()

//Template for details label during Settings/Management
func stackLabel(text: String) -> UILabel
{
    //NumOfLines wraps content. SetContentComp ensures label shows all of text
    let newLabel = UILabel()
    newLabel.text = text
    newLabel.numberOfLines = LABEL_WRAP
    newLabel.textAlignment = .left
    newLabel.setContentCompressionResistancePriority(.required, for: .vertical)
    return newLabel
}
