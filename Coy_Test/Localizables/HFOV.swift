//
//  HFOV.swift
//  Coy_Test
//
//  Created by Coy Coburn on 11/6/22.
//

import Foundation

//If HFJV locals indexes are changed, update this macro
enum hfovString: String, CaseIterable {
    case HFOV_what
    case HFOV_when
    case HFOV_settings
    case HFOV_management
    case HFOV_monitoring
    case HFOV_tips
    
    /*Settings Tab Titles - index 6*/
    case pawTab
    case biasTab
    case deltaTab
    case freqTab
    case ieTab
    case powerTab
    
    /*Management Gas Sub Tabs - 12*/
    case gasFiveTab
    case gasSixTab
    
    /*Videos Tab Titles*/
    case freqVentOneTab
    case freqVentTwoTab
    case oscillatorOneTab
    case oscillatorTwoTab
    
    /*Videos IDs*/
    case freqOneVideo
    case freqTwoVideo
    case oscOneVideo
    case oscTwoVideo
    
    /*Settings Tab Details*/
    case HFOV_settingsMap
    case HFOV_settingsBias
    case HFOV_settingsDelta
    case HFOV_settingsFreq
    case HFOV_settingsIERatio
    case HFOV_settingsPower
    
    /*Management Tab Details*/
    case HFOV_managementHyper
    case HFOV_managementHypo
    case HFOV_managementLung
    case HFOV_managementMonitorXray
    case HFOV_managementMonitorGas
    case HFOV_managementWeaning
    
    /*Gas Management SubTab Details*/
    case HFOV_managementGasFive
    case HFOV_managementGasSix
    case xrayTab
    case gasTab
    
    var localized: String {
        NSLocalizedString(self.rawValue, comment: "")
    }
}
