//
//  PCAC.swift
//  Coy_Test
//
//  Created by Coy Coburn on 11/3/22.
//

import Foundation

enum pcacString: String, CaseIterable {
    //Used by all Container views
    case PCAC_what
    case PCAC_when
    case PCAC_settings
    case PCAC_management
    case PCAC_tips
    
    /*Settings Tab Titles - index 5*/
    case volumeTab
    case rateTab
    case fioTab
    case inspTimeTab
    case inspPresTab
    case peepTab
    case ventMeasTab
    
    //Sub tab for tial volume only
    case pmaxSubTab
    
    /*Settings Sub Tabs - index 11*/
    case mvSubTab
    case leakSubTab
    case mapTab
    
    /*Settings Tab Details*/
    case PCAC_settingsVolume
    case PCAC_settingsBackup
    case PCAC_settingsFIO
    case PCAC_settingsTime
    case PCAC_settingsPressure
    case PCAC_settingsPEEP
    case PCAC_settingsVentMeas

    /*Settings Sub Tab Details*/
    case PCAC_settingsPmax
    case PCAC_settingsMV
    case PCAC_settingsLeak
    case PCAC_settingsMAP
    
    /*Management Tab Details*/
    case PCAC_managementBlood
    case PCAC_managementIncGas
    case PCAC_managementDecGas
    case PCAC_managementHyper
    case PCAC_managementHypo
    
    /*Tips Tab Details*/
    case PCAC_tipsXray
    case PCAC_tipsLeak
    case PCAC_tipsGasTime
    case PCAC_tipsTrans
    case PCAC_tipsSens
    case PCAC_tipsLowTidal

    
    var localized: String {
        NSLocalizedString(self.rawValue, comment: "")
    }
    
    var labelLocalized: String {
        NSLocalizedString(String(describing: Self.self) + "_\(rawValue)", comment: "")
    }
}
