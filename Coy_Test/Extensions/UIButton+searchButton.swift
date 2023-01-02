//
//  UIButton+searchButton.swift
//  Coy_Test
//
//  Created by Coy Coburn on 12/12/22.
//

import Foundation
import UIKit
let FONT_STYLE_ARIAL = "Arial Rounded MT Bold"
let FONT_SIZE_15 = 15.0

func searchButton(labelText: String, subviewArray: Array<UIView>) -> UIButton
{
    var foundButton = UIButton()
    for view in subviewArray
    {
        if let btn = view as? UIButton
        {
            if labelText == btn.titleLabel?.text
            {
                //scrollStackView.removeArrangedSubview(label)
                //label.removeFromSuperview()
                //print("Index: ", buttonIndex)
                foundButton = btn
            }
        }
    }
    return foundButton
}
