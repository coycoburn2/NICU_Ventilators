//
//  HFJV.swift
//  Coy_Test
//
//  Created by Coy Coburn on 11/6/22.
//

import Foundation

//If HFJV locals indexes are changed, update macro
enum hfjvString: String, CaseIterable {
    case HFJV_what
    case HFJV_when
    case HFJV_settings
    case HFJV_management
    case HFJV_monitoring
    case HFJV_tips
    case HFJV_links
    case Bunnell_manual
    case Bunnell_video
    
    /*Settings Tab Titles - index 9*/
    case pipTab
    case forTab
    case inspiratoryTab
    case deltaTab
    case pressureTab
    case peepTab
    case backupTab
    
    /*Mode Sub Tabs - 16*/
    case cpapSubTab
    case cmvSubTab
    
    /*Settings Sub Tabs - 18*/
    case pinspSubTab
    case peepSubTab
    case rateSubTab
    case itimeSubTab
    case pipSubTab
    case slopeSubTab
    case breathSubTab
    
    /*Management Gas Sub Tabs - 25*/
    case gasOneTab
    case gasTwoTab
    case gasThreeTab
    case gasFourTab
    
    /*Overview Sub Tabs*/
    case advSubTab
    case flowSubTab
    case HFJV_advantagesOne
    case HFJV_transitionalFlow
    case HFJV_advantagesTwo
    
    /*Pressure Sub Tabs*/
    case incSubTab
    case decSubTab
    case flucSubTab
    
    /*Rate/Frequency Sub Tab*/
    case lowFreqSubTab
    case highFreqSubTab
    
    /*Settings Tab Details*/
    case HFJV_settingsPip
    case HFJV_settingsFreq
    case HFJV_settingsInspiratory
    case HFJV_settingsDelta
    case HFJV_settingsPressure
    case HFJV_settingsPeep
    case HFJV_settingsBackup
    
    /*Management Tab Details*/
    case HFJV_managementHyper
    case HFJV_managementHypo
    case HFJV_managementLung
    case HFJV_managementMonitorXray
    case HFJV_managementMonitorGas
    case HFJV_managementWeaning
    
    /*Backup con vent SubTab Details*/
    case HFJV_cpapPinsp
    case HFJV_cpapPEEP
    case HFJV_cmvRate
    case HFJV_cmvPEEP
    case HFJV_cmvItime
    case HFJV_cmvPip
    case HFJV_cmvSlope
    case HFJV_cmvBreath
    
    /*Pressure SubTab Details*/
    case HFJV_pressureIncrease
    case HFJV_pressureDecrease
    case HFJV_pressureFlucuate
    
    /*Rate/Frequency SubTab Details*/
    case HFJV_freqLow
    case HFJV_freqHigh
    
    /*Gas Management SubTab Details*/
    case HFJV_managementGasOne
    case HFJV_managementGasTwo
    case HFJV_managementGasThree
    case HFJV_managementGasFour
    case xrayTab
    case gasTab
    
    var localized: String {
        NSLocalizedString(self.rawValue, comment: "")
    }
}
