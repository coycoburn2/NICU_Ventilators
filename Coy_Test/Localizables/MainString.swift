//
//  MainString.swift
//  Coy_Test
//
//  Created by Coy Coburn on 11/2/22.
//

import Foundation

//Used by all child classes
let PCXX_MANAGEMENT_INDEX = 24
let MANAGEMENT_INDEX = 27
let HFXX_TIPS_INDEX = 32

enum MainString: String, CaseIterable {
    case Text_holder
    case hello_blank_fragment
    case app_name
    case previous
    case conVent
    case hfjv
    case hfov
    case PCAC
    case PCSIMV
    case PCPSV
    case chooseVent
    case Dis
    case Disclaimer
    case referencesLabel
    case References
    
    //Used by all Container views - 14
    case What
    case When
    case Settings
    case Management
    case Monitoring
    case Weaning
    case Tips
    case Manuals
    case Video
    case MainMenu
    
    /*Settings tab - moved to reference each child class in respective local.swift files*/
    
    /*PCXX Management tab only - 24*/
    case bloodTab
    case ioxyTab
    case doxyTab
    
    /*Management tab used by all - 27*/
    case hyperTab
    case hypoTab
    case lungTab
    case monitorTab
    case weaningTab
    
    /*HFXX Tips Tab - 32*/
    case xrayTab
    case leakTab
    case gasTimeTab
    case transTab
    case sensTab
    case lowTidalTab
    
    var localized: String {
        NSLocalizedString(self.rawValue, comment: "")
    }
}
