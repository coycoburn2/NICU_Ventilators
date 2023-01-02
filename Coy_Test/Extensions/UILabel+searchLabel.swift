//
//  UILabel+searchLabel.swift
//  Coy_Test
//
//  Created by Coy Coburn on 12/5/22.
//

import Foundation
import UIKit

func searchLabel(labelText: String, subviewArray: Array<UIView>) -> UILabel
{
    var foundLabel = UILabel()
    for view in subviewArray
    {
        if let label = view as? UILabel
        {
            if labelText == label.text
            {
                //scrollStackView.removeArrangedSubview(label)
                //label.removeFromSuperview()
                //print("Index: ", buttonIndex)
                foundLabel = label
            }
        }
    }
    return foundLabel
}
