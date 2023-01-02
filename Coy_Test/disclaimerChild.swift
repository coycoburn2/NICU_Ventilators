//
//  disclaimerChild.swift
//  Coy_Test
//
//  Created by Coy Coburn on 12/7/22.
//

import Foundation
import UIKit

class disclaimerChild: UIViewController {
    
    @IBOutlet var scrollLabel: UILabel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        scrollLabel.text = MainString.Disclaimer.localized
    }
}
