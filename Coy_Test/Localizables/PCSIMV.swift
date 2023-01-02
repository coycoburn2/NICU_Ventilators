//
//  PCSIMV.swift
//  Coy_Test
//
//  Created by Coy Coburn on 11/3/22.
//

import Foundation


enum pcsimvString: String, CaseIterable {
    //Used by all Container views 
    case PCSIMV_what
    case PCSIMV_when
    case PCSIMV_settings
    case PCSIMV_management
    case PCSIMV_tips
    
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
    
    /*Settings Sub Tabs - index 12*/
    case mvSubTab
    case leakSubTab
    case mapTab
    
    /*Settings Tab Details*/
    case PCSIMV_settingsVolume
    case PCSIMV_settingsBackup
    case PCSIMV_settingsFIO
    case PCSIMV_settingsTime
    case PCSIMV_settingsPressure
    case PCSIMV_settingsPEEP
    case PCSIMV_settingsVentMeas

    /*Settings Sub Tab Details*/
    case PCSIMV_settingsPmax
    case PCSIMV_settingsMV
    case PCSIMV_settingsLeak
    case PCSIMV_settingsMAP
    
    /*Management Tab Details*/
    case PCSIMV_managementBlood
    case PCSIMV_managementIncGas
    case PCSIMV_managementDecGas
    case PCSIMV_managementHyper
    case PCSIMV_managementHypo
    
    /*Tips Tab Details*/
    case PCSIMV_tipsXray
    case PCSIMV_tipsLeak
    case PCSIMV_tipsGasTime
    case PCSIMV_tipsTrans
    case PCSIMV_tipsSens
    case PCSIMV_tipsLowTidal
    
    var localized: String {
        NSLocalizedString(self.rawValue, comment: "")
    }
}
