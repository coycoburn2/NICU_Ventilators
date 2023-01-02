//
//  PCPSV.swift
//  Coy_Test
//
//  Created by Coy Coburn on 11/4/22.
//

import Foundation

//If PCPSV locals indexes are changed, update macro
enum pcpsvString: String, CaseIterable {
    //Used by all Container views
    case PCPSV_what
    case PCPSV_when
    case PCPSV_settings
    case PCPSV_management
    case PCPSV_tips
    
    /*Settings Tab Titles - index 5*/
    case psvTab
    case rateTab
    case fioTab
    case inspTimeTab
    case inspPresTab
    case peepTab
    case ventMeasTab
    
    /*Settings Sub Tabs - index 11*/
    case mvSubTab
    case leakSubTab
    case mapTab
    
    /*Settings Tab Details*/
    case PCPSV_settingsPSV
    case PCPSV_settingsBackup
    case PCPSV_settingsFIO
    case PCPSV_settingsTime
    case PCPSV_settingsPressure
    case PCPSV_settingsPEEP
    case PCPSV_settingsVentMeas

    /*Settings Sub Tab Details*/
    case PCPSV_settingsMV
    case PCPSV_settingsLeak
    case PCPSV_settingsMAP
    
    /*Management Tab Details*/
    case PCPSV_managementBlood
    case PCPSV_managementIncGas
    case PCPSV_managementDecGas
    case PCPSV_managementHyper
    case PCPSV_managementHypo
    
    /*Tips Tab Details*/
    case PCPSV_tipsXray
    case PCPSV_tipsLeak
    case PCPSV_tipsGasTime
    case PCPSV_tipsTrans
    
    var localized: String {
        NSLocalizedString(self.rawValue, comment: "")
    }
}
