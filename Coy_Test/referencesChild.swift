//
//  referencesChild.swift
//  Coy_Test
//
//  Created by Coy Coburn on 11/22/22.
//

import Foundation
import UIKit

class referencesChild: UIViewController {
    
    @IBOutlet weak var scrollLabel: UILabel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        scrollLabel.text = MainString.References.localized
    }
}
